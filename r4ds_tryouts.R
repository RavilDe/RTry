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
# wrap 











