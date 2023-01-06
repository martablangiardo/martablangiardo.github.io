remove(list=ls())

book.rMatern <- function(n, coords, sigma=1, range, kappa = sqrt(8*nu)/range, variance = sigma^2, nu=1) {
  m <- as.matrix(dist(coords))
  m <- exp((1-nu)*log(2) + nu*log(kappa*m)-
             lgamma(nu))*besselK(m*kappa, nu)
  diag(m) <- 1
  return(drop(crossprod(chol(variance*m),
                        matrix(rnorm(nrow(coords)*n), ncol=n))))
}
## ----locations and covariates----------------------------------------------------------------
set.seed(123)

n1 <- 100
n2 <- 50

x1 <- runif(n1)
x2 <- runif(n2)

loc1 <- cbind(runif(n1) * 10, runif(n1) * 5) 
loc2 <- cbind(runif(n2) * 10, runif(n2) * 5) 
loc_all = data.frame(rbind(loc1,loc2))
loc_all$lik = c(rep("y1",n1),rep("y2",n2))

## ----data sim----------------------------------------------------------------
set.seed(05101980)
gf <- book.rMatern(1, rbind(loc1, loc2),
                   range = 4, sigma = sqrt(0.5)) #sigma=.7

y1 <- rnorm(n1, mean = 2 * x1 + 3) + gf[1:n1]
y2 <- rnorm(n1, mean = 0.5 * x2 + 10) + gf[(n1+1):(n1+n2)]

df1 <- data.frame(y = y1, x1 = x1, s1 = loc1[,1], s2 = loc1[,2])
head(df1)
coordinates(df1) = c("s1","s2")
df2 <- data.frame(y = y2, x2 = x2, s1 = loc2[,1], s2 = loc2[,2])
head(df2)
coordinates(df2) = c("s1","s2")

saveRDS(list(df1,df2), file="./data/dataexamplemisaligned.RDS")


## ----mesh----------------------------------------------------------------
mesh <- inla.mesh.2d(rbind(loc1, loc2), 
                     max.edge = c(1, 1.25),
                     offset = c(0.1, 1.5), 
                     cutoff = 0.4)

loc_all %>% 
  ggplot() +
  gg(mesh) +
  geom_point(aes(X1,X2,col=lik))

## ----spde----------------------------------------------------------------
spde <- inla.spde2.pcmatern(
  mesh = mesh,
  prior.range = c(1, 0.01), # P(range < 1) = 0.01
  prior.sigma = c(1, 0.01)) # P(sigma > 1) = 0.01

## ----inlabru----------------------------------------------------------------


# A joint model has two likelihoods, which are set up using the like function
jcmp <- ~ beta1(x1, model="linear") + beta2(x2, model="linear") +
          Intercept1(1) + Intercept2(1)  + field(coordinates, model = spde)
                                                                                                         

lik1 <- like("gaussian", formula = y ~ beta1 + Intercept1 + field, data = df1)
lik2 <- like("gaussian", formula = y ~ beta2 + Intercept2 + field, data = df2)

# The union of effects of both models gives the components needed to run bru
jfit <- bru(jcmp, lik1, lik2)

jfit$summary.hyperpar

## ----fixed effects----------------------------------------------------------------

jfit$summary.fixed
names(jfit$marginals.fixed)

plot(jfit, "beta1") + 
  geom_vline(xintercept = 2, col="blue", linetype="dotted", size=1.2)
inla.hpdmarginal(0.95, jfit$marginals.fixed[[1]])

plot(jfit, "beta2") + 
  geom_vline(xintercept = 0.5, col="blue", linetype="dotted", size=1.2)

plot(jfit, "Intercept1") + 
  geom_vline(xintercept = 3, col="blue", linetype="dotted", size=1.2)

plot(jfit, "Intercept2") + 
  geom_vline(xintercept = 10, col="blue", linetype="dotted", size=1.2)



spde.range <- spde.posterior(jfit, "field", what = "range")

range.plot <- plot(spde.range) +
  geom_vline(xintercept=4, col="blue", linetype="dotted", size=1.2)

spde.var <- spde.posterior(jfit, "field", what = "variance")
var.plot <- plot(spde.logvar) + 
  geom_vline(xintercept=sqrt(0.5), col="blue", linetype="dotted", size=1.2)


#multiplot(range.plot, var.plot)


plot(jfit, "Precision for the Gaussian observations") + 
  geom_vline(xintercept = 1, col="blue", linetype="dotted", size=1.2)
plot(jfit, "Precision for the Gaussian observations[2]") + 
  geom_vline(xintercept = 1, col="blue", linetype="dotted", size=1.2)










ggplot() +
  gg(jfit$summary.fixed, bar = TRUE) +
  #geom_point(aes(x=4,y=10),col="blue")
  geom_vline(xintercept = 10) +
  ylim(0, 12) 


