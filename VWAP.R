
library(ggplot2)
library(data.table)
library(quantmod)

source('functions.R')

DT <- GetStockData(symbol = 'VZIO')
moltenDT <- melt.data.table(DT, id.vars = c('Date'))

ggplot(moltenDT[variable %in% c('CLOSE','OPEN', 'vwap')],
       aes(x = Date, y = value, color = variable)) + 
  geom_line(size = 1.5) +
  xlab('') +
  theme_classic() +
  theme(legend.title = element_blank())

