## Prepare data for students

library(bmstdr)
data(nysptime)
head(nysptime)

head(nysptime)
nysptime$utmx <- nysptime$utmx/1000
nysptime$utmy <- nysptime$utmy/1000


data(gridnysptime)
dim(gridnysptime)
class(gridnysptime)
head(gridnysptime)

gridnysptime$utmx = gridnysptime$utmx/1000
gridnysptime$utmy = gridnysptime$utmy/1000
