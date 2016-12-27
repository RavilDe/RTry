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


