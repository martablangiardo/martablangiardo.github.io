book.rMatern <- function(n, coords, sigma=1, range, kappa = sqrt(8*nu)/range, variance = sigma^2, nu=1) {
  m <- as.matrix(dist(coords))
  m <- exp((1-nu)*log(2) + nu*log(kappa*m)-
             lgamma(nu))*besselK(m*kappa, nu)
  diag(m) <- 1
  return(drop(crossprod(chol(variance*m),
                        matrix(rnorm(nrow(coords)*n), ncol=n))))
}

coords = expand.grid(x=seq(0,1,length=50),
                    y=seq(0,1,length=50))
plot(coords)

set.seed(33)
sim1 = book.rMatern(n=1,
             coords=coords,
             sigma=1,
             range=0.0942809,
             nu=1) 
sim2 = book.rMatern(n=1,
                    coords=coords,
                    sigma=1,
                    range=0.1663781,
                    nu=1) 
sim3 = book.rMatern(n=1,
                    coords=coords,
                    sigma=1,
                    range=0.404061,
                    nu=1) 
sim4 = book.rMatern(n=1,
                    coords=coords,
                    sigma=1,
                    range=0.7071068,
                    nu=1) 

data = data.frame(coords, sim1, sim2, sim3, sim4)
head(data)
datalong = pivot_longer(data, sim1:sim4)
head(datalong)

datalong$range = NA
datalong$range[datalong$name=="sim1"] = "range=0.09"
datalong$range[datalong$name=="sim2"] = "range=0.17"
datalong$range[datalong$name=="sim3"] = "range=0.40"
datalong$range[datalong$name=="sim4"] = "range=0.71"
table(datalong$range)

datalong %>% 
  ggplot()+
  geom_raster(aes(x,y,fill=value)) +
  scale_fill_viridis() +
  facet_wrap(~range)






library(viridis)

p1 = data %>% 
  ggplot()+
  geom_raster(aes(x,y,fill=sim1)) +
  scale_fill_viridis() +
  ggtitle("range = 0.09, sigma=1")
p2 = data %>% 
  ggplot()+
  geom_raster(aes(x,y,fill=sim2)) +
  scale_fill_viridis() +
  ggtitle("range = 0.17, sigma=1")
p3 = data %>% 
  ggplot()+
  geom_raster(aes(x,y,fill=sim3)) +
  scale_fill_viridis() +
  ggtitle("range = 0.40, sigma=1")

p4 = data %>% 
  ggplot()+
  geom_raster(aes(x,y,fill=sim4)) +
  scale_fill_viridis() +
  ggtitle("range = 0.71, sigma=1")

multiplot(p1, p2, p3, p4,cols=2)

