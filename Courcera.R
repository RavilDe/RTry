# Команды с курсов Coursera

getwd() # рабочая директория
dir() # показывает содержимое директории

my_function <- function(x) {
  y <- rnorm(100)
  mean(y)
}

### Week 1

## Getting Help

library(datasets)
data("airquality")
cor(airquality)

ls(pos = "package:datasets") # что в пакете с данными


## R Console Input and Evaluation
x <- 1
print(x)

x <- 5   # nothing printed (ничего не печатается)
x        # auto-printed occurs (авто-печать)
print(x) # explicit printing (явная печать)

x <- 1:20
x

## Data Types - R Objects and Attributes

1/0 # inf
0/0 # NaN

# attributes:

# names, dimnames
# dimentions
# class
# length
# other user-defined attributes/metadata
attributes()

## Data Types - Vectors and Lists
x <- c(0.5, 0.6); x          # numeric
x <- c(TRUE, FALSE); x       # logical
x <- c(T, F); x              # logical
x <- c("a", "b", "c"); x     # character
x <- 9:29; x                 # integer
x <- c(1+0i, 2+4i); x        # integer

y <- c(1.7, "a"); y # character
y <- c(TRUE, 2); y  # numeric
y <- c(TRUE, "a"); y  # character

x <- 0:6
class(x)
as.numeric(x)
as.logical(x)
as.character(x)

x <- c("a", "b", "c")
as.numeric(x)
as.logical(x)
as.complex(x) # на рабочем комп выдает ошибку!!!!!


## Data Types - Matrices
m <- matrix(nrow = 2, ncol = 3)
dim(m)
attributes(m)

m <- matrix(1:6, 2, 3)

m <- 1:10
dim(m) <- c(2,5)
m
