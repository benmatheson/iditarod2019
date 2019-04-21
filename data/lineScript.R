library(tidyverse)
library(rvest)
library(lubridate)
library(jsonlite)
setwd("projects/iditarod2019/data")


getwd()

res <- read_csv("data19Complete.csv")
checkLoc <- read_csv("checkpoints.csv")

View(res)

resGroup <- res %>% group_by(musher, checkName) %>% summarise (checkPlace = cpOrder)
resGroupJoined <- left_join(resGroup, checkLoc, by=(c("checkName"="location")))

resGroupJoined <- resGroupJoined %>% select(1:4)
View(resGroupJoined)

write_csv(resGroupJoined, "resGroup.csv")
View(checkLoc)



uniqueMushers <- unique(res$musher)

write_csv(as.data.frame(uniqueMushers), "uniqueMushers.csv")


musherArray <- toJSON(uniqueMushers)
\


### this only selects the hours.


all <-  read_csv("allData.csv")

allSmall <- grepl("00:00", all$currentTimeStamp, value=T  )
allHour <- all %>% filter (grepl("00:00", currentTimeStamp  ))
write_csv(allHour,"allHour.csv")

View(allSmall)

# need to add cp index here somehow

