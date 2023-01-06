#library(pagedown)
#pagedown::chrome_print("index.html",output="index.pdf")


remotes::install_github("jhelvy/renderthis", force=TRUE)
remotes::install_github('rstudio/chromote')
install.packages("webshot2")

library(renderthis)

#List of files to convert
setwd("~/Dropbox/Bayes_Spatial_2023/Material/Session1.1")
to_pdf(from = "index.Rmd", partial_slides = TRUE)

setwd("~/Dropbox/Bayes_Spatial_2023/Material/Session1.2")
to_pdf(from = "index.html", partial_slides = TRUE)

setwd("~/Dropbox/Bayes_Spatial_2023/Material/Session2.1")
to_pdf(from = "index.html", partial_slides = TRUE)

setwd("~/Dropbox/Bayes_Spatial_2023/Material/Session2.2")
to_pdf(from = "index.html", partial_slides = TRUE)

setwd("~/Dropbox/Bayes_Spatial_2023/Material/Session3.1")
to_pdf(from = "index.Rmd", partial_slides = TRUE)

setwd("~/Dropbox/Bayes_Spatial_2023/Material/Session4.1")
to_pdf(from = "index.html", partial_slides = TRUE)

setwd("~/Dropbox/Bayes_Spatial_2023/Material/Session5.1")
to_pdf(from = "index.html", partial_slides = TRUE)

setwd("~/Dropbox/Bayes_Spatial_2023/Material/Session7.1")
to_pdf(from = "index.html", partial_slides = TRUE)

