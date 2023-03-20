setwd("/Users/michelacameletti/Dropbox/Lavori condivisi/2015_Book/ShortCourse/VIBASS/Session2.3")
library(tidyverse)
Piemonte_data <- read.csv("./data/Piemonte_data_byday.csv")
head(Piemonte_data)
Piemonte_data$logPM10 = log(Piemonte_data$PM10)
Piemonte_data$time = rep(1:n_distinct(Piemonte_data$Date),
                         each = max(Piemonte_data$Station.ID))


saveRDS(Piemonte_data, file="./data/Piemonte_Data.rds")


borders <- read.csv("./data/Piemonte_borders.csv")

library(sp)
poly1 = sp::Polygon(cbind(borders$UTM_X,borders$UTM_Y))
firstPoly <- sp::Polygons(list(poly1), ID = "A")
Piemonte_border <- sp::SpatialPolygons(list(firstPoly))

class(firstPoly)
class(Piemonte_border)
plot(firstSpatialPoly)

saveRDS(Piemonte_border,"./data/Piemonte_Border.rds")
library(inlabru)
ggplot()+
  gg(firstSpatialPoly)



########
load("./data/Piemonte_grid.Rdata")
class(Piemonte_grid)

#######
load("./data/Altitude_GRID.Rdata")
class(AltitudeGRID)
dim(AltitudeGRID)


AltitudeGRID2 = matrix(t(AltitudeGRID), ncol=1)
dim(AltitudeGRID2)

Along = data.frame(A=rep(AltitudeGRID2, 3))
dim(Along)
head(Along)

#provamat = matrix(matrix(c(1,3,4,5), ncol=1))
#rep(provamat,3)
  




###
load("./data/Temp_GRID.Rdata")
dim(temp)
temp = Mean_Temp[,,1:3]

mat = matrix(NA, dim(temp)[1]*dim(temp)[2], 3)
for(i in 1:3)
  mat[,i] =  as.vector(t(temp[,,i]))
dim(mat)
head(mat)

### prova from wide to long
#prova = data.frame(matrix(c(rnorm(12)),ncol=3))
#prova
#colnames(prova) = paste0(1:3)
#pivot_longer(prova,1:3, names_to = "time", values_to = "temp") %>% 
#  arrange(time)

####
tempdf = data.frame(mat)
colnames(tempdf) = 1:3
tempdflong = pivot_longer(tempdf,
            1:3,
            names_to = "time", values_to = "TEMP") %>% 
  arrange(time)
dim(tempdflong)
head(tempdflong)

###
Piemonte_grid_rep = do.call("rbind", replicate(3, Piemonte_grid, simplify = FALSE))
dim(Piemonte_grid_rep)

covariate_grid = SpatialPixelsDataFrame(points = Piemonte_grid_rep,
                                data = data.frame(Along,
                                                  tempdflong))
glimpse(covariate_grid@data)
covariate_grid@data$time = as.numeric(covariate_grid@data$time)

dim(covariate_grid@data)
dim(covariate_grid@coords)
head(covariate_grid@data)
head(covariate_grid@coords)

saveRDS(covariate_grid,"./data/covariate_grid.rds")


###
ss = data.frame(A=Along[1:10,],
                tempdflong[1:10,])
ss

bb = Piemonte_grid_rep[1:10,] 
trythis = SpatialPixelsDataFrame(points = bb,
                                 data = ss)

trythis2 = trythis[c(1,4),]
trythis2@data











