low <- read.csv("Lowbirthweight_births.csv",header=T, sep=";", row.names =1)
tot <- read.csv("Total_births.csv",header=T, sep=";", row.names =1)
low_georgia <- sum(low)
tot_georgia <- sum(tot)
rate <- low_georgia/tot_georgia

# Compute the expected number of cases and SIR 
expected <- tot * rate
if (sum(expected) == sum(low)) cat("OK, # expected = # observed")

ratio <- low/expected 
colnames(ratio) <- seq(2000,2010)

# Import and thin the shapefile 
library(maptools)
georgia <- readShapePoly("co13_d00.shp")
source("naiveThinShp.R")
georgia.thin <- naive.thin.shp(georgia, thin=25)
data.georgia <- attr(georgia.thin, "data")

# *** Code for Figure 1.13 
groups <- quantile(as.vector(as.matrix(ratio)),seq(0, 1,0.2))
# Create ratio.factor1, ratio.factor2, ..., ratio.factor11
for(i in 1:11){
  name <- paste("ratio.factor",i,sep="")
  assign(name, value= cut(ratio[,i], breaks=groups, labels=c("[0,0.798]", "(0.798,0.95]", "(0.95,1.11]", "(1.11,1.31]", "(1.31,3.04]")))
}

data.factor <- data.frame(rownames(ratio), ratio.factor1, ratio.factor2, ratio.factor3, ratio.factor4, ratio.factor5, ratio.factor6, ratio.factor7, ratio.factor8,
                          ratio.factor9, ratio.factor10, ratio.factor11)
colnames(data.factor) <- c("NAME",paste("Year", seq(2000,2010), sep=""))
attr(georgia.thin, "data") <- merge(data.georgia, data.factor, by="NAME")

pdf("GeorgiaSMR.pdf", width=12, height=7)
spplot(obj=georgia.thin, zcol=c(paste("Year", seq(2000,2010),sep="")), col.regions=gray(4:0/4), pretty=T, as.table=T,layout=c(4,3),par.settings=list(fontsize=list(text=25)))
dev.off()
################
#Data preparation
names <- georgia$NAME
georgia <- georgia[-c(99,100,105,137),]
data.georgia = attr(georgia, "data")
data <- read.csv("data.final.csv")

low.vector <- as.vector(as.matrix(data[,2:12]))#by column
E.vector <- as.vector(as.matrix(data[,13:23]))#by column
year <- numeric(0)
for(i in 1:11){ 
  year<- append(year,rep(i,dim(data)[1]))
}
county<- as.factor(rep(data[,1],11))

data<- data.frame(y= low.vector, E= E.vector, ID.area=as.numeric(county), ID.area1=as.numeric(county), year=year,
                  ID.year = year, ID.year1=year, ID.area.year = seq(1,length(county)))


#Space-time interactions
#Type I
formula.intI<- y ~ + f(ID.area,model="bym",
                       graph=Georgia.adj) +
  f(ID.year,model="rw2") +
  f(ID.year1,model="iid") + 
  f(ID.area.year,model="iid")

#Type II
ID.area.int <- data$ID.area
ID.year.int <- data$ID.year

formula.intII<- y ~ f(ID.area,model="bym",graph=Georgia.adj) +
  f(ID.year,model="rw2") + 
  f(ID.year1,model="iid") +
  f(ID.area.int,model="iid", 
    group=ID.year.int,
    control.group=list(model="rw2")) 

#Type III
ID.area.int <- data$ID.area
ID.year.int <- data$ID.year

formula.intIII<- y ~  f(ID.area,model="bym",graph=Georgia.adj) +
  f(ID.year,model="rw2") + 
  f(ID.year1,model="iid") +
  f(ID.year.int,model="iid", 
    group=ID.area.int,
    control.group=list(model="besag", 
                       graph=Georgia.adj))

#Type IV
ID.area.int <- data$ID.area
ID.year.int <- data$ID.year

formula.intIV<- y ~ f(ID.area,model="bym",graph=Georgia.adj) +
  f(ID.year,model="rw2") +
  f(ID.year1,model="iid") + 
  f(ID.area.int,model="besag", 
    graph=Georgia.adj,group=ID.year.int,
    control.group=list(model="rw2"))
################
#Running INLA
library(INLA)
#Adjacency
Georgia.adj <- "Georgia.graph"

mod.intI <- inla(formula.intI,family="poisson",data=data,E=E, 
                  control.predictor=list(compute=TRUE), 
                  control.compute=list(dic=TRUE))

mod.intII <- inla(formula.intII,family="poisson",data=data,E=E, 
                 control.predictor=list(compute=TRUE), 
                 control.compute=list(dic=TRUE))

mod.intIII <- inla(formula.intIII,family="poisson",data=data,E=E, 
                 control.predictor=list(compute=TRUE), 
                 control.compute=list(dic=TRUE))

mod.intIV <- inla(formula.intIV,family="poisson",data=data,E=E, 
                 control.predictor=list(compute=TRUE), 
                 control.compute=list(dic=TRUE))
##########################################################
delta.intI <- data.frame(delta=mod.intI$summary.random$ID.area.year[,2],year=data$ID.year,ID.area=data$ID.area)
delta.intI.matrix <- matrix(delta.intI[,1], 159,11,byrow=FALSE)
rownames(delta.intI.matrix)<- delta.intI[1:159,3]

delta.intII <- data.frame(delta=mod.intII$summary.random$ID.area.int[,2],year=data$ID.year,ID.area=data$ID.area)
delta.intII.matrix <- matrix(delta.intII[,1], 159,11,byrow=FALSE)
rownames(delta.intII.matrix)<- delta.intII[1:159,3]

delta.intIII <- data.frame(delta=mod.intIII$summary.random$ID.year.int[,2],year=data$ID.year,ID.area=data$ID.area)
delta.intIII.matrix <- matrix(delta.intIII[,1], 159,11,byrow=FALSE)
rownames(delta.intIII.matrix)<- delta.intIII[1:159,3]

delta.intIV <- data.frame(delta=mod.intIV$summary.random$ID.area.int[,2],year=data$ID.year,ID.area=data$ID.area)
delta.intIV.matrix <- matrix(delta.intIV[,1], 159,11,byrow=FALSE)
rownames(delta.intIV.matrix)<- delta.intIV[1:159,3]

#Check the absence of spatial trend for intII)
cutoff.interaction <- c(-1,-0.5,-0.01,0.01,0.5,1)
delta.intI.factor <- data.frame(NAME=data.georgia$NAME)
for(i in 1:11){
  delta.factor.temp <- cut(delta.intI.matrix[,i],breaks=cutoff.interaction,include.lowest=TRUE) 
  delta.intI.factor <- cbind(delta.intI.factor,delta.factor.temp)
}

colnames(delta.intI.factor)<- c("NAME",seq(2000,2010))

delta.intII.factor <- data.frame(NAME=data.georgia$NAME)
for(i in 1:11){
  delta.factor.temp <- cut(delta.intII.matrix[,i],breaks=cutoff.interaction,include.lowest=TRUE) 
  delta.intII.factor <- cbind(delta.intII.factor,delta.factor.temp)
}

colnames(delta.intII.factor)<- c("NAME",seq(2000,2010))

#Check the Spatial trend (intIII)
delta.intIII.factor <- data.frame(NAME=data.georgia$NAME)
for(i in 1:11){
  delta.factor.temp <- cut(delta.intIII.matrix[,i],breaks=cutoff.interaction,include.lowest=TRUE) 
  delta.intIII.factor <- cbind(delta.intIII.factor,delta.factor.temp)
}

colnames(delta.intIII.factor)<- c("NAME",seq(2000,2010))

#Check the Spatial trend (intIV)
delta.intIV.factor <- data.frame(NAME=data.georgia$NAME)
for(i in 1:11){
  delta.factor.temp <- cut(delta.intIV.matrix[,i],breaks=cutoff.interaction,include.lowest=TRUE) 
  delta.intIV.factor <- cbind(delta.intIV.factor,delta.factor.temp)
}

colnames(delta.intIV.factor)<- c("NAME",seq(2000,2010))

#Maps of interactions
attr(georgia, "data")=data.frame(data.georgia, intI=delta.intI.factor, intII=delta.intII.factor, intIII=delta.intIII.factor, intIV=delta.intIV.factor)
  
pdf("InteractionsMapsI.pdf",width=12, height=7)
par(mar=c(4.2,6.2,0.4,0.4))
spplot(obj=georgia, zcol=c("intI.2000","intI.2001","intI.2002",
                           "intI.2003", "intI.2004","intI.2005",
                           "intI.2006", "intI.2007", "intI.2008","intI.2009",
                           "intI.2010"), as.table=TRUE, col.regions=c("blue","green","yellow","orange","red"),names.attr=c("2000","2001","2002","2003","2004","2005","2006","2007","2008","2009","2010"),main="",par.settings=list(fontsize=list(text=25)))
dev.off()

pdf("InteractionsMapsII.pdf",width=12, height=7)
par(mar=c(4.2,6.2,0.4,0.4))
spplot(obj=georgia, zcol=c("intII.2000","intII.2001","intII.2002",
                           "intII.2003", "intII.2004","intII.2005",
                           "intII.2006", "intII.2007", "intII.2008","intII.2009",
                           "intII.2010"), as.table=TRUE, col.regions=c("blue","green","yellow","orange","red"),names.attr=c("2000","2001","2002","2003","2004","2005","2006","2007","2008","2009","2010"),main="",par.settings=list(fontsize=list(text=25)))
dev.off()

pdf("InteractionsMapsIII.pdf",width=12, height=7)
par(mar=c(4.2,6.2,0.4,0.4))
spplot(obj=georgia, zcol=c("intIII.2000","intIII.2001","intIII.2002",
                           "intIII.2003", "intIII.2004","intIII.2005",
                           "intIII.2006", "intIII.2007", "intIII.2008","intIII.2009",
                           "intIII.2010"), as.table=TRUE, col.regions=c("blue","green","yellow","orange","red"),names.attr=c("2000","2001","2002","2003","2004","2005","2006","2007","2008","2009","2010"),main="",par.settings=list(fontsize=list(text=25)))
dev.off()

pdf("InteractionsMapsIV.pdf",width=12, height=7)
par(mar=c(4.2,6.2,0.4,0.4))
spplot(obj=georgia, zcol=c("intIV.2000","intIV.2001","intIV.2002",
                           "intIV.2003", "intIV.2004","intIV.2005",
                           "intIV.2006", "intIV.2007", "intIV.2008","intIV.2009",
                           "intIV.2010"), as.table=TRUE, col.regions=c("blue","green","yellow","orange","red"),names.attr=c("2000","2001","2002","2003","2004","2005","2006","2007","2008","2009","2010"),main="",par.settings=list(fontsize=list(text=25)))
dev.off()
