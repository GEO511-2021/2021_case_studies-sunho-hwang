#Case Study 11

library(tidyverse)
library(spData)
library(sf)


## New Packages

library(mapview) # new package that makes easy leaflet maps
library(foreach)
library(doParallel)
registerDoParallel(4)
getDoParWorkers() # check registered cores


library(tidycensus)

census_api_key("")

#download data

library(tidycensus)
racevars <- c(White = "P005003", 
              Black = "P005004", 
              Asian = "P005006", 
              Hispanic = "P004003")

options(tigris_use_cache = TRUE)
erie <- get_decennial(geography = "block", variables = racevars, 
                  state = "NY", county = "Erie County", geometry = TRUE,
                  summary_var = "P001001", cache_table=T) 

#crop county level data

erie_crop=st_crop(erie,xmin=-78.9,xmax=-78.85,ymin=42.888,ymax=42.92)


#foreach

race<-foreach(r=unique(erie_crop$variable),.combine=rbind) %dopar% { filter(erie_crop,variable==r)%>%
    st_sample(size=.$value)%>%  
    st_as_sf()%>% 
    mutate(variable=r)
}

#error #Error in { : task 1 failed - "could not find function "%>%""
#ran do instead of dopar
#do works


mapview(race, zcol="variable", cex=0.1, alpha = 0)




