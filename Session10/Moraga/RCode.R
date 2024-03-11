# Example Moraga book

library(lwgeom)
library(raster)

m <- getData(name = "GADM", country = "Spain", level = 0)
plot(m)

# keep only mainland
library(sf)
library(dplyr)

m <- m %>%
  st_as_sf() %>%
  st_cast("POLYGON") %>%
  mutate(area = st_area(.)) %>%
  arrange(desc(area)) %>%
  slice(1)
#
library(ggplot2)

ggplot(m) + geom_sf() + theme_bw()

m <- m %>% st_transform(25830)
ggplot(m) + geom_sf() + theme_bw() + coord_sf(datum = st_crs(m))

#### Read data
d <- read.csv("dataPM25.csv")

d <- d[, c(
  "ReportingYear", "StationLocalId",
  "SamplingPoint_Longitude",
  "SamplingPoint_Latitude",
  "AQValue"
)]
names(d) <- c("year", "id", "long", "lat", "value")

## change crs
library(sf)
### project the data
p <- st_as_sf(data.frame(long = d$long, lat = d$lat),
              coords = c("long", "lat"))
st_crs(p) <- st_crs(4326)
p <- p %>% st_transform(25830)
d[, c("x", "y")] <- st_coordinates(p)

# keep station in the main territory of Spain
ind <- st_intersects(m, p)
d <- d[ind[[1]], ]

ggplot(m) + geom_sf() + coord_sf(datum = st_crs(m)) +
  geom_point(data = d, aes(x = x, y = y)) + theme_bw()

# plot 3 years of data
library(viridis)

ggplot(m) + geom_sf() + coord_sf(datum = NA) +
  geom_point(
    data = d, aes(x = x, y = y, color = value),
    size = 2
  ) +
  labs(x = "", y = "") +
  scale_color_viridis() +
  facet_wrap(~year) +
  theme_bw()

### Models ####
library(INLA)

# mesh
sc<- 1/1000 ##scaling
coo <- cbind(d$x, d$y)*sc
bnd <- inla.nonconvex.hull(st_coordinates(m)[, 1:2]*sc)
mesh <- inla.mesh.2d(
  loc = coo, boundary = bnd,
  max.edge = c(100000, 200000)*sc, cutoff = 1000*sc
)

plot(mesh)
points(coo, col = "red")

# spde
spde <- inla.spde2.pcmatern(
  mesh = mesh, alpha = 2, constr = TRUE,
  prior.range = c(10000, 0.01), # P(range < 10000) = 0.01
  prior.sigma = c(3, 0.01) # P(sigma > 3) = 0.01
)

spde$n.spde

# index set
timesn <- length(unique(d$year))
indexs <- inla.spde.make.index("s",
                               n.spde = spde$n.spde,
                               n.group = timesn
)
lengths(indexs)

# Projection matrix
group <- d$year - min(d$year) + 1
A <- inla.spde.make.A(mesh = mesh, loc = coo, group = group)


# Prediction data
bb <- st_bbox(m)
x <- seq(bb$xmin - 1, bb$xmax + 1, length.out = 50)
y <- seq(bb$ymin - 1, bb$ymax + 1, length.out = 50)
dp <- as.matrix(expand.grid(x, y))
plot(dp, asp = 1)

# keep only locations within borders of spain
p <- st_as_sf(data.frame(x = dp[, 1], y = dp[, 2]),
              coords = c("x", "y")
)
st_crs(p) <- st_crs(25830)
ind <- st_intersects(m, p)
dp <- dp[ind[[1]], ]
plot(dp, asp = 1)

# Now we construct the data that includes the coordinates and 
#the three times by repeating dp three times and adding a column denoting the times. 
#Here time 1 is 2015, time 2 is 2016, and time 3 is 2017.

dp <- rbind(cbind(dp, 1), cbind(dp, 2), cbind(dp, 3))
head(dp)


# A matrix for predictions
coop <- dp[, 1:2]
groupp <- dp[, 3]
n_group = 3
Ap <- inla.spde.make.A(mesh = mesh, loc = coop, group = groupp, n.group=3)


# Stacks
stk.e <- inla.stack(
  tag = "est",
  data = list(y = d$value),
  A = list(1, A),
  effects = list(data.frame(b0 = rep(1, nrow(d))), s = indexs)
)

stk.p <- inla.stack(
  tag = "pred",
  data = list(y = NA),
  A = list(1, Ap),
  effects = list(data.frame(b0 = rep(1, nrow(dp))), s = indexs)
)

stk.full <- inla.stack(stk.e, stk.p)


# formula
rprior <- list(theta = list(prior = "pccor1", param = c(0, 0.9)))

formula = y ~ -1 + b0 + f(s,
                          model = spde, group = s.group,
                          control.group = list(model = "ar1", hyper = rprior))

inla.setOption(inla.mode="experimental")
# https://github.com/julianfaraway/rexamples/blob/main/mixed/jspmultilevel.md

# inla call
fit <- inla(formula,
            data = inla.stack.data(stk.full, spde=spde),
            family = "gaussian",
           control.predictor = list(A = inla.stack.A(stk.full), 
                                    compute = TRUE),
            control.compute = list(return.marginals.predictor = TRUE), control.inla=list(cmin=0),
verbose = TRUE)  

fit$summary.fixed
            
fit$summary.hyperpar


# Map
index <- inla.stack.index(stack = stk.full, tag = "pred")$data

dp <- data.frame(dp)
names(dp) <- c("x", "y", "time")

dp$pred_mean <- fit$summary.fitted.values[index, "mean"]
dp$pred_ll <- fit$summary.fitted.values[index, "0.025quant"]
dp$pred_ul <- fit$summary.fitted.values[index, "0.975quant"]


library(reshape2)
dpm <- melt(dp,
            id.vars = c("x", "y", "time"),
            measure.vars = c("pred_mean", "pred_ll", "pred_ul")
)
head(dpm)


ggplot(m) + geom_sf() + coord_sf(datum = NA) +
  geom_tile(data = dpm, aes(x = x, y = y, fill = value)) +
  labs(x = "", y = "") +
  facet_wrap(variable ~ time) +
  scale_fill_viridis("PM2.5") +
  theme_bw()
