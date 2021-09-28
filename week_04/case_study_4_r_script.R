#Farthest Airport from NYC
library(tidyverse)

library(nycflights13)
help(nycflights13)

#Step1: Look at data
head(flights)
str(flights)
glimpse(flights)
View(flights)

View(airports)
#I prefer view() because it shows you the whole graph.


#Airport faa is the abbreviation for each airport.It can be the origin and the 
#destination in the flights data

#Step2: Arrange and Slice
arrange(flights,desc(distance))
view(arrange(flights,desc(distance)))
#farthest is  HNL
#reference:https://dplyr.tidyverse.org/reference/arrange.html

#I tried slice 
flights%>%
  slice_max(distance,n=1)
#I can't see the distance so I wanted to just see the distance, origin and the destination 
flights2<-flights%>%
  count(origin,dest,distance)%>%
  slice_max(distance,n=1)
#HNL it is!!
flights2
#reference:https://dplyr.tidyverse.org/reference/slice.html


#Step3: Join two datasets using a common column
#why? to get to know the full name of the airport

#use the by function in left_join() and c()
flights3<-flights2 %>%
  left_join(airports,c("dest"="faa"))
#reference 13.relational data 13.4.5

#The answer is honolulu international airport
airports %>%
  filter(name == "Honolulu Intl")
#select is select column, so use filter to get content honolulu intl
farthest_airport <- airports[which(airports$name == "Honolulu Intl"), ] %>%
  pull(name)



#step 6 and 7
flights3 %>% select(name)%>% as.character()





