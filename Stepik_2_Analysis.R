#### Переменные
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

#*******************************************************************************
### Работа с data frame
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


### 1.3.9
mini_mtcars <- mtcars[c(3, 7, 10, 12, nrow(mtcars)),]

#*******************************************************************************
### Элементы синтаксиса
### 1.4.2
a <- 0
if (a > 0) {
  print("positive")
} else {
  print("negativ")
  print(a + 1)
}

if (a > 0) {
  print("positive")
} else print("negativ")

if (a > 0) {
  print("positive")
} else if (a < 0) {
  print("negativ")
} else {
  print("zero")
}

# короткая запись (крайне полезная)
a <- 10
ifelse(a < 0, "negativ", "positive")
a <- c(-1, 1)

### 1.4.3
for (i in 1:10) {
  print(i)
}

for (i in 1:nrow(mydata)) {
  print(mydata$score[i])
}

for (i in 1:nrow(mydata)) {
  if (mydata$gender[i] == "male") {
    print(mydata$score[i])
  }
}

mydata$quality <- rep(NA, nrow(mydata))
for (i in 1:nrow(mydata)) {
  if (mydata$score[i] > 4) {
    mydata$quality[i] <- "good"
  } else mydata$quality[i] <- "bad"
}

mydata$quality2 <- ifelse(mydata$score > 4, "good", "bad")


i <- 1
while (i < 51) {
  print(mydata$score[i])
  i <- i + 1
}

### 1.4.4

str(mtcars)
mtcars$new_var <- ifelse(mtcars$carb >= 4 | mtcars$cyl > 6, 1, 0)

### 1.4.5

if (mean(my_vector) > 20) {
  result <- "My mean is great"
} else {
  result <- "My mean is not so great"
}

### 1.4.6
# слизал с ответов(((
good_months <- AirPassengers[-1][AirPassengers[-1] > AirPassengers[-144]] 
  
### 1.4.7

moving_average <- c()
for (i in 1:135) moving_average[i] <- mean(AirPassengers[i:(i+9)])

#*******************************************************************************
### Описательные статистики
### 1.5.3
?mtcars
df <- mtcars
str(df)
# преобразовываем тип двигателя в фактор
df$vs <- factor(df$vs, labels = c("V", "S"))
df$am <- factor(df$am, labels = c("Auto", "Manual"))

### 1.5.4
median(df$mpg) # медиана
mean(df$disp)  # среднее
sd(df$hp)      # стандартное отклонение
range(df$cyl)  # размах (мин и макс)

mean_disp <- mean(df$disp)
mean_disp

mean(df$mpg[df$cyl == 6])
mean(df$mpg[df$cyl == 6 & df$vs == "V"])

sd(df$hp[df$cyl != 3 & df$am == "Auto"])

### 1.5.5 Задача
any(df$cyl == 3) # нет таких)))
result <- mean(df$qsec[df$cyl != 3 & df$mpg > 20])

### 1.5.6
?aggregate
mean_hp_vs <- aggregate(x = df$hp, by = list(df$vs), FUN = mean)
colnames(mean_hp_vs) <- c("VS", "Mean HP")
# другой способ записи:
aggregate(hp ~ vs, df, mean)

mean_hp_vs_am <- aggregate(hp ~ vs + am, df, mean)
# по классике. Отличия в названиях результирующих столбцов
mean_hp_vs <- aggregate(x = df$hp, by = list(df$vs, df$am), FUN = mean)

aggregate(x = df[, -c(8, 9)], by = list(df$am), FUN = median)

aggregate(df[, c(1, 3)], by = list(df$am, df$vs), FUN = sd)
aggregate(cbind(mpg, disp) ~ am + vs, df, sd)

### 1.5.7 Задача

descriptions_stat <- aggregate(cbind(hp, disp) ~ am, mtcars, sd)

### 1.5.8

install.packages("psych")
library(psych)
library(ggplot2)
ls(pos = "package:psych")

?describe
describe(x = df)
descr <- describe(x = df[, -c(8, 9)])

### 1.5.9
# прокачанный aggregate (применение статистик для всего дата-сета)
descr2 <- describeBy(x = df[, -c(8, 9)], group = df$vs) # как лист
descr2$V
descr2$S

descr2 <- describeBy(x = df[, -c(8, 9)], 
                     group = df$vs, 
                     mat = T, # как матрица (дф)
                     digits = 3) # так красивше

descr3 <- describeBy(x = df[, -c(8, 9)], 
                     group = df$vs, 
                     mat = T, # как матрица (дф)
                     fast = T, # короткая выводная запись
                     digits = 3) # так красивше
describeBy(df$qsec, 
           group = list(df$vs, df$am), 
           mat = T, 
           digits = 1,
           fast = T)

### 1.5.10
# Пропущенные значения

sum(is.na(df)) # выдаст нуль

df$mpg[1:10] <- NA # усложним себе жизнь

mean(df$mpg) # выдаст NA
mean(df$mpg, na.rm = T)

aggregate(mpg ~ am, df, sd) # по умолчанию игнорируе NA В ТАКОМ НАПИСАНИИ!!!
aggregate(df$mpg, by = list(df$am), FUN = sd, na.rm = T)

describe() # по умолчанию пропускает NA; na.rm = T - удаляет строки с NA

### 1.5.11
airquality
a <- subset(airquality, Month %in% c(7, 8, 9))
(result <- aggregate(Ozone ~ Month, a, length))

### 1.5.12
describeBy(airquality, 
           group = list(airquality$Month), 
           #mat = T, 
           digits = 2)

### 1.5.13
iris
str(iris)
describe(iris[,-ncol(iris)], fast = T)

### 1.5.14
a <- describeBy(iris[,-ncol(iris)], 
           group = list(iris$Species), 
           #mat = T, 
           fast = T,
           digits = 2)$virginica
a[,order(a$mean, decreasing = T)]

b <- aggregate(iris[, -ncol(iris)], by = list(iris$Species), mean)[3,]
b[order(b, decreasing = T)]

### 1.5.15
# подготовка
my_vector <- rnorm(30)
my_vector[sample(1:30, 10)] <- NA

# мое решение 1
fixed_vector <- my_vector
fixed_vector[is.na(my_vector)] <- mean(my_vector, na.rm = T)

# мое решение 2 с подсказой зала
ifelse(is.na(my_vector), 
       mean(my_vector, na.rm = T),
       my_vector)

# решение из зала
fixed_vecto2 <- replace(my_vector, is.na(my_vector), mean(my_vector, na.rm = T))

#*******************************************************************************
### Описательные статистики. ГРАФИКИ
### 1.6.3
df <- mtcars
df$vs <- factor(df$vs, labels = c("V", "S")) 
df$am <- factor(df$am, labels = c("Auto", "Manual")) 

hist(df$mpg, breaks = 20, xlab = "MPG", main ="Histogram of MPG", 
     col = "green", cex.lab = 1.3, cex.axis = 1.3)

boxplot(mpg ~ am, df, ylab = "MPG")

boxplot(df$mpg[df$am == "Auto"], 
        df$mpg[df$am == "Manual"], 
        ylab = "MPG", 
        main ="MPG and AM", 
        col = "green", 
        cex.lab = 1.3, 
        cex.axis = 1.3)

plot(df$mpg, df$hp, pch = 22)

### 1.6.4

library(ggplot2)

ggplot(df, aes(x = mpg))+
  geom_histogram(fill = "white", col = "black", binwidth = 2)

ggplot(df, aes(x = mpg))+
  geom_dotplot(aes(fill = ..x..))+
  scale_fill_gradient(low = "red", high = "yellow")

ggplot(df, aes(x = hp, fill = am))+
  geom_dotplot()

ggplot(df, aes(x = mpg))+
  geom_density(fill = "red") # функция плотности

ggplot(df, aes(x = mpg, fill = am))+
  geom_density(alpha = 0.5) # alpha - прозрачность

### 1.6.4
ggplot(df, aes(x = am, y = hp, col = vs))+
  geom_boxplot()+
  ggtitle("Gross horsepower and engine type")


