###################################################
### Code for Section 8.1
###################################################
book.rMatern <- function(n, coords, sigma=1, range, kappa = sqrt(8*nu)/range, variance = sigma^2, nu=1) {
  m <- as.matrix(dist(coords))
  m <- exp((1-nu)*log(2) + nu*log(kappa*m)-
             lgamma(nu))*besselK(m*kappa, nu)
  diag(m) <- 1
  return(drop(crossprod(chol(variance*m),
                        matrix(rnorm(nrow(coords)*n), ncol=n))))
}

## ----param1--------------------------------------------------------------
# Random field marginal variances
m.var <- 0.5
# GRF range parameters:
range <- 4
# Copy parameters: reparameterization of coregionalization 
# parameters
beta <- 0.7


## ----param2--------------------------------------------------------------
n1 <- 99
n2 <- 100

## ----sloc----------------------------------------------------------------
loc1 <- cbind(runif(n1) * 10, runif(n1) * 5) 
loc2 <- cbind(runif(n2) * 10, runif(n2) * 5) 

## ----rfs,results='hide'--------------------------------------------------
set.seed(05101980)
z <- book.rMatern(1, rbind(loc1, loc2),
                   range = range,
                   sigma = sqrt(m.var))


## ----yyy-----------------------------------------------------------------
set.seed(08011952)

x1 = runif(n1)
x2 = runif(n2)

#y1 <- alpha[1] + z[1:n1] + rnorm(n1, 0, e.sd[1])
y1 <- -5 + 3*x1 + rnorm(n1, 0, 0.3)
#y2 <- alpha[2] + beta[1] * z[n1 + 1:n2]  + rnorm(n2, 0, e.sd[2])
y2 <- 3 + 0.5*x2 + rnorm(n2, 0, 0.2)


## ----mesh----------------------------------------------------------------
mesh <- inla.mesh.2d(rbind(loc1, loc2), 
                     max.edge = c(0.5, 1.25), offset = c(0.1, 1.5), cutoff = 0.1)

plot(mesh)

## ----spde----------------------------------------------------------------
spde <- inla.spde2.pcmatern(
  mesh = mesh,
  prior.range = c(0.5, 0.01), # P(range < 0.5) = 0.01
  prior.sigma = c(1, 0.01)) # P(sigma > 1) = 0.01


if(stack){
## ----pcopy---------------------------------------------------------------
hyper <- list(theta = list(prior = 'normal', param = c(0, 10)))

## ----form----------------------------------------------------------------
form <- y ~ 0 + intercept1 + intercept2  + 
  f(s1, model = spde) + f(s12, copy = "s1", fixed = FALSE, hyper = hyper) 

## ----stlokA--------------------------------------------------------------
A1 <- inla.spde.make.A(mesh, loc1) 
A2 <- inla.spde.make.A(mesh, loc2) 

## ----stack---------------------------------------------------------------
stack1 <- inla.stack(
  data = list(y = cbind(as.vector(y1), NA)),
  A = list(A1), 
  effects = list(list(intercept1 = 1, s1 = 1:spde$n.spde))) 

stack2 <- inla.stack(
  data = list(y = cbind(NA, as.vector(y2))),
  A = list(A2), 
  effects = list(list(intercept2 = 1, s12 = 1:spde$n.spde)))

stack <- inla.stack(stack1, stack2) 

## ----fixnugget-----------------------------------------------------------
hyper.eps <- list(hyper = list(theta = list(prior = 'pc.prec', 
                                            param = c(1, 0.01))))

## ----initheta------------------------------------------------------------
#theta.ini <- c(log(1 / e.sd^2), 
               #c(log(range), 
                # log(sqrt(m.var)))[c(1, 4, 2, 5, 3, 6)], beta)
# We jitter the starting values to avoid artificially recovering 
# the true values
#theta.ini = theta.ini + rnorm(length(theta.ini), 0, 0.1)

## ----result, results = 'hide'--------------------------------------------
result <- inla(form, rep('gaussian', 2), 
               data = inla.stack.data(stack), 
               control.family = list(hyper.eps, hyper.eps), 
               control.predictor = list(A = inla.stack.A(stack)))
               #control.mode = list(theta = theta.ini, restart = TRUE),
               #control.inla = list(int.strategy = 'eb'))

## ----label = "coregparam1"-----------------------------------------------
# Intercepts
tabcrp1 <- cbind(true = alpha, result$summary.fixed[, c(1:3, 5)])



# Precision of the errors
## ----sd---
p.sd <- lapply(result$internal.marginals.hyperpar[1:2],
               function(m) {
                 inla.tmarginal(function(x) 1 / sqrt(exp(x)), m)
               })

tabcrp2 <- cbind(
  true = c(e = e.sd), 
  t(sapply(p.sd, function(m) 
    unlist(inla.zmarginal(m, silent = TRUE))[c(1:3, 7)])))
colnames(tabcrp2) <- colnames(tabcrp1)

# Copy parameters 
tabcrp3 <- cbind(
  true = beta, result$summary.hyperpar[5, c(1:3, 5)])

# The complete table
tabcrp <- rbind(tabcrp1, tabcrp2, tabcrp3)
tabcrp
}

#####
library(inlabru)

df1 = data.frame(y=y1, x1=x1)
head(df1)
#coordinates(df1) = c("X1","X2")
df2 = data.frame(y=y2, x2=x2)
head(df2)
#coordinates(df2) = c("X1","X2")




cmp1 = ~ - 1 + Intercept1(1) + beta1(x1, model="linear")
like1 <- like(formula = y ~ Intercept1 + beta1,
              data = df1,
              family = "gaussian")
fit1 <- bru(cmp1, like1)

cmp2 = ~ - 1 + Intercept2(1) + beta2(x2, model="linear")
like2 <- like(formula = y ~ Intercept2 + beta2,
              data = df2,
              family = "gaussian")
fit2 <- bru(cmp2, like2)


cmp <-  ~ -1 + Intercept1(x1*0+1) + Intercept2(x2*0+1) + beta1(x1, model="linear")  + beta2(x2, model="linear") #s.field(main = coordinates, model = spde) 
fit <- bru(cmp, like1, like2,
           options = list(inla.mode="experimental"))

fit$summary.fixed
fit$summary.hyperpar


spde.range <- spde.posterior(fit, "s.field", what = "range")
spde.logvar <- spde.posterior(fit, "s.field", what = "log.variance")
range.plot <- plot(spde.range) + geom_vline(xintercept=range)
var.plot <- plot(spde.logvar) + geom_vline(xintercept=m.var)
multiplot(range.plot, var.plot)
