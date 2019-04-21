findLocation <- function(currentTime) { 
  
  currentData <- data19Gather %>% filter(musher == currentMusher)
  print(currentMusher)
  print(currentData)
  print(str(currentTime))
  print(str(data19Gather[1,3]))
  currentDataTimely <- filter(currentData, currentTime < currentData$time) %>% arrange(time)
  currentDataLatest <- currentDataTimely[1, ]
  musherLocation <-  paste0(currentDataLatest$checkName,"_", currentDataLatest$inOut)
  print(musherLocation)
  musherName <- currentMusher
  currentTimeStamp <- currentTime
  
  
  outPut <- data.frame(currentMusher, musherLocation, currentTimeStamp)
  }


outputBuser <- lapply(times, FUN=findLocation) %>% bind_rows()
