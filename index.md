
The course will provide a focus on how to use the Integrated Nested Laplace Approximation approach [INLA](https://www.r-inla.org/) for the analysis of spatial and spatio-temporal data.

We will first go through the basic of Bayesian inference and introduce INLA; then we will move to hierarchical models, priors and model selection. We will then focus on area level data and present how to model spatially structured random effects through conditional autoregressive specifications; following that, we will extend the approach to include temporal dependency and touch briefly on spatio-temporal interactions.

Moving on to point-referenced data we will introduce the stochastic partial differential equation (SPDE) approach, used for spatial modelling on a continuous field. We will then extend this to deal with spatio-temporal data. 

The course will maintain a very practical angle, with a mixture of lectures and practical sessions. For a book covering the topics of the course see [here](https://onlinelibrary.wiley.com/doi/book/10.1002/9781118950203). 

It is recommended that people attending are familiar with [R](https://www.r-project.org/) and with the basic of the Bayesian approach.

It would be beneficial if attendees could bring their laptop having installed the latest R (version 4.2.1) and the following packages:

- INLA (install.packages("INLA", repos="http://www.math.ntnu.no/inla/R/stable"))

- install.packages(c("sf", "spdep", "RColorBrewer", "tmap", "ggplot2", "mapview", "cowplot", "tidyverse", "viridis", "patchwork", "knitr", "kableExtra", "inlabru", "maps", "spTimer", "lubridate", "mvtsplot", "GGally", "corrr", "SpatialEpi"))

## Timetable
### Day 1 - Mon 26th September 2022

- [Session 1.1](Session1.1): Introduction to Bayesian thinking
- [Session 1.2](Session1.2): Introduction to INLA and R-INLA

Break

- [Practical 1](Practical1): INLA basics 
- [Session1.3](Session1.3): Introduction to Spatial data

There is no material to download for practical 1. 

### Day 2 - Tue 27th September 2022

- [Session 2.1](Session2.1) Hierarchical models, priors, prediction and model checking
- [Practical 2a](Practical2a)
Download the material for the practical 2a [here](Practical2a/Practical2a.zip)
- [Practical 2b](Practical2b)
Download the material for the practical 2b [here](Practical2b/Practical2b.zip)

Break

- [Session 2.2](Session2.2): Spatial models for small area data: disease mapping and ecological regression
- [Practical 3a](Practical3)
Download the material for the practical 3 [here](Practical3/Practical3.zip). For this practical we do section 1-3.

### Day 3 - Wed 28th September 2022

- [Session 3.1](Session3.1): Introduction to temporal modelling
- [Session 3.2](Session3.2): Spatio-temporal modelling for area data

Break

- [Practical 3b](Practical3): Spatio-temporal disease mapping and regression. We continue with sections 4-5 of Practical 3

### Day 4 - Thur 29th September 2022

- [Session 4.1](Session4.1): Models for geostatistical data and introduction to SPDE
- [Session 4.2](Session4.2): inla.stack and inlabru

Break

- [Practical 4](Practical4): INLA-SPDE for geostatistical data

Download the material for the practical 4 [here](Practical4/temperature.croatia.Rdata)

### Day 5 - Fri 30th September 2022

- [Session 5.1](Session5.1): Spatio-temporal model for geostatistical data
- [Practical 5](Practical5): A space-time model with inlabru
There is no material to download for practical 5

Break

- Final exam



### Rstudio environment

This repository contains the set up to create a Rstudio environment with all the relevant packages installed.

This is useful to work on the practicals. You may want to also install the packages on your local machine, but this is useful if you are in a hurry and want to do work (or you don't have full write access to your machine).

[Binder](https://mybinder.org/v2/gh/martablangiardo/VIBASS/master?urlpath=rstudio)

