
Welcome to the Bayesian modelling for Spatial and Spatio-Temporal Data module.

Spatial and spatio-temporal analysis represent an increasingly important tool in public health research as well as in geographic and environmental epidemiology due to the emerging availability of spatial/temporal health data and the development of novel computational techniques, allowing for the analysis of large database.  

The module provides a comprehensive introduction to the concepts of Bayesian modelling and inference, and the statistical methods used in analysing spatial and spatio-temporal data.  In the first part of the course, students will learn about the main theoretical concepts of the Bayesian approach to probability and inference, before moving on to statistical modelling and interpretation. Successively, they will acquire concepts, methodologies and practical skills to manipulate, effectively visualize and model spatially- and temporally-related data. At the end of this module, students will be able to handle with confidence spatial and/or temporal data, identify patterns of dependence and level of noise in the data, describe and quantify risk of diseases as well as critically interpret and discuss the results from their analyses.  

Data analysis will be carried out using the statistical software R and model complexity will be handled within a Bayesian framework, while reproducible reporting will be ensured with R-Markdown. 

The module will be delivered by lectures and live computer-based tutorials and practicals, along with quizzes/practical sessions (homework, but not formally assessed), which will include real-life examples (from environmental science as well as chronic and infectious disease epidemiology), simulative examples and hands-on project.  

It would be beneficial if attendees could bring their laptop having installed the latest R (version 4.2.1) and the following packages:

- INLA (install.packages("INLA", repos="http://www.math.ntnu.no/inla/R/stable"))

- install.packages("remotes")
pkg_list = c("sf", "spData", "terra", "stars", "sp", "spdep", "geoR", "fields", "gstat", "tmap", "ggplot2", "RColorBrewer","dplyr", "tidyr", "mapview", "leaflet", "cowplot", "viridis", "patchwork", "knitr", "kableExtra", "lubridate", "mvtsplot", "GGally", "corrr", "SpatialEpi", "spTimer", "units", "stringr")
remotes::install_cran(pkg_list)


The html version of the slides and the practical material will be posted here before each week session

## Timetable
### Day 1 - Mon 16th Jan 2023

- [Session 1.1](Session1.1): Introduction to Bayesian thinking
- [Session 1.2](Session1.2): Introduction to Bayes Theorem

Break

- [Practical 1](Practical1): Conditional/joint probability and Bayes theorem 

Solutions of practical 1 are [here](Practical1/solutions.html)

### Day 2 - Mon 23th Jan 2023

- [Session 2.1](Session2.1): Bayes Theorem for random variables and for general Bayesian inference; conjugate families
- [Session 2.2](Session2.2): Posterior Predictive Distribution and Monte Carlo computation

Break

- [Practical 2](Practical2): Conjugacy, prediction and Monte Carlo simulation

Solutions of practical 2 are [here](Practical2/solutions.html)

### Day 3 - Mon 30th Jan 2023

- [Session 3.1](Session3.1): Introduction to INLA and R-INLA (there will be a 10 minute break halfway through it)

Break

- [Practical 3a](Practical3a): Tutorial on R-INLA

Lunch

- [Practical 3b](Practical3b): Regression and comparison of Bayesian vs Frequentist approach in R-INLA

Solutions of practical 3b are [here](Practical3b/Practical3b_Solutions.html)


### Day 4 - Mon 6th Feb 2023

- [Session 4.1](Session4.1): Introduction to hierarchical models, choice of prior and model checking (there will be a 10 minute break halfway through it)) 

- [Practical 4](Practical4): Hierarchical models, regression and model checking in R-INLA

The dataset for this practical can be downloaded [here](Practical4/gambia.RData)

Lunch

- [Practical 4 (cont'd)](Practical4): Hierarchical models, regression and model checking in R-INLA

Solutions of practical 4 are [here](Practical4/Practical4_Solutions.html)

### Day 5 - Mon 13th Feb 2023

- [Session 5.1](Session5.1): Hierarchical models for longitudinal data

Break

- [Session 5.2](Session5.2): Missing data imputation

Lunch

- [Practical 5](Practical5): Hierarchical models for longitudinal data and missing data imputation in R-INLA

Solutions of practical 5 are [here](Practical5/Practical5_Solutions.html)

- Independent paper reading: "Benefit of woodland and other natural environments for adolescents’ cognition and mental health" [link here](https://www.nature.com/articles/s41893-021-00751-1) 

### Day 6 - Mon 20th Feb 2023

- Group Discussion on the paper: "Benefit of woodland and other natural environments for adolescents’ cognition and mental health" [link here](https://www.nature.com/articles/s41893-021-00751-1) 

Break

- [Session 6](Session6): Intro to geospatial data

Lunch

- [Practical 6a](Practical6a): How to calculate expected values

Solutions of practical 6a are [here](Practical6a/Practical6a.html)

- [Practical 6b](Practical6b): Disease mapping with R-INLA: models and visualisation

Solutions of practical 6b are [here](Practical6b/Practical6b.html)
