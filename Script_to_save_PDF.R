#library(pagedown)
#pagedown::chrome_print("index.html",output="index.pdf")


remotes::install_github("jhelvy/renderthis", force=TRUE)
remotes::install_github('rstudio/chromote')
install.packages("webshot2")

library(renderthis)
library(webshot2)
to_pdf(from = "index.html", partial_slides = TRUE)



