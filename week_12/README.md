#Case Study 12

#Reading note
#leaflet mini charts and radarchart might be useful for my project
#radar chart can be used to pick out area that house high participation of green infrastructure and represent income and education
#leaflet mini charts can be used this way too



#Make a dygraph of recent daily maximum temperature data from Buffalo, NY



#install packages

library(dplyr)
library(ggplot2)
library(ggmap)
library(htmlwidgets)

install.packages("widgetframe")

library(widgetframe)

#download data


library(tidyverse)
library(rnoaa)

install.packages("xts")

install.packages("dygraphs")


library(xts)
library(dygraphs)
 
d=meteo_tidy_ghcnd("USW00014733",
                   date_min = "2016-01-01", 
                   var = c("TMAX"),
                   keep_flags=T) %>% 
   mutate(date=as.Date(date),
          tmax=as.numeric(tmax)/10) #Divide the tmax data by 10 to convert to degrees.

?xts          

d_xts<-xts(d$tmax, order.by = d$date)

?dygraph

?dyRangeSelector

dygraph(d_xts, main="Daily Maximum Temperature in Buffalo, NY") %>%
  dyRangeSelector(dateWindow = c("2020-01-01", "2020-10-31"))

