### R code Week 8 - Lecture 8.1 

library(sp)
library(gstat)

# We use Meuse dataset, which includes concentrations of zinc  
# measured at 155 sampling sites within the Meuse River plain
data(meuse)

names(meuse) 

coordinates(meuse) = ~x+y # the function coordinates  
                          # promotes the data.frame meuse 
                          # into a SpatialPointsDataFrame

summary(meuse)

bubble(meuse, "zinc", col=c("#00ff0088", "#00ff0088"), 
       main = "zinc concentrations (ppm)")

hist(meuse$zinc) # we see a strong right skew in the data

# lagged scatter plot
hscat(log(zinc)~1, meuse,(0:9)*100) # the correlation is quite strong when the lag
                              # is between 100 meters, then decrease with distance

# Semivariogram

# Construct the semivariogram
meuse.vgm1 = variogram(log(zinc)~1, meuse) # we assume a constant trend for
# the variable log(zinc)

plot(meuse.vgm1)

plot(meuse.vgm1, plot.numbers = TRUE, pch = "+") # The numbers of points in the 
                            # lag group used to compute the corresponding value of gamma(h)


# Get the fit
model.1 <- fit.variogram(meuse.vgm1, vgm("Sph"))
plot(meuse.vgm1, model=model.1)
model.1

# We can also specify a set of models. In this case the best fitting is returned
model.2 <- fit.variogram(meuse.vgm1, vgm(c("Exp", "Sph")))
model.2

# Here the spherical model with nugget=0.051, partial sill =0.591 and range=897 is chosen

# Specify theoretical semivariogram with its characteristics
model.1 <- fit.variogram(meuse.vgm1, vgm(psill=0.59,"Sph",range=897,nugget=0.05))

# Kriging

# When carrying out spatial prediction, we often need to create a regular
# grid covering the whole of the study area.
# Thus, we read in the prediction grid for Meuse data set

data(meuse.grid) # this data frame has 3103 rows and 7 columns; 
# a grid with 40 m x 40 m spacing that covers the Meuse study area

summary(meuse.grid)
coordinates(meuse.grid) = ~x+y
gridded(meuse.grid) = TRUE # specify spatial data as being gridded
class(meuse.grid) #spatialPixelsDataFrame

# visualize the regular grid over the region of interest
library(ggplot2)
library(dplyr)

meuse.grid %>% as.data.frame %>% 
  ggplot(aes(x, y)) + geom_point(size=1) + coord_equal()

# Perform the krige interpolation
zinc.kriged = krige(log(zinc)~1, meuse, meuse.grid, model.1)


# Finally we plot the interpolation and the variance

# plot the interpolation (on log scale) using spplot from sp package
spplot(zinc.kriged["var1.pred"])

# plot the interpolation using ggplot2
zinc.kriged %>% as.data.frame %>% 
  ggplot(aes(x=x, y=y)) + geom_tile(aes(fill=var1.pred)) + 
  coord_equal() + scale_fill_gradient(low = "red", high="floralwhite") + 
  theme_bw() 

# plot estimated variance using spplot from sp package
spplot(zinc.kriged["var1.var"],main="Ordinary kriging variance")

# plot estimated variance using ggplot2
zinc.kriged %>% as.data.frame %>% 
  ggplot(aes(x=x, y=y)) + geom_tile(aes(fill=var1.var)) + 
  coord_equal() + scale_fill_gradient(low = "red", high="floralwhite") + 
  theme_bw() 