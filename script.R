data.frame.1a <- read.table('cnsfails202101a.txt', header = TRUE, sep = "|", na.strings = "", quote = '\\"')
data.frame.1b <- read.table('cnsfails202101b.txt', header = TRUE, sep = "|", na.strings = "", quote = '\\"')
data.frame.2a <- read.table('cnsfails202102a.txt', header = TRUE, sep = "|", na.strings = "", quote = '\\"')
data.frame.2b <- read.table('cnsfails202102b.txt', header = TRUE, sep = "|", na.strings = "", quote = '\\"')
data.frame.3a <- read.table('cnsfails202103a.txt', header = TRUE, sep = "|", na.strings = "", quote = '\\"')

etfs <- read.table('etfs.csv', header = TRUE, sep = ",", na.strings = "", quote = '\\"')
etfTickers <- etfs$Ticker

data.frame <- rbind(data.frame.1a, data.frame.1b, data.frame.2a, data.frame.2b, data.frame.3a)

gme <- data.frame[data.frame$SYMBOL == 'GME',]

data <- data.frame[data.frame$SYMBOL %in% etfTickers | data.frame$SYMBOL == 'GME',]
data$PRICE <- as.numeric(data$PRICE)

data['GME Allocation'] <- sapply(data$SYMBOL, function(x) {
  if(x%in% etfTickers) return(etfs[etfs$Ticker == x,'GME.Allocation'])
  return(NA)
})

data['Total price'] <- data$PRICE * data$QUANTITY..FAILS.

write.csv(data, 'result.csv', row.names = FALSE)

ftd <- data[data$QUANTITY..FAILS. >= 100000,]
write.csv(ftd, 'result_min100000.csv', row.names = FALSE)

ftd.over1 <- data[data$QUANTITY..FAILS. >= 100000 & (is.na(data$`GME Allocation`) | data$`GME Allocation` > 1),]
write.csv(ftd.over1, 'result_min100000_1_percent.csv', row.names = FALSE)


ftd.allover1 <- data[is.na(data$`GME Allocation`) | data$`GME Allocation` > 1,]

sum(ftd.allover1$`Total price`)
sum(ftd.allover1$QUANTITY..FAILS.)
