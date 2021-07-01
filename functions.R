GetStockData <- function(symbol=  "AG", 
                         datee1 = '2021-01-01', 
                         datee2 = Sys.Date()
){
  baseURL <- "https://query1.finance.yahoo.com/v7/finance/download/"
  period1 <- "?period1="
  epoch1  <- as.integer(as.POSIXct(as.Date(datee1, tz ='America/Los_Angeles')))
  period2 <- "&period2="
  epoch2  <- as.integer(as.POSIXct(as.Date(datee2, tz ='America/Los_Angeles')))
  endURL  <- "&interval=1d&events=history&includeAdjustedClose=true"
  
  url <- paste0(baseURL, symbol, period1, epoch1, period2, epoch2, endURL)
  ind <- fread(url)
  
  setnames(ind,new = c('Date','OPEN','HIGH','LOW','CLOSE','Adj.Close','VOLUME'))
  ind[, vwap := VWAP(price = CLOSE, volume = VOLUME, n = 15)]
  return(ind)
}