# Case Study 5

#Objective

#Generate a polygon that includes all land in NY that is within 10km of the Canadian border (not including the great lakes).

#Calculate it’s area in km^2. How much land will you need to defend from the Canadians?

#upload packages

library(spData)
library(sf)
library(tidyverse)
library(units) 

#load 'world' data from spData package
data(world)  
# load 'states' boundaries from spData package
data(us_states)
# plot(world[1])  #plot if desired
# plot(us_states[1]) #plot if desired


#Step 1

albers="+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=37.5 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs"

world_alb <- st_transform(world, albers)

Canada <- world_alb %>%
  filter(name_long == "Canada")

Canada_buffer <- st_buffer(Canada, 10000)

#Step 2

us_states_alb <- st_transform(us_states, albers)

New_York <- us_states_alb %>%
  filter(NAME == "New York")

#Step 3

border <- st_intersection(Canada_buffer, New_York)

ggplot() +
  geom_sf(data = New_York) +
  geom_sf(data = border, fill = "red") +
  labs(title = "New York Land within 10km") +
  theme(plot.title = element_text(size = 20))


area_border <- st_area(border)
set_units(area_border, km^2)

