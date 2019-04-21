library(tidyverse)
library(rvest)
library(lubridate)
library(jsonlite)
setwd("projects/iditarod2019/data")

getwd()


data19 <- read_csv("data19Complete.csv")


indexes <- 1:2162
times19 <- as.data.frame(indexes)
times19 <- times19 %>% mutate(times = ymd_hms('2019-03-03 13:50:00') + indexes*(dminutes(10)))
times <- times19$times

data19Gather <- data19 %>% gather(key = "inOut" , value = "time", c(12,13))
data19Gather <- data19Gather %>% select(1, 20, 21, 11, 17)
data19Gather <- data19Gather %>% mutate (time1= time)




#### Trying to fix willoww
data19GatherWillow <- data19Gather %>% filter(checkName == "Willow" & inOut =="inTime") %>% mutate("time"= ymd_hms('2019-03-03 14:00:00'))
data19GatherNoWillow <- data19Gather %>% filter(!checkName == "Willow"  | checkName =="Willow" & inOut =="outTime") 
data19Gather <- rbind(data19GatherNoWillow, data19GatherWillow)

##musher names and stuff. 
 
mushers <- read_csv("data19Complete.csv")
musherNames <- unique(mushers$musher)

musherTimes <- as.data.frame(musherNames, times)


# currentMusher <- "Martin Buser"

# 
# test1  <- times[2]
# test2 <- data19Gather[1, ]$time
# 
# test1 <test2 


allMushers <- function(currentMusher) {

findLocation <- function(currentTime) { 
  
  currentData <- data19Gather %>% filter(musher == currentMusher)
  print(currentMusher)
  print(currentData)
  print(str(currentTime))
  print(str(data19Gather[1,3]))
  ##filtering musher times for all times befpre the current time. then arrages so the LATEST is top
  currentDataTimely <- filter(currentData, currentTime > time) %>% arrange(desc(time))
  currentDataLatest <- currentDataTimely[1, ]
  musherLocation <-  paste0(currentDataLatest$checkName,"_",currentDataLatest$inOut)
  print(musherLocation)
  musherName <- currentMusher
  currentTimeStamp <- currentTime
  cpOrder1 <- currentDataLatest$cpOrder
  outPut <- data.frame(currentMusher, musherLocation, currentTimeStamp, cpOrder1)
}

outputIndv <- lapply(times, FUN=findLocation) %>% bind_rows()
}

allMusherAllTimes <- lapply(musherNames, allMushers) %>% bind_rows()
write_csv(allMusherAllTimes, "allMusherAllTimes1.csv")


View(allMusherAllTimes)


####LATEST HERE

allData <- read_csv("allMusherAllTimes.csv")

# unqLocations <- unique(allData$musherLocation)
# View(unqLocations)

locationIndex <- read_csv("locationIndex.csv") %>% select(1,2)

allData$musherLocation[allData$musherLocation == "NA_NA"] <- "Willow_inTime"
allData1 <- left_join(allData, locationIndex, by = c("musherLocation"= "location"))
allData2 <- allData1 %>% group_by(currentTimeStamp, musherLocation) %>% arrange() mutate(relOrder = row_number())




write_csv(allData2, "allData.csv")

View(allData2)



###unique times 

# uniqueTimes <- unique(data19GatherFull$time)
write_json(times19$times, "uniqueTimes.json")
View(uniqueTimes)



