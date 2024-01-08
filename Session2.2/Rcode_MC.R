set.seed(1234)
a <- 1
b <- 1
theta <- rbeta(1,a,b)
theta

n <- 1000
y <- rbinom(1, size=n, p=theta)
y

# Monte Carlo (MC) computation
a1 <- a + y
b1 <- n - y + b
sim <- rbeta(n=50000, shape1=a1, shape2=b1)
logodds <- log(sim/(1-sim))


hist(sim, freq=F, main="", xlab=expression(theta)) # distribution of the MC sample of theta
curve(dbeta(x, shape1=a1, shape2=b1), from=0, to=1, add=TRUE, n=1000) # exact posterior distribution

hist(logodds, col="grey", main="")
mean(logodds)
