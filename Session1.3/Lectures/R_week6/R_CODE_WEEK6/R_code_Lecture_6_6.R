### R code Week 6 - Lecture 6.6 ###

### Indirect Standardization ###

# install.packages("SpatialEpi")
# install.packages("tidyverse")

library(SpatialEpi)
library(tidyverse)

# read in the Pennsylvania data from SpatialEpi package
data("pennLC")
# to see the elements of pennLC, type ?pennLC
?pennLC

# now, create an object with the data
LC <- pennLC$data
class(LC)  # "data.frame"
head(LC)

# the data include the number of lung cancer cases and the population at county level
# which are stratified by race (white and non-white), 
# gender (female and male),
# age group (under 40, 40-59, 60-69 and 70+)
table(LC$race)
table(LC$gender)
table(LC$age)


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






