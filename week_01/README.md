 ---
title: "Case Study 07"
author: Sun Ho Hwang
date: August 1, 2020
output: github_document

#download library

library(tidyverse)
library(reprex)
library(sf)
library(spData)
data(world)


view(world)

#code

ggplot(world,aes(x=gdpPercap, y=continent, color=continent))+
  geom_density(alpha=0.5,color=F)

#add 3 lines
#1.added fill=continent,2.got rid of y=continent to make y=density 3.xlab() and ylab()

ggplot(world,aes(gdpPercap, color=continent,fill=continent))+geom_density(alpha=0.5,color=F)+xlab("GDP Per Capita")+ylab("Density")