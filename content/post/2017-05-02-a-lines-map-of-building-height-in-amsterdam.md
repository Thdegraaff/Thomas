---
title: A lines map of building height in Amsterdam
author: Thomas de Graaf
date: '2017-05-02'
slug: a-lines-map-of-building-height-in-amsterdam
categories:
- R
- Reproducability
---

## Introduction

I just came across this wonderfull post on https://www.r-bloggers.com http://spatial.ly/2017/04/population-lines-how-and-why-i-created-it/ called Population Lines: How and Why I Created it) by James Cheshire. It allows for wonderfull (and artistic) maps constructed by only varations in height of horizontal lines. One might wonder how useful they are, but they sure are beautiful as one can see below in the population lines map of Europe.

{{< figure src="/img/europe.png" title="Population lines map of Europe (source http://blog.revolutionanalytics.com/2017/04/where-europe-lives.html).">}}

I decided to redo this but then for Amsterdam and then not using population data but instead data for the height of the buildings (the data is used by Maria Teresa Borzacchiello, Peter Nijkamp and Eric Koomen in an article in Environment & Planning B called Accessibility and urban development: a grid-based comparative statistical analysis of Dutch cities in 2010). The link to the data can be found in this article. The code for the large map in the header of this post is surprisingly simple and concise and explained below.

The code
First, I read in the csv dataset and rename the grid numbers as articifial latitute and longitute coordinates.

```r
height <- read.csv('./buildingheight/amsterdam.csv', header = FALSE)
colnames(height) <- seq(1, ncol(height))
height$lat <- seq(nrow(height),1)
height <- gather(height, lat, value)
height$lon <- as.numeric(height[,2])
height <- subset(height, select = -2 )
height <- filter(height, value > 0) 
```
    
Then it is simply a matter of invoking the ggplot package where we group observations by each latitude and apply a line aesthetic.

```r
library(ggplot2)
height %>% 
    mutate(lat = lat/100,
    lon = lon/100) %>%
    group_by(lat=round(lat, 1), lon=round(lon, 1)) %>%
    summarize(value = sum(value, na.rm=TRUE))  %>%
    ungroup() %>%
    complete(lat, lon) %>%
    ggplot(aes(lon, lat + 5*(value/max(value, na.rm=TRUE)))) +
    geom_line(size=0.4, alpha=0.8, color='#5A3E37', aes(group=lat), na.rm=TRUE) +
    ggthemes::theme_map() +
    coord_equal(0.9)

ggsave('Amsterdam.png', width=10, height=10)
```
Which has the following wonderful result:

{{< figure src="/img/Amsterdam.png" title="Height of buildings in Amsterdam">}}
