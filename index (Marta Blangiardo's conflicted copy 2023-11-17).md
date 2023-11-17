Welcome to the course "Geospatial Analytics using R and R-INLA".

 This short course will provide a comprehensive introduction to concepts, methods, and R tools for geospatial data analytics, which involves collecting, exploring, modelling, and visualising data that exhibit dependencies in space and/or time. Specific focus will be given to Bayesian inference through the Integrated Nested Laplace Approximation (INLA) approach. 
 
We will first go through the basics of Bayesian inference and will then learn how to model hierarchical structures. We will also introduce elements for geocomputation with R. Then we will move to the core of the course, by focusing on area level data and presenting how to model spatially structured random effects through conditional autoregressive specifications.  Following that, we will extend the approach to include temporal dependency and touch briefly on spatio-temporal interactions. Moving on to geostatistical data we will introduce the stochastic partial differential equation (SPDE) approach, used for spatial modelling on a continuous field. We will then extend this to deal with spatio-temporal data. Finally, we will describe how to use R-INLA for more advanced problems in the spatio-temporal realm, for instance how to deal with misaligned data. 

Throughout the course there will be practical examples from epidemiology, public health, environmental and social sciences fields. The course will be delivered through a combination of lectures and computer-based practical sessions.

It would be beneficial if you could bring your laptop having installed the latest R (version 4.3.1) and the following packages:

- INLA (instructions at https://www.r-inla.org/download-install)

- install packages using:

install.packages("remotes")

pkg_list = c("sf", "spData", "terra", "stars", "sp", "spdep", "geoR", "fields", "gstat", "tmap", "ggplot2", "RColorBrewer", "mapview", "leaflet", "cowplot", "viridis", "patchwork", "knitr", "kableExtra", "tidyverse", "mvtsplot", "GGally", "corrr", "SpatialEpi", "spTimer", "units", "stringr", "bmstdr" ,"inlabru", "fmesher")

remotes::install_cran(pkg_list)

- install package fingertipsR as follows:
options(repos = c(
  ropensci = 'https://ropensci.r-universe.dev',
  CRAN = 'https://cloud.r-project.org'))

install.packages('fingertipsR')


The html and pdf version of the slides and the practical material are here

## Timetable
### Day 1 - Mon 27th Nov 2023

- [Session 1.1](Session1.1): Introduction to Bayesian thinking

Break

- [Session 1.2](Session1.2): Introduction to INLA and R-INLA 

- [Practical 1a](Practical1a)

Lunch

- [Session 1.3](Session1.3): Introduction to  geospatial data 

- [Practical 1b](Practical1b)


Pdf of the lectures are [here](Pdfs/Day1.zip)

### Day 2 - Tue 28th Nov 2023

- [Session 2.1](Session2.1): Hierarchical models, prediction, prior specification

Break

- [Practical 2a](Practical2a)

Material for the practical is [here](Practicals/Practical2a.zip)

- [Practical 2b](Practical2b)

Material for the practical is [here](Practicals/Practical2b.zip)

Lunch

- [Session 2.2](Session2.2): Spatial models for small area data: disease mapping and ecological regression

- [Practical 2c](Practical2c)

Material for the practical is [here](Practicals/Practical2c.zip)

Pdf of the lectures are [here](Pdfs/Day2.zip)


### Day 3 - Wed 29th Nov 2023

- [Session 3.1](Session3.1):  Introduction to temporal modelling

Break

- [Session 3.2](Session3.2): Spatio-temporal models for small area data

Lunch

- [Practical 3](Practical3)

Material for the practical is [here](Practicals/Practical3.zip)


Pdf of the lectures are [here](Pdfs/Day3.zip)


### Day 4 - Thur 30th Nov 2023

- [Session 4.1](Session4.1): Introduction to Geostatistics  

Break

- [Session 4.2](Session4.2): Introduction to SPDE model with R-INLA

Lunch

- [Practical4a](Practical4a)

Material for the practical is [here](Practicals/Practical4a.zip)

- [Practical4b](Practical4b)

Material for the practical is [here](Practicals/temperature.croatia.zip)

Pdf of the lectures are [here](Pdfs/Day4.zip)

### Day 5 - Fri 1st Dec 2023

- [Session 5](Session5): Spatio-temporal models for geostatistical data

Break

- [Practical 5](Practical5)

Lunch

Pdf of the lecture is [here](Pdfs/Day5.zip)


**Afternoon session** (13.30-15.30): Participants will have the possibility to give a short presentation about their work/research and get feedback from their peers and from the teaching team. If you are interested please put your name and title of the presentation on this [form](https://docs.google.com/forms/d/e/1FAIpQLSe13bWUocGiRFVfmS72zSy9Ki2SdcA0h3QJvK8RCY9In-kaHQ/viewform?usp=sf_link)