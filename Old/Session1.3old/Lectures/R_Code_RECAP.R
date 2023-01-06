# https://github.com/lindbrook/cholera
library(cholera)
rng <- mapRange()
plot(fatalities[, c("x", "y")],
     pch = 3, col = "red",
     cex = 0.5, xlim = rng$x, ylim = rng$y, asp = 1,
     frame.plot = FALSE, axes = FALSE, xlab = "", ylab = ""
)
addRoads()

# http://rstudio-pubs-static.s3.amazonaws.com/414115_8a84c76eaa3c488f8a5fcc46b0c624f0.html
