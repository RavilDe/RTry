?dput
devtools::session_info(c("tidyverse"))
install.packages(c("nycflights13", "gapminder", "Lahman"))

### Chapter 1
### Data visualisation with ggplot2

# A Layered Grammar of Graphics
# http://vita.had.co.nz/papers/layered-grammar.pdf

library(tidyverse)

## The mpg dataframe
ggplot2::mpg

# this plot shows negative relationship between engine size (displ) and
# fuel efficiency (hwy)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))

##***********************
## exercises
# 1
ggplot(mpg) # empty plot
# 2
str(mtcars) # 32 x 11
# 3
?"mpg"
# drv: f = front-wheel drive, r = rear wheel drive, 4 = 4wd
# 4
ggplot(data = mpg) +
  geom_point(mapping = aes(x = class, y = hwy))
##**********************

# addin third variable to 2-dimention plot
# color, colour, col - all the same
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, colour = class))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = class))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, col = class))

# alpha
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))

# shape
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))

# manual color outside aes
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")


##***********************
## exercises
# 1 manual color inside aes
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = "red"))
# 2
str(mpg)
# 3
# continuouse vs categorical: legend and fill
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = cty))
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = fl))
# 4
?geom_point
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, stroke = cty))
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, shape = fl))
# 5
# stroke - for categorical  
# shape - for continuouse  
# 6 
# condition insude aesthetics!!!!!!!
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = displ < 5))
##**********************

## Facets
# this way is useful for categorical variables - split them to facets
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~ class, nrow = 2)
# grid; formula must contain 2 variables
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ cyl)
# grid without grid
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)


### Geometric Objects
# smooth
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))
# add linetype
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))

# buckle up (:
ggplot(mpg, aes(displ, hwy, color = drv)) +
  geom_point() + 
  geom_smooth(aes(linetype = drv))

# base, group, group by color
ggplot(mpg) +
  geom_smooth(aes(displ, hwy))

ggplot(mpg) +
  geom_smooth(aes(displ, hwy, group = drv))

ggplot(mpg) +
  geom_smooth(aes(displ, hwy, color = drv),
              show.legend = F)

# to display multiply geoms in the same plot, add multiply geom to ggplot() 
ggplot(mpg) +
  geom_point(aes(displ, hwy)) +
  geom_smooth(aes(displ, hwy))

# globalising mapping by putting them into ggplot
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  geom_smooth()

# add some coloring
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth()

# add filter
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(data = filter(mpg, class == "subcompact"), se = F)

## exercises Page 20
# 1
geom_line # line chart
geom_boxplot # boxplot
geom_histogram # histogram
geom_area # area chart
# 2
ggplot(mpg, aes(displ, hwy, color = drv)) +
  geom_point() +
  geom_smooth(se = F)
# 3
 # show.legend = T/F - on / off legeng
# 4
 # se - confidense interval in smooth
# 5 - they are same
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  geom_smooth()

ggplot() +
  geom_point(data = mpg, mapping = aes(displ, hwy)) +
  geom_smooth(data = mpg, mapping = aes(displ, hwy))
# 6
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  geom_smooth(se = F)

ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  geom_smooth(aes(group = drv), se = F)

ggplot(mpg, aes(displ, hwy, col = drv)) +
  geom_point() +
  geom_smooth(se = F)

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(col = drv)) +
  geom_smooth(se = F)

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(col = drv)) +
  geom_smooth(aes(linetype = drv), se = F)

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(col = drv))

### Statictical Tranformation
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut))

?geom_bar # stat; computed variables

# same plot, but with stat_count
ggplot(diamonds, aes(cut)) +
  stat_count()

## Using stat explicitly: three ways
# we want to ovveride the default stat









