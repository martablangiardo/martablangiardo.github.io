.libPaths(c("C:\\MyR_packages\\R", .libPaths()))
# install.packages("raster")
# install.packages("spdep")
# remotes::install_github("r-spatial/mapview")

library(raster); library(spdep); library(mapview)
# References at:
#https://rspatial.org/raster/analysis/analysis.pdf
# https://rspatial.org/raster/spatial/9-maps.html
# https://rpubs.com/tuyenhavan/286930

lux <- shapefile(system.file("external/lux.shp", package="raster"))
summary(lux)

mapView(lux)
N <- length(lux) # Luxembourg is divided into 12 cantons


# Plot of Luxembourg divided into 12 cantons and display their name

par(mar=c(0,0,0,0)) # par sets or adjusts plotting parameters
                  # the parameter mar stands for margin size 
plot(lux,border=3, col=terrain.colors(length(lux)), axes=F)
text(lux,"NAME_2",cex=0.5)

#note: we can also generate a vector of n contiguous colors 
# using the functions rainbow(n), heat.colors(n), 
# terrain.colors(n), topo.colors(n), and cm.colors(n).

# Add names to layer and color according districts 
districts <- unique(lux$NAME_1) # the three districts of Luxembourg
districts

par(mar=rep(2,4)) 
m <- match(lux$NAME_1, districts)
plot(lux, col= rainbow(N)[m], axes=T) 
text(lux, 'NAME_2', cex=.7, halo=TRUE)


# Plot of Luxembourg, coloring cantons according to the three districts 
# and add numerical identifier of the cantons (labels placed at centroid of each polygon) 

coords <- coordinates(lux) # compute coordinates at centroids of each canton

par(mai=c(0,0,0,0))
plot(lux, col= rainbow(length(lux))[m], axes=T)
points(coords, cex=5, pch=20, col='white')
text(lux, 'ID_2', cex=1.5)

# Creating neighbours 

# Contiguity-based neighbours

# Derive the neighborhood structure from the shapefile 
# using poly2nb function (here rook's move contiguity is used)
w.rook <- poly2nb(lux, row.names=lux$ID_2, queen=FALSE)
w.rook

#The \texttt{nb} object w.rook lists for each polygon the neighboring polygons. 
# For example, to see the neighbors for the first polygon in the object, type:
w.rook[[1]]

# Check it by plotting Luxembourg with the numerical identifier of the cantons
par(mar=c(0,0,0,0)) 
plot(lux,border=3, col=terrain.colors(length(lux)), axes=F)
text(lux,"ID_2",cex=1)


# Now, assign the weights to each neighboring polygon.
# The argument style can take on a number of character values:
# W=row standardized, B=binary, C=globally standardized
# with zero.policy = TRUE we insert zero into the weights matrix where there is no connection

w.rook.l <- nb2listw(w.rook, style="B", zero.policy=TRUE)

# Check the weight of the first polygon's three neighbors
w.rook.l$weights[1]
w.rook.l$n[1]

# Inspect also the weight matrix 
w.rook.m <- nb2mat(w.rook, style="B", zero.policy = TRUE) #  spatial weights matrix
w.rook.m


par(mai=c(0,0,0,0))
plot(lux, col='white', border='blue')
plot(w.rook, coords, col='red', lwd=2, add=TRUE)


### Distance-based neighbours

# Compute coordinates at centroids of each canton
coords <- coordinates(lux)

IDs <- row.names(as(lux, "data.frame"))

# K nearest neighbors for spatial weights
w.d_k1 <- knn2nb(knearneigh(coords, k=1), row.names = IDs) # it ensures that all areas have 1 neighbour
w.d_k3 <- knn2nb(knearneigh(coords, k=3), row.names = IDs)
w.d_k4 <- knn2nb(knearneigh(coords, k=4), row.names = IDs)

w.d_k1[[2]]

par(mai=c(0,0,0,0))
plot(lux, col='white', border='blue')
plot(w.d_k3, coords, col='red', lwd=2, add=TRUE)

# neighborhood contiguity by distance
w.d10 <- dnearneigh(coords, 0, 10)
w.d25 <- dnearneigh(coords, 0, 25, longlat=TRUE)

par(mai=c(0,0,0,0))
plot(lux, col='white', border='blue')
plot(w.d10, coords, col='red', lwd=1, add=TRUE)


# Plots
plotit <- function(nb, lab='') {
  #plot(lux, col='gray', border='white')
  plot(lux, col='white', border='blue')
  plot(nb, coords, col='red', lwd=1, add=TRUE, pch=20)
  #text(6.3, 50.1, paste0('(', lab, ')'), cex=1.25)
  text(6, 50.23, paste0('', lab, ''), cex=1.25)
}

par(mfrow=c(1, 3), mai=c(0,0,0,0))
plotit(w.rook, 'Rook move adjacency')
plotit(w.d_k3, 'k=3 nearest neighbours')
plotit(w.d10, 'Neighbours by distance (10 km)')
#plotit(wd25, '25 km')


