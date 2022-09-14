# Example from https://sites.google.com/a/r-inla.org/www/models/tools
set.seed(4)
n = 1000
Sigma = matrix(c(1, 0.8, 0.8, 1), 2, 2)
z = rnorm(n)
library(mvtnorm)
ab = rmvnorm(n, sigma = Sigma) 
a = ab[, 1]
b = ab[, 2]
eta = 0.5 + a + b * z
y = eta + rnorm(n, sd = 1)


# Model fit with inla
i = 1:n # use only the first n elements (a_1, ..., a_n)
j = 1:n + n # use only the last n elements (b_1, ..., b_n)


formula = y ~ -1 + f(Inter, model = "linear", mean.linear=0, prec.linear=0) + f(i, model = "iid2d", n = 2*n) + 
  f(j, z, copy = "i",fixed=TRUE) 

result = inla(formula, data = data.frame(y = y, z = z, i = i, j = j, Inter = 1),
              family = "gaussian")


# Model fit with inlabru
comp = y ~ Intercept(Inter, model="linear", mean.linear=0, prec.linear=0) +
  eff(i, model = "iid2d", n = 2*n) + eff2(j, z, copy = "eff", fixed=T) 
lik = like("gaussian",
           formula = y ~ Intercept + eff + eff2,
           data = data.frame(y = y, z = z, i = i, j = j, Inter = 1))
resultinlabru = bru(comp, lik)


# Comparison
result$summary.fixed
resultinlabru$summary.fixed

result$summary.hyperpar
resultinlabru$summary.hyperpar

