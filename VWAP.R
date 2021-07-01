
library(ggplot2)
library(quantmod)
library(data.table)

source('functions.R')

DT <- GetStockData(symbol = 'VZIO')
moltenDT <- melt.data.table(DT, id.vars = c('Date'))

ggplot(moltenDT[variable %in% c('CLOSE','OPEN', 'vwap')],
       aes(x = as.Date(Date), y = value, color = variable)) + 
  geom_line(size = 1.5) +
  xlab('') +
  scale_x_date(breaks = scales::date_breaks('1 week'), 
               labels = scales::date_format(format = '%b %d')) +
  theme_classic() +
  theme(legend.title = element_blank(),
        axis.text.x = element_text(angle = 45, hjust = 1 ))


