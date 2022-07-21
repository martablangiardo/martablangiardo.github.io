
The course will provide a focus on how to use the Integrated Nested Laplace Approximation approach [INLA](https://www.r-inla.org/) for the analysis of spatial and spatio-temporal data.

We will first go through the basic of INLA for Bayesian inference and will then see how to model hierarchical structures. We will then focus on area level data and present how to model spatially structured random effects through conditional autoregressive specifications; following that, we will extend the approach to include temporal dependency and touch briefly on spatio-temporal interactions.

Moving on to point-referenced data we will introduce the stochastic partial differential equation (SPDE) approach, used for spatial modelling on a continuous field. We will then extend this to deal with spatio-temporal data. Finally we will describe how to use R-INLA for more advanced problems in the spatio-temporal realm, for instance how to deal with misaligned data or how to model two outcomes jointly.

The course will maintain a very practical angle, with a mixture of lectures and practical sessions. For a book covering the topics of the course see [here](https://onlinelibrary.wiley.com/doi/book/10.1002/9781118950203). 

It is recommended that people attending are familiar with [R](https://www.r-project.org/) and with the basic of the Bayesian approach.

It would be beneficial if attendees could bring their laptop having installed the latest R (version 4.2.1) and the following packages:

- INLA (install.packages("INLA", repos="http://www.math.ntnu.no/inla/R/stable"))

- install.packages(c("sf", "spdep", "SpatialEpi", "RColorBrewer", "tmap", "ggplot2", "mapview", "cowplot", "tidyverse", "viridis", "patchwork", "knitr", "kableExtra", "inlabru", "maps", "spTimer", "lubridate", "mvtsplot", "GGally", "corrr"))

## Timetable
### Day 1 - Wed 20th July 2022 - morning

- [Session 1.1](Session1.1): Lecture on introduction to INLA and R-INLA
- [Session 1.2](Session1.2): Hierarchical models, priors, prediction and model checking
- [Practical 1a](Practical1a): INLA basics 
- [Practical 1b](Practical1b): Hierarchical models for disease mapping

There is no material to download for practical 1a. 
Download the material for the practical 1b [here](Practical1b/Practical1b.zip)

### Day 1 - Wed 20th July 2022 - afternoon

- [Session 1.3](Session1.3): Spatial models for small area data: disease mapping and ecological regression
- [Session 1.4](Session1.4): Spatio-temporal modelling for area data
- [Practical 2](Practical2): Spatial and spatio-temporal disease mapping and regression

Download the material for the practical 2 [here](Practical2/Practical2.zip)

### Day 2 - Thur 21th July 2022 - morning

- [Session 2.1](Session2.1): Models for geostatistical data and introduction to SPDE
- [Session 2.2](Session2.2): inla.stack and inlabru
- [Practical 3](Practical3): INLA-SPDE for geostatistical data

Download the material for the practical 3 [here](Practical3/temperature.croatia.Rdata)

### Day 2 - Thur 21th July 2022 - afternoon

- [Session 2.3](Session2.3): Spatio-temporal model for geostatistical data
- [Session 2.4](Session2.4): Advanced INLA features
- [Practical 4](Practical4): A space-time model with inlabru

There is no material to download for practical 4


### Rstudio environment

This repository contains the set up to create a Rstudio environment with all the relevant packages installed.

This is useful to work on the practicals. You may want to also install the packages on your local machine, but this is useful if you are in a hurry and want to do work (or you don't have full write access to your machine).

[Binder](https://mybinder.org/v2/gh/martablangiardo/VIBASS/master?urlpath=rstudio)
