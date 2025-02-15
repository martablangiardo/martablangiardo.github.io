
Welcome to this joint module between MSc Epi (Bayesian Reasoning and Methods for spatio-temporal data) and HDA (Advance Analytics).

Spatial and spatio-temporal analysis represent an increasingly important tool in public health research as well as in geographic and environmental epidemiology due to the emerging availability of spatial/temporal health data and the development of novel computational techniques, allowing for the analysis of large database.  

The module provides a comprehensive introduction to the concepts of Bayesian modelling and inference, and the statistical methods used in analysing spatial and spatio-temporal data.  In the first part of the course, students will learn about the main theoretical concepts of the Bayesian approach to probability and inference, before moving on to statistical modelling and interpretation. Successively, they will acquire concepts, methodologies and practical skills to manipulate, effectively visualize and model spatially- and temporally-related data. At the end of this module, students will be able to handle with confidence spatial and/or temporal data, identify patterns of dependence and level of noise in the data, describe and quantify risk of diseases as well as critically interpret and discuss the results from their analyses.  

Data analysis will be carried out using the statistical software R and model complexity will be handled within a Bayesian framework, while reproducible reporting will be ensured with R-Markdown. 

The module will be delivered by lectures and live computer-based tutorials and practicals, along with quizzes/practical sessions, which will include real-life examples (from environmental science as well as chronic and infectious disease epidemiology), simulative examples and hands-on project.  

**Download and Install R, RStudio and RTools**

We recommend installing the latest version of R, Rtools and Rstudio IDE (Integrated Development Environment). To do so, visit the links below:

- R: https://www.r-project.org/
- RStudio: https://posit.co/download/rstudio-desktop/
- RTools: https://cran.r-project.org/bin/windows/Rtools/

If you are installing R and RStudio for the first time, useful suggestions can be found here https://rstudio-education.github.io/hopr/starting.html

**R packages**

1. Install the **stable version of INLA**, following carefully the instructions at the package webpage: https://www.r-inla.org/download-install

2. Run the code below in R to install the main required R packages.
Note that, during the module's labs, we will work with additional R packages that will be installed at the occurrence.

install.packages("remotes")

pkg_list = c("sf", "spData", "terra", "stars", "sp", "spdep", "geoR", "fields", "gstat", "tmap", "ggplot2", "RColorBrewer","tidyverse", "mapview", "leaflet", "cowplot", "viridis", "patchwork", "knitr", "kableExtra", "mvtsplot", "GGally", "corrr", "SpatialEpi", "spTimer", "units", "stringr", "inlabru", "fmesher")

remotes::install_cran(pkg_list)

The html version of the slides and the practical material will be posted here before each week session.

## Timetable
### Day 1 - Mon 15th Jan 2024

- [Session 1.1 (html)](Session1.1): Introduction to Bayesian thinking (pdf [here](Session1.1/Session1.1.pdf))
- [Session 1.2 (html)](Session1.2): Introduction to Bayes Theorem (pdf [here](Session1.2/Session1.2.pdf))

Lunch

- [Practical 1 (html)](Practical1): Conditional/joint probability and Bayes theorem 

Complete material of practical 1 are [here](Practical1/Practical1.zip)

### Day 2 - Mon 22th Jan 2024

- [Session 2.1 (html)](Session2.1): Bayes Theorem for random variables and for general Bayesian inference; conjugate families (pdf [here](Session2.1/Session2.1.pdf))
- [Session 2.2 (html)](Session2.2): Posterior Predictive Distribution and Monte Carlo computation (pdf [here](Session2.2/Session2.2.pdf))

Lunch

- [Practical 2 (html)](Practical2): Conjugacy, prediction and Monte Carlo simulation

Complete material of practical 2 are [here](Practical2/Practical2.zip)

### Day 3 - Mon 29th Jan 2024

- [Session 3.1 (html)](Session3.1): Introduction to INLA and R-INLA (pdf [here](Session3.1/Session3.1.pdf))
- [Practical 3a](Practical3a): Tutorial on R-INLA

Complete material of practical 3a are [here](Practical3a/Practical3a.zip)

Lunch

- [Practical 3b](Practical3b): Regression and comparison of Bayesian vs Frequentist approach in R-INLA 

Complete material of practical 3b are [here](Practical3b/Practical3b.zip)

### Day 4 - Mon 5th Feb 2024

- [Session 4.1](Session4.1): Introduction to hierarchical models, choice of prior and model checking (pdf [here](Session4.1/Session4.1.pdf))
- [Practical 4](Practical4): Hierarchical models, regression and model checking in R-INLA

Lunch

- [Practical 4 (cont'd)](Practical4): Hierarchical models, regression and model checking in R-INLA

Complete material of practical 4 are [here](Practical4/Practical4.zip)


### Day 5 - Mon 12th Feb 2024

- [Session 5.1](Session5.1): Hierarchical models for longitudinal data (pdf [here](Session5.1/Session5.1.pdf))
- [Session 5.2](Session5.2): Missing data imputation (pdf [here](Session5.2/Session5.2.pdf))

Lunch

- [Practical 5](Practical5): Hierarchical models for longitudinal data and missing data imputation in R-INLA

Complete material of practical 5 are [here](Practical5/Practical5.zip)

Note that the last hour will be dedicated  to **Self directed learning**:  Maes et al, [Benefit of woodland and other natural environments for adolescents’ cognition and mental health](https://www.nature.com/articles/s41893-021-00751-1)

A pdf version is available [here](Practical5/s41893-021-00751-1.pdf)

### Day 6 - Mon 19th Feb 2024

- Paper discussion: Benefit of woodland and other natural environments for adolescents' cognition and mental health (1 hr)
- [Session 6](Session6):  Introduction to geospatial data (pdf [here](Session6/Session6.pdf))

Lunch

- [Practical 6a](Practical6a): Indirect standardization with R
- [Practical6b](Practical6b): Disease mapping study of COVID-19 mortality in England

Complete material of practical 6a are [here](Practical6a/Practical6a.zip)

Complete material of practical 6b are [here](Practical6b/Practical6b.zip)

### Day 7 - Mon 26th Feb 2024

- [Session 7](Session7): Spatial models for small area data: disease mapping and ecological regression (pdf [here](Session7/Session7.pdf))

Lunch

- [Practical 7](Practical7): A spatial model for vaccination uptake - This practical is based on the [paper](https://link.springer.com/article/10.1007/s10654-022-00905-1)

Complete material of practical 7 are [here](Practical7/Practical7.zip)

### Day 8 - Mon 4th March 2024

- [Session 8.1](Session8.1): Introduction to Geostatistics (pdf [here](Session8.1/Session8.1.pdf))

- [Session 8.2](Session8.2):  Introduction to SPDE model with R-INLA (pdf [here](Session8.2/Session8.2.pdf))

Lunch

- [Practical 8a](Practical8a): INLA-SPDE for geostatistical data: Temperature in Croatia

Complete material of practical 8a are [here](Practical8a/Practical8a.zip)

- [Practical 8b](Practical8b): Geostatistical Modelling for Childhood malaria in the Gambia

Complete material of practical 8b are [here](Practical8b/Practical8b.zip)

### Day 9 - Mon 11th March 2024

- [Session 9.1](Session9.1): Introduction to temporal modelling (pdf [here](Session9.1/Session9.1.pdf))

- [Session 9.2](Session9.2): Spatio-temporal modelling for area data (pdf [here](Session9.2/Session9.2.pdf))

Lunch

- [Practical 9](Practical9): Hospital admissions for respiratory conditions in Greater Glasgow and Clyde (2007-2011)

Complete material of practical 9 are [here](Practical9/Practical9.zip)

### Day 10 - Mon 18th March 2024

- [Session 10](Session10): Spatio-temporal model for geostatistical data (pdf [here](Session10/Session10.pdf))

Lunch

- [Practical 10](Practical10): Spatio-temoral estimation and prediction of ozone concentrations in New York

Complete material of practical 10 are [here](Practical10/Practical10.zip)

