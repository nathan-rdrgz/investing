
library(ggplot2)
library(data.table)
library(quantmod)

GetStockData <- function(symbol=  "AG", 
                         datee1 = '2021-01-01', 
                         datee2 = Sys.Date()
                         ){
  baseURL <- "https://query1.finance.yahoo.com/v7/finance/download/"
  period1 <- "?period1="
  epoch1  <- as.integer(as.POSIXct( as.Date(datee1, tz ='America/Los_Angeles')))
  period2 <- "&period2="
  epoch2  <- as.integer(as.POSIXct( as.Date(datee2, tz ='America/Los_Angeles')))
  endURL  <- "&interval=1d&events=history&includeAdjustedClose=true"
  
  url <- paste0(baseURL, symbol, period1, epoch1, period2, epoch2, endURL)
  
  ind <-fread(url)
  
  setnames(ind,new = c('Date','OPEN','HIGH','LOW','CLOSE','Adj.Close','VOLUME'))
  ind[, vwap := VWAP(price = CLOSE, volume = VOLUME, n = 15)]
  ind  
}

DT <- GetStockData(symbol = 'VZIO')
moltenDT <- melt.data.table(DT, id.vars = c('Date'))

ggplot(moltenDT[variable %in% c('CLOSE','OPEN', 'vwap')],
       aes(x = Date, y = value, color = variable)) + 
  geom_line(size = 1.5) +
  xlab('') +
  theme_classic() +
  theme(legend.title = element_blank())

