# Adding covariates to the Pneumonia dataset

library(dplyr)

setwd("~/Dropbox/Books/INLABook/ShortCourse/VIBASS/FINAL_TEST/Preprocessing/")

#Load Pneumonia data
data <- read.csv("data.csv")


#Link IMD with pneumonia
data <- left_join(pneumonia,IMD, by="lad09cd")
write.csv(data,"data.csv")
#Convert the old ID to new 9 characters ID
pneumonia.new <- left_join(pneumonia,lookup, by="lad09cd")

#Remove the old ID
pneumonia <- pneumonia.new[,-c(1:2)]

# Merge air pollution data with the new geographical identifiers to go from LSOA to LAD
air_poll_new <- left_join(air_poll, SOA_LAD)

# Aggregate at LAD11CD to match the pneumonia data
air_poll_new %>% group_by(LAD11CD) %>%  summarise(across(NOX_03:PM25Ex_10), mean)


