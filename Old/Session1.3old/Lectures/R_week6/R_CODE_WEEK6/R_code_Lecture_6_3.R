### R code Week 6 - Lecture 6.3 ###
# Example from Lovelace et al. (2019), Geocomputation with R. CRC Press
# https://rdrr.io/github/geocompr/geocompkg/f/vignettes/solutions06.Rmd

# install.packages("spData")
# install.packages("sf")

library(spData)
library(sf)

# Extract the CRS information from the sf object nz (New Zealand)
st_crs(nz) # here EPSG:2193

# Re-project using an EPSG code
nz_wgs <- st_transform(nz, 4326) 
st_crs(nz_wgs) # now EPSG:4326

# Extract the CRS information from the sf object world
st_crs(world) #EPSG:4326

# Re-project using CRS of the sf object world
nz_wgs = st_transform(nz, st_crs(world))
st_crs(nz_wgs)

# Remove the CRS from nz_wgs and plot the result
nz_wgs_NULL_crs = st_set_crs(nz_wgs, NA)

# Plots
par(mfrow = c(1, 3))
plot(st_geometry(nz))
plot(st_geometry(nz_wgs))
plot(st_geometry(nz_wgs_NULL_crs))


