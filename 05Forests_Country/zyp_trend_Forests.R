library(dplyr)
library(zyp)
library(readxl)
#setwd('')
data.res <- read_xlsx("Forests_Country.xlsx")
colnames(data.res)[1] <- 'ID1'
##Part1 For PA
time_da<- c(2000:2020)
t.dat1<- as.numeric(time_da)
dat <- data.res[,2:22]

trend.dat<-dat[1,]
pa.trend.afterall <- zyp.trend.vector(trend.dat, time_da, method="yuepilon")#????2

for (i in 2:nrow(dat)){
  trend.dat<-dat[i,]
  pa.trend <- zyp.trend.vector(trend.dat, time_da, method="yuepilon")#????2
  pa.trend.afterall <- rbind(pa.trend.afterall,pa.trend)
}

pa.trend.afterall2<-cbind(pa.trend.afterall,data.res$ID1)
write.csv(pa.trend.afterall2,'Forests_CountryTrend.csv')