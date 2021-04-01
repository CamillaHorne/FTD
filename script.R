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

data['GME Allocation'] <- sapply(data$SYMBOL, function(x) {
  if(x%in% etfTickers) return(etfs[etfs$Ticker == x,'GME.Allocation'])
  return(NA)
})

write.csv(data, 'result.csv', row.names = FALSE)
