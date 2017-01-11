# https://www.r-bloggers.com/the-best-r-package-for-learning-to-think-about-visualization/

install.packages("tidyverse")
library(tidyverse)

install.packages("dplyr")
library(dplyr)

install.packages("ggplot2")
library(ggplot2)

# RStudio качает 0.6.0 а нужно 0.6.1
packageurl <- "https://cran.rstudio.com/bin/macosx/mavericks/contrib/3.3/tidyr_0.6.1.tgz"
install.packages(packageurl, repos = NULL)
library(tidyr)

# This is the data we're going to plot ...
foo <- c(-122.419416,-121.886329,-71.05888,-74.005941,-118.243685,
         -117.161084,-0.127758,-77.036871,116.407395,-122.332071,
         -87.629798,-79.383184,-97.743061,121.473701,72.877656,
         2.352222,77.594563,-75.165222,-112.074037,37.6173)
bar <- c(37.77493,37.338208,42.360083,40.712784,34.052234,
         32.715738,51.507351,38.907192,39.904211,47.60621,
         41.878114,43.653226,30.267153,31.230416,19.075984,
         48.856614,12.971599,39.952584,33.448377,55.755826)
zaz <- c(6471,4175,3144,2106,1450,
         1410,842,835,758,727,
         688,628,626,510,497,
         449,419,413,325,318)
# CREATE DATA FRAME
df.dummy <- data_frame(foo,bar)

# INSPECT
glimpse(df.dummy)
head(df.dummy)


#----------
# PLOT DATA
#----------

ggplot(data = df.dummy, aes(x = foo, y = bar)) +
  geom_point()

#------------------------------------
# NEW PLOT
# - map a variable to size and replot
#------------------------------------

ggplot(data = df.dummy, aes(x = foo, y = bar)) +
  geom_point(aes(size = zaz))
#--------------------------
# GET ANOTHER LAYER OF DATA
#--------------------------
install.packages("maps")
library(maps)
df.more_data <- map_data("world")

# PLOT
ggplot(data = df.dummy, aes(x = foo, y = bar)) +
  geom_polygon(data = df.more_data, aes(x = long, y = lat, group = group)) +
  geom_point(aes(size = zaz), color = "red") 
