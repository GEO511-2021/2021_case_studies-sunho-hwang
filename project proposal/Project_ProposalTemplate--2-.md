Proposal
================
Sun Ho Hwang

[<i class="fa fa-file-code-o fa-1x" aria-hidden="true"></i> Download
this file as a
template](http://adamwilson.us/SpatialDataScience/scripts/Project_ProposalTemplate.Rmd).

# Introduction to problem/question

Due to global warming, one of the difficulties that the urban
environment face is the increase of precipitation. There is a chance
that this will lead to water pollution as the stormwater that runs
through the urban impervious surface collects pollutants and enters the
sewer system. There has been continuous effort to implement green
infrastructure to adapt to this environmental change. However there are
certain limits because this involves the voluntary participation of
individual households. This study will help understand the demographic
information of the participants of the past rain barrel project and help
guide environmental organizations to plan who to target next for green
infrastructure projects. \# Problem / Question This project will analyze
the motivation of households participating in the rain barrel project
comparing contributing factors such as the education attainment and
median income. \# Inspiring Examples

## Example 1

&lt; Median Income Distribution Map &gt; Link:
<http://www.energyjustice.net/justice/index.php?gsLayer=income>

![Example1](http://www.energyjustice.net/justice/index.php?gsLayer=income)

This map shows the median income level across Buffalo city. This project
will also create a map to analyze the median income in order to help
understand the income level of people participating in the rain barrel
project. (overlap rain barrel shapefile on top if possible)

## Example 2

<Education Attainment Distribution Map> Link:
<http://www.edgetech-us.com/Map/EduLvls.htm>

\[Example2\]<http://www.edgetech-us.com/Map/EduLvls.htm>

This map explains the percentage of people who have received a certain
education level. This project will also involve a map like this that
shows the percentage of high school graduates to understand the
education level of people who have participated in the rain barrel
project. (overlap rain barrel shapefile on top if possible)

## Example 3

<Pie chart of education level and median income> Link:
<https://www.r-bloggers.com/2010/07/pie-charts-in-ggplot2/>

![Example3](https://www.r-bloggers.com/2010/07/pie-charts-in-ggplot2/)

Instead of the female and male, this project will make a pie chart of
the median income and education level. This pie chart will explain ???what
group with a certain level of median income installed rain barrels most
in their individual households???? and ???What group with certain level of
education installed rain barrels most in their individual households????

# Proposed data sources

1.  Rain Barrel Data : received from Buffalo Sewer Authority, shapefile
    of rain barrel installed in 2015 and 2016
2.  Median Income : Census Bureau Income in the past 12 months
    (2015,2016,block group level)-5 year subject table-Table: S1901
    3.Education level : Census Bureau Educational attainment for the
    population 25 years and over(2015,2016,block group level)-5 year
    estimate detailed table-Table: B15003

# Proposed methods

Packages : choroplethr, ggplot2 1. Join table of income/education with
rain barrel shapefile data: use the get\_acs\_data to receive table data
from us census bureau, how should I join table of income/education with
rain barrels is a problem. 2. Put into a map for each topic: use
tract\_choropleth, but if it is possible to create a map at a smaller
unit such as block group level try that. 3. Make a pie chart using
ggplot2.

# Expected results

The expected result is to produce a choropleth map of each topic and
understand which areas the rain barrels are installed most. This will be
represented into a pie chart for the better visualization. This will be
a useful resource to figure out who to target for the next environmental
planning project.

.
