### R code Week 6 - Lecture 6.4 ###

# install.packages("raster")
# install.packages("spdep")
# remotes::install_github("r-spatial/mapview")

library(raster); library(spdep); library(mapview)

# Read in Luxembourg shapefile from R package raster
lux <- shapefile(system.file("external/lux.shp", package="raster"))
summary(lux)


# Plot of Luxembourg divided into 12 cantons and display their name
par(mar=c(0,0,0,0)) # par sets or adjusts plotting parameters,
                    # while the parameter mar stands for margin size 
plot(lux, border=3, col=terrain.colors(length(lux)), axes=F)
text(lux,"NAME_2",cex=0.5)

# note: we can also generate a vector of n contiguous colors 
# using the functions rainbow(n), heat.colors(n), 
# terrain.colors(n), topo.colors(n), and cm.colors(n).

# Plot interactive map with R package mapview
mapView(lux)


### Creating neighbors ###

### Contiguity-based neighbors

# Derive the neighborhood structure from the shapefile 
# using poly2nb function (here rook's move contiguity is used)
w.rook <- poly2nb(lux, row.names=lux$ID_2, queen=FALSE)
w.rook

# The nb object w.rook lists for each polygon the neighboring polygons. 
# For example, to see the neighbors for the first polygon in the object, type:
w.rook[[1]]

# Check it by plotting Luxembourg with the numerical identifier of the cantons
par(mar=c(0,0,0,0)) 
plot(lux,border=3, col=terrain.colors(length(lux)), axes=F)
text(lux,"ID_2",cex=1)


# Now, assign the weights to each neighboring polygon.
# The argument style can take on a number of character values:
# W=row standardized, B=binary, C=globally standardized
# with zero.policy=TRUE we insert zero into the weights matrix where there is no connection

w.rook.l <- nb2listw(w.rook, style="B", zero.policy=TRUE)

# Check the weight of the first polygon's three neighbors
w.rook.l$weights[1]

# Inspect also the weight matrix 
w.rook.m <- nb2mat(w.rook, style="B", zero.policy = TRUE) #  spatial weights matrix
w.rook.m

# Compute coordinates at centroids of each canton
coords <- coordinates(lux)

# Plot
par(mai=c(0,0,0,0))
plot(lux, col='white', border='blue')
plot(w.rook, coords, col='red', lwd=2, add=TRUE)


### Distance-based neighbors

IDs <- row.names(as(lux, "data.frame"))

# K nearest neighbors for spatial weights
w.d_k3 <- knn2nb(knearneigh(coords, k=3), row.names = IDs) # here 3 nearest neighbors

# Plot
par(mai=c(0,0,0,0))
plot(lux, col='white', border='blue')
plot(w.d_k3, coords, col='red', lwd=2, add=TRUE)

# neighborhood contiguity by distance
w.d10 <- dnearneigh(coords, 0, 10) 

# Plot 
par(mai=c(0,0,0,0))
plot(lux, col='white', border='blue')
plot(w.d10, coords, col='red', lwd=1, add=TRUE)


