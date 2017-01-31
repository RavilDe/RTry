#### Анализ данных в R. Часть 2
#### https://stepik.org/724 

#*******************************************************************************
### 1.2 Функции семейства apply. Часть 1
### 1.2.2 - 1.2.3

library(ggplot2)
data(diamonds) # загрузка (показ) данных в окружение в виде обещания
str(diamonds)  # обещание выполнено :)

# немного тренировки и проверки
i <- 1
diamonds[i, 8:10]
min(diamonds[i, 8:10])

# неправильный код ))
min_size <- c()
system.time({ for (i in 1:nrow(diamonds)) {
  min_size <- c(min_size, min(diamonds[i, 8:10]))
}
}) # почти 50 секунд на маке (при работающем FAH :)

head(min_size)

# вторая попытка
min_size <- numeric(nrow(diamonds))
system.time({ for (i in 1:nrow(diamonds)) {
  min_size[i] <- min(diamonds[i, 8:10])
}
}) # 21 секунда на маке (при работающем FAH :)

# а теперь быстрый вариант
system.time(min_size2 <- apply(diamonds[, 8:10], 1, min))
  # работаем только с 8-10 столбцами датафрейма
  # 1 - применяем функцию к строкам (2 - к столбцам)
  # min - применяемая функция
  ### расчет занял 0,414 секунды на маке и 0,39 на рабочем о_0

### 1.2.4
?apply()

d <- matrix(rnorm(30), 5)

apply(d, MARGIN = 1, FUN = sd) # по строке
apply(d, MARGIN = 2, FUN = sd) # по столбцу
apply(mtcars, 2, sd)

### 1.2.7
is.vector(apply(d, MARGIN = 2, FUN = sd)) # это вектор

# а когда apply выводит матрицу?
range(1:10) # мин и макс вектоора
my_range <- apply(d, 2, range)

### 1.2.8

# как много наблюдений отклонилось от среднего по вектору больше чем на 2 sd
x <- rnorm(10)
outliers_count <- function(x) {
  outliers <- x[abs(x - mean(x)) > 2 * sd(x)]
  if (length(outliers) > 0) {
    return(outliers)
  } else {
    return("There are no outliers")
  }
}
str(iris)
iris_num <- iris[ , 1:4]
iris_outliers <- apply(iris_num, 2, outliers_count)
str(iris_outliers)

#*******************************************************************************
### 1.3 Функции семейства apply. Часть 2
### 1.3.2

str(airquality)
head(airquality) # есть пропуски (NA)

apply(airquality, 2, mean) # по первым двум переменным нет среднего

# у mean есь аргумент na.rm
?mean
# как сказать ф-ии apply об удалении NA
mean(airquality$Ozone, na.rm = T) # выдаст БЕЗ учета NA
# т.к. у ф-ии apply есть ... - то пробрасываем аргумент na.rm в apply
apply(airquality, 2, mean, na.rm = T)

# еще быстрее и проще apply'я
rowMeans() # среднее по строкам
rowSums() # сумма по строкам
colMeans(airquality, na.rm = T) # среднее по столбцам (по переменной)
colSums() # сумма по столбцам (по переменной)

# colMeans в два раза быстрее:
library(microbenchmark)
microbenchmark(apply(airquality, 2, mean, na.rm = T),
               colMeans(airquality, na.rm = T))

### 1.3.3
# четыре строки
my_fun <- function(x) {
  y <- x * 2
  return(y)
}
# три строки
my_fun <- function(x) {
  x * 2
}
# одна строка
my_fun <- function(x) x * 2

my_fun(1:10)

# Задача: найти в каждом столбце отрицательные элементы
set.seed(42)
d <- as.data.frame(matrix(rnorm(30), nrow = 5))

# по старинке
my_list <- list()
for (i in seq_along(d)) {
  temp_col <- d[, i]
  neg_numbers <- temp_col[temp_col < 0]
  my_list[[i]] <- neg_numbers
}
names(my_list) <- colnames(d)

### 1.3.4
# а теперь по правильному
apply(d, 2, function(x) x[x < 0])

# убираем уязвимость от NA
d[1, 1] <- NA
apply(d, 2, function(x) x[x < 0 & is.na(x) == F])

### 1.3.5
d[4, 1] <- NA

df <- as.data.frame(list(V1 = c(NA, -0.5, -0.7, -8), 
                         V2 = c(-0.3, NA, -2, -1.2), 
                         V3 = c(1, 2, 3, NA)))
# свое с подсказками
df1 <- apply(df, 2, function(x) as.numeric(x[x < 0 & is.na(x) == F]))
df1[sapply(df1, length)>0]

# чужое и получше (без sapply)
get_negative_values <- function(test_data) {
  cols <- apply(test_data, 2 ,function(x) any(x < 0, na.rm = TRUE))
  apply(test_data[cols], 2, function(x) x[!is.na(x) & x < 0])
}

### 1.3.6
head(iris)
str(iris)
aov(Sepal.Length ~ Species, iris) # дисперсионный анализ по первому столбцу

# по всем количественным переменным
aov_result <- apply(iris[, 1:4], 2, function(x) aov(x ~ Species, iris))
norm_test <- apply(iris[, 1:4], 2, function(x) shapiro.test(x))
norm_test_p <- apply(iris[, 1:4], 2, 
                   function(x) shapiro.test(x)$p.value)

str(aov_result)
norm_test$Sepal.Length

### 1.3.8
test_data <- as.data.frame(list(V1 = c(NA, NA, NA, NA, 13, 12, 9, 10, 8, 9, 11, 
                                       11, 10, 12, 9), 
                                V2 = c(NA, 12, 8, NA, 11, 11, 9, 8, 8, 10, 10, 
                                       11, 10, 10, 10), 
                                V3 = c(NA, 5, NA, 13, 12, 11, 11, 14, 8, 12, 8, 
                                       8, 10, 10, 8), 
                                V4 = c(10, 10, 10, 10, 13, 10, 11, 7, 12, 10, 
                                       7, 10, 13, 10, 9)))
# меняем NA на среднее в столбце
na_rm <- function(x) {
  as.data.frame(apply(test_data, 2, 
                      function(x) ifelse(is.na(x), mean(x, na.rm = T), x)))
}

na_rm(test_data)

mean(test_data$V3, na.rm = T)

#*******************************************************************************
### 1.4 Функции семейства apply. Часть 3
### 1.4.2
# про apply:
# - только для data.frame или матрицы
# - НЕЛЬЗЯ применить для вектора или списка

my_list <- list(x = c(rnorm(30), NA), y = rnorm(10))
str(my_list)

lapply(my_list, mean)
lapply(my_list, mean, na.rm = T)
lapply(my_list, function(x) x * 2)

# про lapply
# - на входе и на выходе - список
# - проброс аргументов
# - безымянные функции

sapply(my_list, mean, na.rm = T) # вектор
# отличие sapply от lapply
# s(simpify) выдает вектор или матрицу;
# и только в исключительных случаях выдает список (list)

sapply(my_list, range, na.rm = T) # матрица
sapply(my_list, range, na.rm = T, simplify = F) # превращается в lapply

### 1.4.3
d <- data.frame(X1 = c(-1, -2, 0), X2 = c(10, 4, NA), X3 = c(-4, NA, NA))
positive_sum <- function(a) {
  lapply(a, function(x) sum(x[x>0], na.rm = T))
}

positive_sum(d)

### 1.4.4
cars <- c("Mazda", "Volga", "Mercedes")
car <- "Mazda RX4"

grepl("Mazda", "Mazda RX4") # первый элемент содержится во втором

# через цикл
for (i in cars) {
  print(grepl(i, car))
}

cars[sapply(cars, function(x) grepl(x, car))]

### 1.4.5
# отбираем только численные переменный в дата-фрейме
iris_num <- iris[sapply(iris, is.numeric)]
str(iris_num)

# почти одно и то же:
sapply(iris[1:4], sd)
apply(iris[1:4], 2, sd)

# apply производит все опперации именно над матрицами, 
# поэтому если вы отправите в apply dataframe с разными типами данных, 
# то R сначала приведет все колонки к одному типу, чтобы получилась матрица, 
# т.к. в матрице могут храниться данные только одного типа
sapply(iris, is.numeric) # TRUE TRUE TRUE TRUE FALSE
apply(iris, 2, is.numeric) # FALSE FALSE FALSE FALSE FALSE

### 1.4.6
# tapply - на вход принимает вектор, группирующую переменную и функцию
aggregate(mpg ~ am, mtcars, mean)

tapply(mtcars$mpg, mtcars$am, mean)

# ф-я by как бы разрезает исходный дата-фрейм на несколько в зависимости от
# группирующей переменной и применяет к ним ф-ию
# внутри by только функции для дата-фреймов 
by(iris[1:4], iris$Species, colMeans)

# точка означает "по всем остальным переменным"
aggregate(. ~ Species, iris, function(x) shapiro.test(x)$p.value)

### 1.4.7
?vapply
# аналогичен lapply (sapply); отличие в зарвнее оговоренном типе данных на результате
# причина - vapply работает быстрее
vapply(mtcars, mean, FUN.VALUE = numeric(1))
sapply(mtcars, mean)

# mapply - многомерная версия sapply
mapply(rep, 1:4, 1:4)

x <- c(20, 25, 11)
m <- c(0, 1, 2)
s <- c(3, 5, 6)
mapply(rnorm, x, m, s) # подставляем по очереди элементы векторов в ф-ю rnorm

### 1.4.8
### 1.4.9
m <- matrix(rnorm(100 * 200), nrow = 100)
m_names <- mapply(paste, list("row", "col"), list(1:100, 1:200), sep = "_")
str(m_names)
colnames(m) <-  m_names[[2]]
rownames(m) <- m_names[[1]]
head(m)

### 1.4.10
# расчет стандартного отклонения для численных даных дата-фрейма
get_sd <- function(x){
  num_var <- sapply(x, is.numeric)
  sapply(x[, num_var], sd)
}

get_sd(iris) # работает

df <- data.frame(x = 1:10, y = letters[1:10])
get_sd(df) # НЕ работает
# причина  - столбец превратился в вектор; поэтому надо использовать drop=F

get_sd <- function(x){
  num_var <- sapply(x, is.numeric)
  sapply(x[, num_var, drop = F], sd)
}
get_sd(df) # теперь работает

### 1.4.11
test_data <- as.data.frame(list(
  name = c("p4@HPS1", "p7@HPS2", "p4@HPS3", 
           "p7@HPS4", "p7@HPS5", "p9@HPS6", 
           "p11@HPS7", "p10@HPS8", "p15@HPS9"), 
  expression = c(118.84, 90.04, 106.6, 
                 104.99, 93.2, 66.84, 
                 90.02, 108.03, 111.83)))
name = c("HPS5", "HPS6", "HPS9", "HPS2", "HPS3", "HPS7", "HPS4", "HPS8")
one <- sapply(name, function(x) grepl(x, test_data$name))
two <- as.logical(apply(one, 1, sum)) # лучше через any сделать

test_data[two,]

### 1.4.12
### 1.4.13
### 1.4.14
### 1.4.15

#*******************************************************************************
### 1.5 Работа с данными при помощи dplyr
### 1.5.3
install.packages("dplyr")
library(dplyr)

data_frame() # отличие от базовой в _
# dplyr:
my_data <- data_frame(x = rnorm(10000), 
                      y = rnorm(10000), 
                      f = factor(rep(1:2, 5000)))
# base:
my.data <- data.frame(x = rnorm(10000), 
                      y = rnorm(10000), 
                      f = factor(rep(1:2, 5000)))

# see the difference
my.data # забивается вся консоль
my_data # красота)

library(ggplot2)
str(diamonds)
# перевод из base'ового датафрейма в dplyr'овский
df_di <- as_data_frame(diamonds)
df_di

### 1.5.4
my_data_2 <- data_frame("My var" = rnorm(10))
my_data_2 # пробел в названии переменной есть!
my_data_2$`My var`

my.data.2 <- data.frame("My var" = rnorm(10))
my.data.2 # пробел в названии переменной заменен на точку (

my_df <- data_frame(x = rnorm(10), y = abs(x)) # на лету!!!!!!
my.df <- data.frame(x = rnorm(10), y = abs(x)) # ошибка

### 1.5.5
ls(pos = "package:dplyr")
length(ls(pos = "package:dplyr")) # 245 ф-ий
ls(pos = "package:dplyr", pattern = "join")
ls(pos = "package:dplyr", pattern = "add")
ls(pos = "package:dplyr", pattern = "sql")
ls(pos = "package:dplyr", pattern = "ny")

diamonds <- as_data_frame(diamonds)
# две полезные ф-ии:
# select() - выбор колонок (переменных)
# slice()  - выбор строк (наблюдений)


diamonds[, c("cut", "price")] # запись в базовом R
# выбрать из diamonds переменные cut и price
select(diamonds, cut, price)  # df, а после запятой перечисляем нужные столбцы

diamonds
# выберем переменные от cut до price
diamonds[c("cut", "color", "clarity", "depth", "table", "price")]
# а теперь короче и проще
select(diamonds, cut:price)
# все кроме: 
select(diamonds, -(cut:price))

select(diamonds, 1)
select(diamonds, 1, 2, 3)

# смотрим справку по ф-ии
select(diamonds, starts_with("c"))
select(diamonds, ends_with("t"))


