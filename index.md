
Welcome to this joint module between MSc Epi (Bayesian Reasoning and Methods for spatio-temporal data) And HDA (Advance Analytics).

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

```{r, eval=FALSE, echo=TRUE}
# Packages
install.packages("remotes")

pkg_list = c("sf", "spData", "terra", "stars", "sp", "spdep", "geoR", "fields", "gstat", "tmap", "ggplot2", "RColorBrewer","tidyverse", "mapview", "leaflet", "cowplot", "viridis", "patchwork", "knitr", "kableExtra", "mvtsplot", "GGally", "corrr", "SpatialEpi", "spTimer", "units", "stringr", "inlabru", "fmesher")

remotes::install_cran(pkg_list)
```

The html version of the slides and the practical material will be posted here before each week session

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
