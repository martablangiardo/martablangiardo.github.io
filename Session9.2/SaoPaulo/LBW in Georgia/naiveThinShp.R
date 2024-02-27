naive.thin.shp <- function(shp,thin=25) {
#
#    This function naively thins a shapefile by taking out some coordinates
#    Only use this for plotting and always check against the "unthinned" version!!
#=============
#      on input: shp = the original shapefile
#                thin = keep every (thin)th point
#
#      modified Nov 4, 2009 by GQ Li
#      modified on Dec 08, 2011 by GQ Li (to close the polygons)
#
  poly <- slot(shp,"polygons")
  data <- slot(shp,"data")
  newpoly <- poly
  for (i in 1:length(poly)) { 
    coords <- slot(slot(poly[[i]],"Polygons")[[1]],"coords")
#    number of points in the original polygon
    n <- nrow(coords)

#    keep every 10th point if less than 100 points in the original
    if (n<100) {thin <- 10}

    ids <- seq(1,n,thin)

##    to close the polygon so that the simplified version can be read back in (Dec. 08, 2011)
    if (ids[length(ids)]<n) ids <- c(ids,n)  
    slot(slot(newpoly[[i]],"Polygons")[[1]],"coords") <- coords[ids,]
  }
  newpoly <- SpatialPolygons(newpoly)
  newshp <- SpatialPolygonsDataFrame(newpoly,data)
  print("WARNING: only use the thinned shapefile for plotting and always check against the original version!!")
  return(newshp)
}
