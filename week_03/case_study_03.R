#Case study 3
library(ggplot2)
library(gapminder)
library(dplyr)
library(tidyverse)

#data?
gapminder
?gapminder
str(gapminder)

#remove Kuwait
#???I can't figure out how to remove Kuwait
gapminder
gapminder_filtered <- gapminder %>%
  filter(!is.na("Kuwait"))
gapminder_filtered
?filter
str(gapminder_filtered)
#???how do you check if kuwait was filtered? you can only see the first part




#plot1
plot1<-ggplot(data=gapminder_filtered,mapping=aes(lifeExp,gdpPercap))+
  geom_point(mapping=aes(color=continent,size= pop/100000))+ scale_y_continuous(trans = "sqrt")+ 
  facet_wrap(~year,nrow=1)+ 
  theme_bw()+ 
  labs()
# why is y continuous and why do we put it into squared root?
#when you do color="blue" is this outside of aes() , what is the rule?
#plus has to come at end of the line
#try to change labs more
?facet_wrap  
?labs
#????I think I didn't get rid of Kuwait


#save,check again
ggsave(plot1,width=15,units="in")
?ggsave






#????Prepare data for plot2
gapminder_filtered %>% group_by(continent,year)
gapminder_continent <- gdpPercapweighted = weighted.mean(x = gdpPercap, w = pop)
pop = sum(as.numeric(pop))

#????plot2
ggplot(gapminder)+geom_line+geom_point()+geom_line(data=newdata)+geom_point(data=newdata)+facet_wrap+theme_bw()+labs()

#ggsave ,width 15 inches


