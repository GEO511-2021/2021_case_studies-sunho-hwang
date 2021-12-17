#Case Study 2
install.packages("tidyverse")

#download temperature data as csv file from NASA GISS Website-Buffalo NY

#define link in data
#https:\\data.giss.nasa.gov\tmp\gistemp\STATIONS\tmp_USW00014733_14_0_1\station.txt
dataurl="https://data.giss.nasa.gov/tmp/gistemp/STATIONS/tmp_USW00014733_14_0_1/station.txt"

#read table
temp=read.table(dataurl,skip=3,na="999.90",col.names = c("YEAR","JAN","FEB","MAR","APR","MAY","JUN","JUL","AUG","SEP","OCT","NOV","DEC","DJF","MAM","JJA","SON","METANN"))

#Question_WHY IS IT SKIP=3?NOT ONE???

#checkout data
View(temp)
summary(temp)
glimpse(temp)

#Question_cannot find glimps(temp)???


#Develop the Graph

ggplot(data=temp,aes(x=YEAR,y=JJA))+geom_smooth()+xlab("year")+ylab("mean_summer_temperature(c)")+ggtitle("Mean_Summer_Temperatures_Buffalo_NY")

#Where is the line graph?
bt<-ggplot(data=temp,aes(x=YEAR,y=JJA))+geom_smooth()+xlab("year")+ylab("mean_summer_temperature(c)")+ggtitle("Mean_Summer_Temperatures_Buffalo_NY")+geom_line()

#Question3_why is it not connected between 1880 and 1920?different from example on website.

#save a graphic to png file
#png() and dev.off or ggsave
png(filename="bt",width = 480, height = 480)
dev.off


ggsave("summertemp_Buff.png",width=10,height=10)
