?dput
devtools::session_info(c("tidyverse"))
install.packages(c("nycflights13", "gapminder", "Lahman"))

#### Chapter 1
#### Data visualisation with ggplot2

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
# 1 - we want to ovveride the default stat

# make lttle df
demo <- tribble(~a,      ~b,
                "bar_1", 20,
                "bar_2", 30,
                "bar_3", 40
                )
ggplot(data = demo) +
  geom_bar(mapping = aes(x = a, y = b),
           stat = "identity"
           )
# 2 we want to override the default mapping from transformed 
# variables to aesthetics
ggplot(data = diamonds) +
  geom_bar(
    mapping = aes(x = cut, y = ..prop.., group = 1)
  )
# To find variables computed by the stat, look for the help section
# titled "Computed variables"

# 3 we want to draw greater attention to the statistical transformation in code
# stat_summary - summarize the y values for each unique x value
ggplot(diamonds) +
  stat_summary(
    aes(cut, depth),
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median
  )

# ggplot provides over 20 stats:
?stat_bin # for example

## Exe page 26
# 1
?geom_errorbar
# 2
?geom_col
# To show (e.g.) means, you need geom_col()
# 3
# http://stackoverflow.com/questions/38775661/what-is-the-difference-between-geoms-and-stats-in-ggplot2
# http://docs.ggplot2.org/current/
# http://sape.inf.usi.ch/quick-reference/ggplot2/geom
geom.stat <- tribble(~g, ~s,
                     "geom_bar", "stat_count",
                     "geom_bin2d", "stat_bin_2d",
                     "geom_boxplot", "stat_boxplot",
                     "geom_contour", "stat_contour",
                     "geom_count", "stat_sum",
                     "geom_density", "stat_density",
                     "geom_density_2d", "stat_density2d",
                     "geom_freqpoly", "stat_binhex",
                     "geom_quantile", "stat_quantile",
                     "geom_smooth", "stat_smooth",
                     "geom_violin", "stat_ydensity"
                     )
# 4
?stat_smooth
# y, ymin, ymax, se
# 5
ggplot(diamonds) +
  geom_bar(aes(x = cut, y = ..prop.., group = 1))

ggplot(diamonds) +
  geom_bar(aes(x = cut, fill = color))

### Position Adjustment
# fill and color
ggplot(diamonds) +
  geom_bar(aes(x = cut, color = cut))
ggplot(diamonds) +
  geom_bar(aes(x = cut, fill = cut))

# change fill variable
ggplot(diamonds) +
  geom_bar(aes(x = cut, fill = clarity))

# The stacking in performed by automatically by the Position Adjustment
# specified by Position argument:
# Fill / Dodge / Identity

# Identity
ggplot(diamonds,
       aes(x = cut, fill = clarity)) +
  geom_bar(alpha = 1/5, position = "identity")

ggplot(diamonds,
       aes(x = cut, color = clarity)) +
  geom_bar(fill = NA, position = "identity")

# Fill. Easy to compare proportions across groups:
ggplot(diamonds) +
  geom_bar(aes(x = cut, fill = clarity),
           position = "fill")

# Dodge
ggplot(diamonds) +
  geom_bar(aes(x = cut, fill = clarity),
           position = "dodge")

## Overplotting and jitter

ggplot(mpg, aes(displ, hwy)) +
  geom_point()

ggplot(mpg, aes(displ, hwy)) +
  geom_point(position = "jitter",
             alpha = 0.5)
# Jitter adds a small amount of random noise to eac point
?geom_jitter

ggplot(mpg, aes(displ, hwy, col = drv)) +
  geom_point() +
  geom_jitter(alpha = 0.3)

# lookup
?position_dodge
?position_fill
?position_identity
?position_jitter
?position_stack

## exe page 31
# 1
ggplot(mpg, aes(cty, hwy)) +
  geom_point() +
  geom_jitter(alpha = .5)
# 2
?geom_jitter # width 
# 3
ggplot(mpg, aes(displ, hwy, col = drv)) +
  geom_point() +
  # geom_jitter(alpha = 0.3) +
  geom_count()
# 4
ggplot(mpg, aes(drv, hwy, grop = displ)) +
  geom_boxplot()
# defaul position adjustment is Dodge

### Coordinate System

# coord_flip - switches x- and y-axes
ggplot(mpg, aes(class, hwy)) +
  geom_boxplot() +
  coord_flip()

# coord_quickmap
nz <- map_data("nz")
ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(col = "black", fill = "white") +
  coord_quickmap()

# coord polar
bar <- ggplot(diamonds) +
  geom_bar(aes(x = cut, fill = cut),
           show.legend = F,
           width = 1) +
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)
bar + coord_flip()
bar + coord_polar()

# Exe page 33
# 1
bar2 <- ggplot(diamonds) +
  geom_bar(aes(x = cut, fill = color)) +
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)
bar2 + coord_polar()
# 2
?labs
# 3
# coord_quickmap faster coord_map
# 4
ggplot(mpg, aes(cty, hwy)) +
  geom_point() +
  geom_abline() +
  coord_fixed(xlim = c(0, 50),
              ylim = c(0, 50))

#### Chapter 2
#### Workflow: Basics
## Coding basics
1 / 200 * 30
(59 + 73 + 2) / 3
sin(pi / 2)

x <- 3 * 4
x

## Calling Functions
seq(1, 10)
x <- "hello world"

y <- seq(1, 10, length.out = 5)
y
(y <- seq(1, 10, length.out = 5)) 

#### Chapter 3
#### Data Transformation with dplyr

library(nycflights13)
library(tidyverse)
library(dplyr)

?flights

# filter
filter(flights, day == 1, month == 1)

# dplyr functions NEVER modify their inputs!!!

jan1 <- filter(flights, day == 1, month == 1)
dec25 <- filter(flights, day == 25, month == 12)

# comparisons
# R provides the standart suit:
# >, >=, <, <=, != (not equal), == (equal)
filter(flights, month = 1) # mistake

# Problems with floating-point numbers
sqrt(2) ^ 2 == 2 # FALSE
all.equal(sqrt(2) ^ 2, 2)  # TRUE (base)
# or
near(sqrt(2) ^ 2, 2) # TRUE (dplyr)

# Logical Operators
# & is "and"
# | is "or"
# ! is "not"

# filter flight in november or december
filter(flights, month == 11 | month == 12)

nov_dec <- filter(flights, month %in% c(11, 12)) 

# De Morgan's LAW
# !(x & y) is the same as  !x | !y
# !(x | y) is the same as  !x & !y

filter(flights, !(arr_delay > 120 | dep_delay > 120))
filter(flights, arr_delay <= 120 & dep_delay <= 120)

# Missing Values
NA > 5    # NA
10 == NA  # NA
NA + 10   # NA
NA / 2    # NA
NA == NA  # NA

# is.na !!!
x <- NA
is.na(x)  # T

# exe page 49
# 1
filter(flights, arr_delay > 120)
flights %>% 
  filter(dest == "IAH" | dest == "HOU") %>% 
  select(dest) %>% 
  group_by(dest) %>% # эти две команды выполняют унификацию вектора
  summarise()

