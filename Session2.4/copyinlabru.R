rm(list=ls())


# Data simulation -----
set.seed(271)

n = 30
m = 20
# Like 1
x1 = runif(n, 1, 2)
y1 = rnorm(n, mean = 2*x1)
# Like 2
x2 = runif(m, 1, 2)
y2 = rpois(m, lambda = exp(2*x2))



# Implementation with inla and copy -----

# Data
x = c(x1, x2)

y = matrix(NA, ncol = 2, nrow = n+m)
y[1:n, 1] = y1
y[(n+1):(n+m), 2] = y2

# Model
formula = y ~ -1 + f(idx.gaus, x, model = "iid") +
  f(idx.pois, x, copy = "idx.gaus")

library(INLA)
out = inla(formula,
           data = list(y = y, x = x,
                       idx.gaus = c(rep(1, n), rep(NA, m)),
                       idx.pois = c(rep(NA, n), rep(1, m))),
           family = c("gaussian", "poisson"))

summary(out)
out$summary.random
names(out$marginals.random)
names(out$marginals.hyperpar)

plot(inla.smarginal(out$marginals.random$idx.gaus[[1]]),type="l",col=2)
abline(v=2)


# Implementation with inlabru ----


library(inlabru)
df1 = data.frame(y = y1, x = x1, idx = rep(1, n))
df2 = data.frame(y = y2, x = x2, idx = rep(1, m))

comp = y ~ randomslope(idx, x, model = "iid") 

lik1 = like("gaussian",
            formula = y ~ randomslope,
            data = df1)
lik2 = like("Poisson",
            formula = y ~ randomslope,
            data = df2)


outinlabru = bru(comp, lik1, lik2)
outinlabru$summary.random
plot(inla.smarginal(outinlabru$marginals.random$randomslope[[1]]),type="l",col=2)
abline(v=2)

out$summary.random

#############
set.seed(4)
n = 1000
Sigma = matrix(c(1, 0.8, 0.8, 1), 2, 2)
z = rnorm(n)
library(mvtnorm)
ab = rmvnorm(n, sigma = Sigma) # require ’mvtnorm’ package
a = ab[, 1]
b = ab[, 2]
eta = 0.5 + a + b * z
y = eta + rnorm(n, sd = 1)
#hyper.gaussian = list(prec = list(prior = "loggamma", param = c(1, 0.2161)))

i = 1:n # use only the first n elements (a_1, ..., a_n)
j = 1:n + n # use only the last n elements (b_1, ..., b_n)
formula = y ~ -1 + Intercept + f(i, model = "iid2d", n = 2*n) + 
  f(j, z, copy = "i",fixed=TRUE, group='exchangeable', replicate='iid') 
result = inla(formula, data = data.frame(y = y, z = z, i = i, j = j, Intercept = 1),
              family = "gaussian")
              #control.family = list(hyper = hyper.gaussian))
summary(result)
plot(result)
summary(result)


comp = y ~ Intercept(1) + eff(i, model = "iid2d", n = 2*n) + eff2(j, z, copy = "eff", fixed=T) 
lik = like("gaussian",
           formula = y ~ Intercept + eff + eff2,
           data = data.frame(y = y, z = z, i = i, j = j))
           #options = list(control.family = list(hyper = hyper.gaussian)))
prova = bru(comp, lik)
summary(prova)
prova$summary.hyperpar
result$summary.hyperpar

##############
#############
df1 = data.frame(y = y[1:n], idx = 1:n)
df2 = data.frame(y = y[(n+1):(2*n)], idx = 1:n)

jcmp <- ~ Intercept(1) + fieldu(idx, model = "iid2d", n = n)
lik1 <- like("gaussian",
             formula = y ~ Intercept + fieldu,
             data = df1)
lik2 <- like("gaussian",
             formula = y ~ Intercept2  + fieldu,
             data = df2)
ppp = bru(jcmp, lik1, lik2)
summary(ppp)
