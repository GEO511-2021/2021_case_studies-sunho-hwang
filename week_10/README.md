title: "Case Study 10"
author: Sun Ho Hwang
date: November 9, 2021
output: github_document
---
#load packages
install.packages("rasterVis")

library(raster)
library(sp)
library(rasterVis)
library(rgdal)
library(ggmap)
library(tidyverse)
library(knitr)
library(ncdf4)

#download data

 # Create a folder to hold the downloaded data
 
##dir.create("data",showWarnings = F) #create a folder to hold the data

##lulc_url="https://github.com/adammwilson/DataScienceData/blob/master/inst/extdata/appeears/MCD12Q1.051_aid0001.nc?raw=true"

##lst_url="https://github.com/adammwilson/DataScienceData/blob/master/inst/extdata/appeears/MOD11A2.006_aid0001.nc?raw=true"

## 
## # download them

##download.file(lulc_url,destfile="data/MCD12Q1.051_aid0001.nc", mode="wb")

##download.file(lst_url,destfile="data/MOD11A2.006_aid0001.nc", mode="wb")

##

#load data to R

lulc=stack("data/MCD12Q1.051_aid0001.nc",varname="Land_Cover_Type_1")

lst=stack("data/MOD11A2.006_aid0001.nc",varname="LST_Day_1km")

#Explore!

plot(lulc)


#Pick one year
lulc=lulc[[13]]


plot(lulc)

#Classification

 Land_Cover_Type_1 = c(
    Water = 0, 
    `Evergreen Needleleaf forest` = 1, 
    `Evergreen Broadleaf forest` = 2,
    `Deciduous Needleleaf forest` = 3, 
    `Deciduous Broadleaf forest` = 4,
    `Mixed forest` = 5, 
    `Closed shrublands` = 6,
    `Open shrublands` = 7,
    `Woody savannas` = 8, 
    Savannas = 9,
    Grasslands = 10,
    `Permanent wetlands` = 11, 
    Croplands = 12,
    `Urban & built-up` = 13,
    `Cropland/Natural vegetation mosaic` = 14, 
    `Snow & ice` = 15,
    `Barren/Sparsely vegetated` = 16, 
    Unclassified = 254,
    NoDataFill = 255)

lcd=data.frame(
  ID=Land_Cover_Type_1,
  landcover=names(Land_Cover_Type_1),
  col=c("#000080","#008000","#00FF00", "#99CC00","#99FF99", "#339966", "#993366", "#FFCC99", "#CCFFCC", "#FFCC00", "#FF9900", "#006699", "#FFFF00", "#FF0000", "#999966", "#FFFFFF", "#808080", "#000000", "#000000"),
  stringsAsFactors = F)


# colors from https://lpdaac.usgs.gov/about/news_archive/modisterra_land_cover_types_yearly_l3_global_005deg_cmg_mod12c1

kable(head(lcd))

#Convert LULC raster into a 'factor' (categorical) raster

# convert to raster (easy)

lulc=as.factor(lulc)

# update the RAT with a left join

levels(lulc)=left_join(levels(lulc)[[1]],lcd)

#plot


gplot(lulc)+
  geom_raster(aes(fill=as.factor(value)))+
  scale_fill_manual(values=levels(lulc)[[1]]$col,
                    labels=levels(lulc)[[1]]$landcover,
                    name="Landcover Type")+
  coord_equal()+
  theme(legend.position = "bottom")+
  guides(fill=guide_legend(ncol=1,byrow=TRUE))
  
  #Land Surface Temperature
  
  plot(lst[[1:12]])
  
  offs(lst)=-273.15
  
  plot(lst[[1:10]])
  
  
  
  #Modland
  
  lstqc=stack("data/MOD11A2.006_aid0001.nc",varname="QC_Day")
plot(lstqc[[1:2]])


values(lstqc[[1:2]])%>%table()  

intToBits(65)  

intToBits(65)[1:8]

as.integer(intToBits(65)[1:8])

rev(as.integer(intToBits(65)[1:8]))


## set up data frame to hold all combinations

QC_Data <- data.frame(Integer_Value = 0:255,
Bit7 = NA, Bit6 = NA, Bit5 = NA, Bit4 = NA,
Bit3 = NA, Bit2 = NA, Bit1 = NA, Bit0 = NA,
QA_word1 = NA, QA_word2 = NA, QA_word3 = NA,
QA_word4 = NA)

## 

for(i in QC_Data$Integer_Value){
AsInt <- as.integer(intToBits(i)[1:8])
QC_Data[i+1,2:9]<- AsInt[8:1]
}

QC_Data$QA_word1[QC_Data$Bit1 == 0 & QC_Data$Bit0==0] <- "LST GOOD"
QC_Data$QA_word1[QC_Data$Bit1 == 0 & QC_Data$Bit0==1] <- "LST Produced,Other Quality"
QC_Data$QA_word1[QC_Data$Bit1 == 1 & QC_Data$Bit0==0] <- "No Pixel,clouds"
QC_Data$QA_word1[QC_Data$Bit1 == 1 & QC_Data$Bit0==1] <- "No Pixel, Other QA"

QC_Data$QA_word2[QC_Data$Bit3 == 0 & QC_Data$Bit2==0] <- "Good Data"
QC_Data$QA_word2[QC_Data$Bit3 == 0 & QC_Data$Bit2==1] <- "Other Quality"
QC_Data$QA_word2[QC_Data$Bit3 == 1 & QC_Data$Bit2==0] <- "TBD"
QC_Data$QA_word2[QC_Data$Bit3 == 1 & QC_Data$Bit2==1] <- "TBD"

QC_Data$QA_word3[QC_Data$Bit5 == 0 & QC_Data$Bit4==0] <- "Emiss Error <= .01"
QC_Data$QA_word3[QC_Data$Bit5 == 0 & QC_Data$Bit4==1] <- "Emiss Err >.01 <=.02"
QC_Data$QA_word3[QC_Data$Bit5 == 1 & QC_Data$Bit4==0] <- "Emiss Err >.02 <=.04"
QC_Data$QA_word3[QC_Data$Bit5 == 1 & QC_Data$Bit4==1] <- "Emiss Err > .04"

QC_Data$QA_word4[QC_Data$Bit7 == 0 & QC_Data$Bit6==0] <- "LST Err <= 1"
QC_Data$QA_word4[QC_Data$Bit7 == 0 & QC_Data$Bit6==1] <- "LST Err > 2 LST Err <= 3"
QC_Data$QA_word4[QC_Data$Bit7 == 1 & QC_Data$Bit6==0] <- "LST Err > 1 LST Err <= 2"
QC_Data$QA_word4[QC_Data$Bit7 == 1 & QC_Data$Bit6==1] <- "LST Err > 4"
kable(head(QC_Data))


keep=QC_Data[QC_Data$Bit1 == 0,]
keepvals=unique(keep$Integer_Value)
keepvals


qcvals=table(values(lstqc))  # this takes a minute or two


QC_Data%>%
  dplyr::select(everything(),-contains("Bit"))%>%
  mutate(Var1=as.character(Integer_Value),
         keep=Integer_Value%in%keepvals)%>%
  inner_join(data.frame(qcvals))%>%
  kable()


lstkeep=calc(lstqc,function(x) x%in%keepvals)

gplot(lstkeep[[4:8]])+
  geom_raster(aes(fill=as.factor(value)))+
  facet_grid(variable~.)+
  scale_fill_manual(values=c("blue","red"),name="Keep")+
  coord_equal()+
  theme(legend.position = "bottom")


lst=mask(lst,mask=lstkeep,maskval=0)


names(lst)[1:5]


tdates=names(lst)%>%
  sub(pattern="X",replacement="")%>%
  as.Date("%Y.%m.%d")

names(lst)=1:nlayers(lst)
lst=setZ(lst,tdates)

#Part 1_Extract Time Series for point

#step 1
#define a new spatial point

lw=SpatialPoints(data.frame(x= -78.791547,y=43.007211))

#step2
#set the projection of your point

projection(lw) <- "+proj=longlat"

#step3
#transform the point of projection to raster

lw=spTransform(lw,crs(lst))

#crs_coordinate reference system

#step4
#extract lst and transpose from wide matrix to vector


extraction<-raster::extract(lst,lw,buffer=1000,fun=mean,na.rm=T) %>%
  t()



#Step 5
#use getZ(lst) to extract each layer with dates
#combine with dataframe above

df<-bind_cols(extraction,getZ(lst))

df

names(df) <-c("temp","date")

df

#Step 6

df %>%
ggplot(aes(x=date,y=temp)) + geom_point() + geom_smooth(n=nrow(df),span=0.01)

#n:number of points to evaluate

#Part2
#Calculate monthly mean land surface temperature

#Step1
#make a variable t month, convert dates to month

tmonth<- as.numeric(format(getZ(lst),"%m"))

#Step2
#use stackApply to summarize mean value per month

lst_month <- stackApply(lst,tmonth,fun=mean)

#Step3
#set the names of layers to months

names(lst_month)=month.name

#Step4
#plot the map for each month

gplot(lst_month)+geom_raster(aes(fill=value)) + facet_wrap(~variable) + coord_equal()+ theme(legend.position="right") + scale_fill_continuous()

#Step5
#Calculate monthly mean for entire image

cellStats(lst_month,mean)




#no part 3!!