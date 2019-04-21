library(tidyverse)
library(rvest)
library(lubridate)
setwd("projects/iditarod2019/data")

getwd()

# save this  "https://iditarod.com/race/2019/checkpoints/3-Willow/",
# urls <- c("https://iditarod.com/race/2019/checkpoints/3-Willow/, https://iditarod.com/race/2018/checkpoints/4-Yentna/", "https://iditarod.com/race/2018/checkpoints/5-Skwentna/", "https://iditarod.com/race/2018/checkpoints/6-Finger-Lake/", "https://iditarod.com/race/2018/checkpoints/7-Rainy-Pass/", "https://iditarod.com/race/2018/checkpoints/8-Rohn/","https://iditarod.com/race/2018/checkpoints/9-Nikolai/","https://iditarod.com/race/2018/checkpoints/10-McGrath/", "https://iditarod.com/race/2018/checkpoints/11-Takotna/","https://iditarod.com/race/2018/checkpoints/12-Ophir/", "https://iditarod.com/race/2018/checkpoints/13-Iditarod/", "https://iditarod.com/race/2018/checkpoints/14-Shageluk/", "https://iditarod.com/race/2018/checkpoints/15-Anvik/", "https://iditarod.com/race/2018/checkpoints/16-Grayling/", "https://iditarod.com/race/2018/checkpoints/17-Kaltag/", "https://iditarod.com/race/2018/checkpoints/18-Unalakleet/", "https://iditarod.com/race/2018/checkpoints/19-Shaktoolik/", "https://iditarod.com/race/2018/checkpoints/20-Koyuk/", "https://iditarod.com/race/2018/checkpoints/21-Elim/", "https://iditarod.com/race/2018/checkpoints/22-White-Mountain/", "https://iditarod.com/race/2018/checkpoints/23-Safety/", "https://iditarod.com/race/2018/checkpoints/24-Nome/")
urls <- c("https://iditarod.com/race/2019/checkpoints/4-Yentna/", "https://iditarod.com/race/2019/checkpoints/5-Skwentna/", "https://iditarod.com/race/2019/checkpoints/6-Finger-Lake/","https://iditarod.com/race/2019/checkpoints/7-Rainy-Pass/", "https://iditarod.com/race/2019/checkpoints/8-Rohn/", "https://iditarod.com/race/2019/checkpoints/9-Nikolai/", "https://iditarod.com/race/2019/checkpoints/10-McGrath/", "https://iditarod.com/race/2019/checkpoints/11-Takotna/", "https://iditarod.com/race/2019/checkpoints/12-Ophir/", "https://iditarod.com/race/2019/checkpoints/13-Iditarod/", "https://iditarod.com/race/2019/checkpoints/14-Shageluk/", "https://iditarod.com/race/2019/checkpoints/15-Anvik/", "https://iditarod.com/race/2019/checkpoints/16-Grayling/", "https://iditarod.com/race/2019/checkpoints/17-Eagle-Island/", "https://iditarod.com/race/2019/checkpoints/18-Kaltag/", "https://iditarod.com/race/2019/checkpoints/19-Unalakleet/", "https://iditarod.com/race/2019/checkpoints/20-Shaktoolik/", "https://iditarod.com/race/2019/checkpoints/21-Koyuk/", "https://iditarod.com/race/2019/checkpoints/22-Elim/", "https://iditarod.com/race/2019/checkpoints/23-White-Mountain/", "https://iditarod.com/race/2019/checkpoints/24-Safety/", "https://iditarod.com/race/2019/checkpoints/25-Nome/")


# url <- "https://iditarod.com/race/2019/checkpoints/3-Willow/"
# url <- "https://iditarod.com/race/2019/checkpoints/4-Yentna/"
# 
# check1 <- read_html(url1, handle = curl::new_handle("useragent" = "Mozilla/5.0"))
# check1Table <- check1 %>% html_nodes('table') %>%  html_table(fill=T)
# check1Table <- as.data.frame(check1Table[[2]])
# View(check1Table)

# h1s <- 
# checkName <- h1s[[3]]
# View(check)


readCheck <- function(url) {
  
  checkPage <- read_html(url, handle = curl::new_handle("useragent" = "Mozilla/5.0")) 
  checkData <- checkPage %>% html_nodes('table') %>% html_table(fill=T)
  checkName <- checkPage %>% html_nodes('h1') %>% html_text()
  checkName <- checkName[[3]]
  checkDf <- as.data.frame(checkData[3])
  ifelse(checkName %in% c("Ophir", "Kaltag"), checkDf <- checkDf[2:nrow(checkDf) ,1:12], checkDf <- checkDf[2:nrow(checkDf) ,1:12] )
  names(checkDf) <- c("musher", "bib","intime","indogs", "outtime", "outdogs", "rest", "enroute","prev", "speed")
  checkDf$checkName <- checkName
  write_csv(checkDf, paste0("outCsv/",Sys.time(),checkName,".csv"))
  checkDf}




# 
# out1 <- readCheck(url1)
# out1 <- out1[,3:12]
# names(out1) <- c("musher", "bib","intime","indogs", "outtime", "outdogs", "rest", "enroute","prev", "prevOut")
# 
# 
# outComplete <- out1


###the full thing!!!
full2019 <- lapply(urls, readCheck) %>% bind_rows()


  names(full2019)[11] <- "junk"
  names(full2019)[12] <- "junk"
# names(full2019)[13] <- "checkName"

full2019 <- full2019[,1:13]
full2019 <- full2019 %>%  select(-11, -12)

write_csv(full2019, "full_2019.csv")

data19 <- read_csv("full_2019.csv")
data19 <-rename(data19, checkName = c("checkName"= "checkpoint" ))

data19 <- data19 %>% mutate(inTime = paste0("2019-", substr(intime, 1,length(intime)-9))) 
data19 <- data19 %>% mutate(inTime = gsub("/", "-", inTime))
data19 <- data19 %>% mutate(inTime = ymd_hms(inTime))

data19 <- data19 %>% mutate(outTime = paste0("2019-", substr(outtime, 1,length(outtime)-9))) 
data19 <- data19 %>% mutate(outTime = gsub("/", "-", outTime))
data19 <- data19 %>% mutate(outTime = ymd_hms(outTime))

data19 <- data19 %>% mutate(prevTime = paste0("2019-", substr(prev, 1,length(prev)-9))) 
data19 <- data19 %>% mutate(prevTime = gsub("/", "-", prevTime))
data19 <- data19 %>% mutate(prevTime = ymd_hms(prevTime))


data19 <- data19 %>% mutate (indogs = ifelse(!is.na(indogs), indogs, outdogs))
data19 <- data19 %>% mutate (outdogs = ifelse(!is.na(outdogs), outdogs, indogs))

data19 <-  data19 %>% mutate(enrouteTime = as.numeric(difftime(inTime, prevTime, units="mins")) , restTime = as.numeric(difftime(outTime,inTime, units="mins")))
data19 <- data19 %>% mutate(dropDogs = as.numeric(indogs)-as.numeric(outdogs))
data19 <- data19 %>% mutate(rest24 = ifelse(restTime >1440, 1, 0))
data19 <- data19 %>% group_by(checkName) %>% mutate(cpOrder = order(order(inTime))) %>% ungroup()
nomePlaces <- data19 %>% filter(checkName == "Nome") %>%  select(musher, cpOrder) %>% rename(finalOrder=cpOrder)


data19 <- left_join(data19, nomePlaces, by="musher")


write_csv(data19, "data19_1.csv")




############# add on Willow

data19 <- read_csv("data19_1.csv")
data19Willow <- data19 %>% filter(checkName =="Yentna")
data19Willow$checkName = "Willow"
data19Willow$enrouteTime = 0
data19Willow$restTime = 0
data19Willow$outdogs = data19Willow$indogs
data19Willow$speed = 0
data19Willow$inTime = data19Willow$prevTime
data19Willow$outTime = data19Willow$prevTime
data19Willow$cpOrder = data19Willow$bib -1
data19 <- rbind(data19, data19Willow)
data19 <- data19 %>% mutate(rest8 = ifelse(restTime <1440 & restTime >479, 1, 0))


write_csv(data19, "data19Complete_1.csv")


##starting here

data19 <- read_csv("data19Complete_1.csv")

#######summary############


# 1238-52
cpExit <- data19 %>% filter(outtime=="" & checkName == "Nome")
cpSummary <- data19 %>% filter(outtime!="") %>% group_by(checkName) %>% summarise(rest24 = sum(rest24), rest8 = sum(rest8), medianRest = median(restTime), fastest =min(enrouteTime), totalDogs = sum(dropDogs), averageInDogs = mean(indogs), medianInDogs = median(indogs), medianRest = median(restTime), averageSpeed = mean(speed), medianEnRoute = median(enrouteTime))
nomeSummary <- data19 %>% filter(checkName == "Nome") %>% group_by(checkName) %>% summarise(rest24 = sum(rest24), rest8 = sum(rest8), medianRest = median(restTime), fastest =min(enrouteTime), totalDogs = sum(dropDogs), averageInDogs = mean(indogs), medianInDogs = median(indogs), medianRest = median(restTime), averageSpeed = mean(speed), medianEnRoute = median(enrouteTime))

cpSummary <- rbind(cpSummary, nomeSummary)

distances <- read_csv("Distances.csv")
locations <- read_csv("locations.csv")



cpSummary <- left_join(cpSummary, distances, by=c("checkName"= "Checkpoint"))
cpSummary <-  left_join(cpSummary, locations, by=c("checkName"= "Checkpoint")) 
cpSummary <- cpSummary %>%  select(-17, -16,-15,-14)


# cpWillow <- cpSummary[1, ]
# cpWillow$checkName <- "Willow"
# 
# rbind(cpSummary, cpWillow) 61.744646, -150.059750

write_csv(cpSummary, "cpSummary1.csv")


cpSum <- read_csv("cpSummary1.csv")

# cpSum[22,] <- c("Willow",0,0,0,0,0,16,16,0,0,0,-150.059750,61.744646)

write_csv(cpSum, "cpSummaryW1.csv")
