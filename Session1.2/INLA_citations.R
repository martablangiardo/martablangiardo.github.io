setwd("C:/Users/magb/Downloads")
citations <- read.table("scopus.csv")
citations <- read.csv("scopus.csv")
dim(citations)
citations<- as.tibble(citations)
citations<- as_tibble(citations)
library(tidyverse)
citations<- as_tibble(citations)
citations
cit.year<- citations %>% tally(Year)
cit.year
cit.year<- citations %>% tally(Title, by(Year))
cit.year<- group_by(citations, Year) %>% tally()
cit.year
ggplot(cit.year, aes(x=Year, y=n))
ggplot(cit.year, aes(x=Year, y=n)) + geom_line()
ggplot(cit.year[1:15,], aes(x=Year, y=n)) + geom_line()
ggplot(cit.year[1:15,], aes(x=Year, y=n)) + geom_line(color="red") + geom_point()
P=ggplot(cit.year[1:15,], aes(x=Year, y=n)) + geom_line(color="red") + geom_point()
p
P
P + theme( axis.line = element_line(colour = "darkblue",
                                    size = 1, linetype = "solid"))
P + theme( axis.line = element_line(colour = "black",
                                    linewidth = 0.5, linetype = "solid"))