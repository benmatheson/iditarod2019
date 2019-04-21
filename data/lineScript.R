library(tidyverse)
library(rvest)
library(lubridate)
setwd("projects/iditarod2019/data")


getwd()

res <- read_csv("data19Complete.csv")
checkLoc <- read_csv("data19Complete.csv")

View(res)

resGroup <- res %>% group_by(musher, checkName) %>% summarise (checkPlace = cpOrder)
resGroup


write_csv(resGroup, "resGroup.csv")
View(resGroup)



# need to add cp index here somehow

