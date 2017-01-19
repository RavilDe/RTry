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

sapply(my_list, mean, na.rm = T) # ветор
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

sapply(cars, function(x) grepl(x, car))
attributes(cars)
