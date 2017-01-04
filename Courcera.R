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
x <- 0:6
as.complex(x)

x <- list(1, "a", TRUE, 1 + 4i)
x

## Data Types - Matrices
m <- matrix(nrow = 2, ncol = 3)
dim(m)
attributes(m)

m <- matrix(1:6, 2, 3)

m <- 1:10
dim(m) <- c(2,5)
m

## Data Types - Factors
x <- factor(c("yes", "yes", "no", "yes", "no"))
x
table(x)
unclass(x)

x <- factor(c("yes", "yes", "no", "yes", "no"), levels = c("yes", "no"))
x

## Data Types - Missing Values
x <- c(1, 2, NA, 10, 15)
is.na(x)
is.nan(x)
x <- c(1, 2, NA, NaN, 15)
is.na(x)
is.nan(x)

## Data Types - Data Frames
x <- data.frame(foo = 1:4, bar = c(T, T, F, F)); x
nrow(x)
ncol(x)

## Data Types - Names Attribute
x <- 1:3
names(x)
names(x) <- c("foo", "bar", "norf")
x
names(x)

x <- list(a = 1, b = 2, c = 3)
x

x <- matrix(1:4, 2, 2)
dimnames(x) <- list(c("a", "b"), c("c", "d"))
x

## Reading (writing) Tabular Data

# There are a few principal functions reading data into R:
# read.table, read.csv  - for reading tabular data                     (write.table)
# readLines             - for reading lines of a text file             (writeLines)
# source                - for reading in R code files (inverseof dump) (dump)
# dget                  - for reading in R code files (inverseof dput) (dput)
# load                  - for reading in saved workspaces              (save)
# unserialize           - for reading single R objects in binary form  (serialize)

# Calculating Memory Requirements
# I have a data frame with 1,500,000 rows and 120 columns, all of which are numeric data. Roughly,
# how much memory is required to store this data frame?
# 1,500,000 ×120 ×8 bytes/numeric
# = 1440000000 bytes
# = 1440000000 /  bytes/MB
# = 1,373.29 MB
# = 1.34 GB

## Textual Data Formats

x <- "foo"
y <- data.frame(a = 1, b = "a")
dump(c("x", "y"), file = "data.R")
rm(x, y)
source("data.R")

## Connections: Interfaces to the Outside World

# file
# gzfile
# bzfile
# url

str(file)

## Subsetting - Basics
x <- c("a", "b", "c", "c", "d", "a")
x[1]
x[2]
x[1:4]
x[x > "a"]
u <- x > "a"
u
x[u]

## Subsetting - Lists
x <- list(foo = 1:4, bar = 0:6)
x[1]
x[[1]]
x$foo
x[["bar"]]
x["bar"]
x <- list(foo = 1:4, bar = 0.6, baz = "hello")
x
x[c(1,3)]

# The [[ operator can be used with computed indices; $ can only be used with literal names
name <- "foo"
x[[name]] # computed index for "foo"
x$name  # element "name" doesn't exist!!
x$foo  # element "foo" does exist

# The [[ can take an integer sequence
x <- list(a = list(10, 12, 14), b = c(3.14, 2.81))
x[[c(1, 3)]]
x[[1]][[3]]
x[[2]][[1]]

## Subsetting - Matrices
x <- matrix(1:6, 2, 3)
x
x[1, 2]
x[2, 1]
x[1, ]
x[, 3]

# drop 
x[1, 2, drop = FALSE]
x[1, ]
x[1, , drop = FALSE]

## Subsetting - Partial Matching
x <- list(aardvark = 1:5)
x$a
x[["a"]] # null
x[["a", exact = FALSE]]

## Subsetting - Removing Missing Values
x <- c(1, 2, NA, 4, NA, 5)
bad <- is.na(x)
x[!bad]

y <- c("a", "b", NA, "d", NA, "f")
(good <- complete.cases(x, y))
x[good]
y[good]

airquality[1:6,]
good <- complete.cases(airquality)
airquality[good, ][1:6, ]

## Vectorized Operations
x <- 1:4; y <- 6:9
x + y
x > 2
x >= 2
y == 8
y
x / y

x <- matrix(1:4, 2, 2); y <- matrix(rep(10, 4), 2, 2)
x * y # element-wise multiplication
x / y
x %*% y # true matrix multiplication
