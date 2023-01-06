set.seed(271)

n = 150
m = 50

#Covariate
x <- runif(n+m, 1, 2)

# Gaussian data
y.gaus <- rnorm(n, mean = 2 * x[1:n])
#Poisson data
y.pois <- rpois(50, lambda = exp(2 * x[(n+1):(n+m)]))

# 2 columns matrix
y <- matrix(NA, ncol = 2, nrow = n+m)
y[1:n, 1] <- y.gaus
y[(n+1):(n+m), 2] <- y.pois
# Indexes
idx.gaus <- c(rep(1, 150), rep(NA, 50))
idx.pois <- c(rep(NA, 150), rep(1, 50))

modinla <- inla(y ~ -1 + f(idx.gaus, x, model = "iid") + f(idx.pois, x, copy = "idx.gaus", fixed=T),
                data = list(y = y, x = x),
                family = c("gaussian", "poisson"))
summary(modinla)
modinla$summary.random



# inlabru
cmp = y ~ coeff(idx, x, model = "iid")
lik1 <- like("gaussian",
             formula = y ~  coeff,
             data = data.frame(y = y.gaus, x = x[1:n], idx = 1))

lik2 <- like("Poisson",
             formula = y ~  coeff,
             data = data.frame(y = y.pois, x = x[(n+1):(n+m)], idx = 1))

modinlabru = bru(cmp, lik1, lik2)
modinla$summary.random
modinlabru$summary.random


