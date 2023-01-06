### R code Week 6 - Lecture 6.2 ###

# install.packages(c("spData","sf","tidyverse"), dependencies = TRUE, 
#                 repos = "http://cran.r-project.org")


library(spData); library(sf); library(tidyverse)

# Check vignette (it provides explanations of the package functionality)
vignette(package="sf")
vignette("sf1",package="sf") # display a specific vignette topic


# Read in "world" from spData package: World country polygons
# This is a sf object containing a world map data from Natural Earth 
# with a few variables from World Bank
world <- st_read(system.file("shapes/world.gpkg", package="spData"))

plot(world)
plot(world["pop"])


### From sf object to sp object and reverse
world_sp <- as(world, "Spatial")  # from sf to sp object
class(world_sp)                   # "SpatialPolygonsDataFrame"

world_sf <- st_as_sf(world_sp)    # from sp to sf object
class(world_sf)                   # "sf"  "data.frame"


### sf and tidyverse

# sf works well with the tidyverse collection of R packages. 
# For example, functions can be combined using the pipe operator %>%
# (given that both packages are loaded)

# Select and plot information for a single attribute
world %>% select(lifeExp) %>% plot()

### Geometry (stored as list columns)

# Extract geometry 
world_geo <- st_geometry(world)

# Extract and plot out only the geometry
world %>% st_geometry() %>% plot()

# or
plot(st_geometry(world))
plot(world_geo)
