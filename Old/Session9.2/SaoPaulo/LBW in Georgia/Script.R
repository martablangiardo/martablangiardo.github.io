library(INLA)
#############################################################
#--Prepare the model and run inla--#
#Non Parametric model beta0 + Ui + Vi + gammaj + betaj + deltaij
#Ui and gammaj are modelled through CAR
#Vi and betaj are modelled as exchangeable
#deltaij is modelled as exchangeable

Georgia.adj <- paste(getwd(),"/Georgia.graph",sep="")

formula.ST3<- y ~ 1 + f(as.numeric(NAME),model="bym",graph=Georgia.adj) +
  f(diff.year,model="rw1") + f(exch.year,model="iid") + f(ID,model="iid")

lc1 = inla.make.lincomb(diff.year=c(1,rep(NA,10)), exch.year=c(1,rep(NA,10)))
lc2 = inla.make.lincomb(diff.year=c(NA,1,rep(NA,9)), exch.year=c(NA,1,rep(NA,9)))
lc3 = inla.make.lincomb(diff.year=c(rep(NA,2),1,rep(NA,8)), exch.year=c(rep(NA,2),1,rep(NA,8)))
lc4 = inla.make.lincomb(diff.year=c(rep(NA,3),1,rep(NA,7)), exch.year=c(rep(NA,3),1,rep(NA,7)))
lc5 = inla.make.lincomb(diff.year=c(rep(NA,4),1,rep(NA,6)), exch.year=c(rep(NA,4),1,rep(NA,6)))
lc6 = inla.make.lincomb(diff.year=c(rep(NA,5),1,rep(NA,5)), exch.year=c(rep(NA,5),1,rep(NA,5)))
lc7 = inla.make.lincomb(diff.year=c(rep(NA,6),1,rep(NA,4)), exch.year=c(rep(NA,6),1,rep(NA,4)))
lc8 = inla.make.lincomb(diff.year=c(rep(NA,7),1,rep(NA,3)), exch.year=c(rep(NA,7),1,rep(NA,3)))
lc9 = inla.make.lincomb(diff.year=c(rep(NA,8),1,rep(NA,2)), exch.year=c(rep(NA,8),1,rep(NA,2)))
lc10 = inla.make.lincomb(diff.year=c(rep(NA,9),1,NA), exch.year=c(rep(NA,9),1,NA))
lc11 = inla.make.lincomb(diff.year=c(rep(NA,10),1), exch.year=c(rep(NA,10),1))

lcs=c(lc1,lc2,lc3,lc4,lc5,lc6,lc7,lc8,lc9,lc10,lc11)

model.inla.ST3 <- inla(formula.ST3,family="poisson",data=data,E=E, 
                       control.predictor=list(compute=TRUE), control.compute=list(dic=TRUE,cpo=TRUE),
                       lincomb=lcs,control.inla = list(lincomb.derived.only=TRUE)
                       )

##############################################################