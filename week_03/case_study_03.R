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
  filter(country !="Kuwait")
gapminder_filtered
?filter
str(gapminder_filtered)
#???how do you check if kuwait was filtered? you can only see the first part
#a tibble changed from 1704*6 to 
#view(gapminder_filtered): you can see graph without kuwait
view(gapminder_filtered)



#plot1
plot1<-ggplot(data=gapminder_filtered,mapping=aes(lifeExp,gdpPercap))+
  geom_point(mapping=aes(color=continent,size= pop/100000))+ scale_y_continuous(trans = "sqrt")+ 
  facet_wrap(~year,nrow=1)+ 
  theme_bw()+ 
  labs(x="Life Expectancy", y="GDP per Capita", size="Population(100k)",color="continent")

plot1
ggsave("plot1.png",plot=plot1,width=15)
# why is y continuous and why do we put it into squared root?
#
#when you do color="blue" is this outside of aes() , what is the rule?
#
#plus has to come at end of the line
#try to change labs more
?facet_wrap 
#why is year nrow=1


?labs
#????I think I didn't get rid of Kuwait


#save,check again
ggsave(plot1,width=15,units="in")
?ggsave






#????Prepare data for plot2
gapminder_continent <-gapminder_filtered %>% group_by(continent,year) %>%
                     summarize(gdpPercapweighted = weighted.mean(x = gdpPercap, w = pop),
                     pop = sum(as.numeric(pop)))

#????plot2
ggplot(gapminder)+geom_line+geom_point()+geom_line(data=newdata)+geom_point(data=newdata)+facet_wrap+theme_bw()+labs()

#ggsave ,width 15 inches


