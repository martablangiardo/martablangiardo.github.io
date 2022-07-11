
The course will provide a focus on how to use the Integrated Nested Laplace Approximation approach (INLA) for the analysis of spatial and spatio-temporal data.

We will first go through the basic of INLA for Bayesian inference and will then see how to model hierarchical structures. We will then focus on area level data and present how to model spatially structured random effects through conditional autoregressive specifications; following that, we will extend the approach to include temporal dependency and touch briefly on spatio-temporal interactions.

Moving on to point-referenced data we will introduce the stochastic partial differential equation (SPDE) approach, used for spatial modelling on a continuous field. We will then extend this to deal with spatio-temporal data. Finally we will describe how to use R-INLA for more advanced problems in the spatio-temporal realm, for instance how to deal with misaligned data or how to model two outcomes jointly.

The course will maintain a very practical angle, with a mixture of lectures and practical sessions. For a book covering the topics of the course see [here](https://onlinelibrary.wiley.com/doi/book/10.1002/9781118950203). 

It is recommended that people attending are familiar with [R](https://www.r-project.org/) and with the basic of the Bayesian approach.

It would be beneficial if attendees could bring their laptop having installed the latest R (version 4.2.1) and the following packages:

- INLA (install.packages("INLA", repos="http://www.math.ntnu.no/inla/R/stable"))

- sf, spdep, SpatialEpi, RColorBrewer, tmap, ggplot2, mapview, cowplot, dplyr, tidyr, viridis, patchwork, knitr, kableExtra

## Timetable (with slides)
### Day 1 - Wed 20th July 2022 - morning

- [Session 1.1](Session1.1): Lecture on introduction to INLA and R-INLA
- [Session 1.2](Session1.2): Hierarchical models, priors, prediction and model checking
- Break
- [Practical 1](Practical1): INLA basics (1a); hierarchical models for disease mapping (1b)

### Day 1 - Wed 20th July 2022 - afternoon

- [Session 1.4](Session1.3): Spatial models for small area data: disease mapping and ecological regression
- [Session 1.5](Session1.4): Spatio-temporal modelling for area data
- Break
- [Practical 2](Practical2): Spatial and spatio-temporal disease mapping and regression

### Day 2 - Thur 21th July 2022 - morning

- [Session 1.5](Session1.5): Models for geostatistical data and introduction to SPDE
- [Session 1.6](Session1.6): inla.stack and inlabru
- Break
- [Practical 3](Practical3): INLA-SPDE for geostatistical data

### Day 2 - Thur 21th July 2022 - afternoon

- [Session 1.7](Session1.7): Spatio-temporal model for geostatistical data
- [Session 1.8](Session1.8): Advanced INLA features
- Break
- [Practical 4](Practical4): A space-time model with inlabru

