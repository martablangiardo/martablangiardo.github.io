library(SpatialEpi)
library(tidyverse)


# read the Pennsylvania data from SpatialEpi package
data("pennLC")
LC <- pennLC$data
head(LC)

# obtain the total number of cases by county 
LC.OE <- group_by(LC, county) %>% summarize(O = sum(cases))
head(LC.OE)

# sort the data by county, race, gender and age
LC <- arrange(LC, county, race, gender, age)

# compute the expected (there are 2 races, 
# 2 genders and 4 age groups for each county, 
# so the number of strata is: 2 x 2 x 4 = 16)
expected <- expected(
  population = LC$population,
  cases = LC$cases, n.strata = 16)

# add the vector of the expected cases to the data frame of the cases
LC.OE$E <- expected[match(LC.OE$county, unique(LC$county))]
head(LC.OE)

# compute the SIR as the ratio of the observed to the expected counts 
LC.OE$SIR <- LC.OE$O/LC.OE$E
head(LC.OE)

####
penn <- pennLC$spatial.polygon
# We converte the spatial object penn to simple feature (sf) object 
penn.sf <- st_as_sf(penn)





