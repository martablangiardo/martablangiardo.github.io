
A.est6 = inla.spde.make.A(mesh = mesh6,
                          loc = coords)
dim(A.est6)


spde = inla.spde2.matern(mesh = mesh6)
spde$n.spde # number of vertices in the mesh

s.index <- inla.spde.make.index(name = "spatial.field", spde$n.spde)

s.index <- inla.spde.make.index(name="spatial.field", n.spde = spde$n.spde)


stack <- inla.stack(data = list(y = SPDEtoy$y), 
                    A = list(A.est6, 1), ## two projector matrix (the 1 is included to make the list(covariates))
                    effects = list(s.index,list(Intercept = rep(1, nrow(SPDEtoy)))), 
                    tag = "est")
#https://www.flutterbys.com.au/stats/tut/tut12.13.html
dim(inla.stack.A(toy.stack)) 
#Note that the inla.stack() function automatically eliminates all the elements associated with columns that sum to zero.



formula = y ~ -1 + intercept + f(spatial.field, model = spde)

output6 <- inla(formula,
                data = list(y = SPDEtoy$y, intercept = rep(1,spde$n.spde),
                              spatial.field = 1:spde$n.spde),
                control.predictor = list(A = A.est6, compute = TRUE))


output6 <- inla(y ~ 0 + Intercept + f(spatial.field, model = spde), 
                data = inla.stack.data(stack),
                  control.predictor = list(A = inla.stack.A(stack)))
summary(output6)


stk <- inla.stack(data=list(y=MDG_pr_data$positive, n=MDG_pr_data$examined), #the response
                  
                  A=list(A,1),  #the A matrix; t
                  
                  effects=list(c(list(Intercept=1), #the Intercept
                                 iset),  #the spatial index
                               #the covariates
                               list(Elevation = MDG_pr_data$Elevation,
                                    Access=MDG_pr_data$Access,
                                    LST_day = MDG_pr_data$LST_day,
                                    Rain = MDG_pr_data$Rain,
                                    EVI = MDG_pr_data$EVI)
                  ), 
                  
                  #this is a quick name so you can call upon easily
                  tag='dat')
