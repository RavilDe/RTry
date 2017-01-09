#### 1.2.2
#### 1.2.3
my_var1 <- 42
my_var2 <- 35.25

my_var1 + my_var2 - 12
my_var3 <- my_var1 ^ 2 + my_var2 ^ 2

#### 1.2.4

my_var3 > 200

ls(options()) # список опций

my_var3 > 3009
my_var1 == my_var2
my_var1 != my_var2

my_new_var <- my_var1 == my_var2

#### 1.2.5
my_number <- 42
my_logical_var <- TRUE

#### 1.2.6
var_2 <- var_1 * 10

#### 1.2.7
result <- ((number_1 + number_2) > number_3)

#### 1.2.8

my_vector1 <- 1:67
my_vector2 <- c(-2, 13, 56, 67.6)

#### 1.2.9

my_vector1[1]
my_vector1[3]

my_vector2[3]
my_vector2[1, 2, 3]
my_vector2[c(1, 2, 3)]
my_vector2[1:3]
my_vector2[c(1, 3, 5, 10)]

#### 1.2.10
the_best_vector <- c(1:5000, 7000:10000)

#### 1.2.11
my_numbers_2 <- my_numbers[c(2, 5, 7, 9, 12, 16, 20)]

#### 1.2.12
my_vector1 + 10
my_vector2 + 56

my_vector2 == 0
my_vector1 > 30

x <- 23
my_vector1 < x

#### 1.2.13
my_vector2[my_vector2 > 0]
my_vector2[my_vector2 < 0]
my_vector2[my_vector2 == 0]

my_numbers <- my_vector1[my_vector1 > 20 & my_vector1 < 30]

v1 <- c(165, 178, 180, 181, 167, 178, 187, 167, 187)

mean_v1 <- mean(v1)
v1[v1 > mean_v1]
greater_then_mean <- v1[v1 > mean(v1)]

#### 1.2.14
my_sum <- sum(my_vector[my_vector > 10])

#### 1.2.15
age <- c(16, 18, 22, 27)
is_married <- c(F, F, T, T)
name <- c("Olga", "Maria", "Sveta", "Irina")

data <- list(age, is_married, name)
data

data[[1]]
data[[2]]

data[[1]][2]

df <- data.frame(Name = name, Age = age, Status = is_married)
typeof(df)
class(df)

#### 1.2.15
# решение в лоб
my_vector_2 <- my_vector[(my_vector > mean(my_vector) - sd(my_vector)) & 
                           (my_vector < mean(my_vector) + sd(my_vector))]

# корректное решение
my_vector_2 <- my_vector[abs(my_vector - mean(my_vector)) < sd(my_vector)]

### 1.3.3

?read.table # основной инструмент
?read.csv   # read.table с определенными умолчаниями

mydata <- read.csv("evals.csv")

head(mydata)    # 6 верхних строчек
head(mydata, 3) # 3 верхних строчек
tail(mydata)    # 6 нижних строк дф
tail(mydata, 4) # 4 нижних строки дф

View(mydata) #команда rStudio - открывает дф в виде таблицы (до 1000 строк)

str(mydata)
summary(mydata)

a <- names(mydata)

### 1.3.4
# обращаемся к переменным

b <- mydata$score
mean(mydata$score)
summary(mydata$score)

mydata$score * 2
mydata$ten_point_scale <- mydata$score * 2
summary(mydata$ten_point_scale)

mydata$new_variable <- 0
summary(mydata$new_variable)

mydata$number <- 1:nrow(mydata)
summary(mydata$number) 

nrow(mydata)
ncol(mydata)

# Subsetting

mydata$score[1:10]
mydata[1, 1]
mydata[c(2, 193, 225), 1]
mydata[101:200, 1]

mydata[5, ]
mydata[, 1] == mydata$score

mydata[, 2:5]
head(mydata[, 2:5])

### 1.3.5
# Subsetting with conditions
mydata$gender
mydata$gender == "female"
mydata[mydata$gender == "female",1] # только реподавательт женщины
head(mydata[mydata$gender == "female",1:3])

head(subset(mydata, gender == "female"))
head(subset(mydata, score > 3.5), 10)

# rbind, cbind

mydata2 <- subset(mydata, gender == "female")
mydata3 <- subset(mydata, gender == "male")
mydata4 <- rbind(mydata2, mydata3) # складываем строки

mydata5 <- mydata[, 1:10]
mydata6 <- mydata[, 11:24]
mydata7 <- cbind(mydata5, mydata6)

### 1.3.6
sessionInfo()
library(help = "datasets")
ls(pos = "package:datasets")
data(mtcars) # добавит датасет в рабочую среду
help(mtcars) # выведет информацию о датасете
my_data <- mtcars # запишет датасет в новую переменную

### 1.3.7
data(mtcars); mtcars # возврат
mtcars$gear %% 2 == 1 
mtcars$even_gear <- abs(mtcars$gear %% 2 - 1); mtcars

# чужие решения
mtcars$even_gear <- 1 - mtcars$gear %% 2 # самое изящное
mtcars$even_gear <- as.numeric(mtcars$gear %% 2 == 0)

### 1.3.8
mpg_4 <- subset(mtcars, cyl == 4, mpg)[[1]]

# чужие решения
mpg_4 <- mtcars$mpg[mtcars$cyl == 4]
mpg_4 <- mtcars[mtcars$cyl == 4, "mpg"]


mini_mtcars <- mtcars[c(3, 7, 10, 12, nrow(mtcars)),]
