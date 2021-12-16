data("iris")

x=iris$Petal.Length

mean(iris$Petal.Length)

hist(x)

library(ggplot2)

ggplot(iris,aes(x=Petal.Length,fill=Species))+geom_histogram(binwidth=0.5,position="stack",color=NA,alpha=0.8)    

# aes decides x or y, fill=species means fill differently by species, position: stack on top,alpha: how transparent       



esquisser(): you can find code  

