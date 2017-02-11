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
library(dplyr)
ToothGrowth$dose <- factor(ToothGrowth$dose)
str(ToothGrowth)

f_var <- names(which(!sapply(ToothGrowth, is.numeric)))
num_var <- names(which(sapply(ToothGrowth, is.numeric)))

tg_gr <- group_by_(ToothGrowth, .dots = num_var)

summarise_(tg_gr, mean(num_var))

summarise(group_by(ToothGrowth, supp, dose), mean_var = mean(len) + 2 * sd(len))

ToothGrowth %>% 
  group_by(supp, dose) %>% 
  summarise(mean_var = mean(len) + 2 * sd(len))
  
  
ifelse(ToothGrowth$len, 1, 0)


### 1.4.13
shapiro.test(swiss$Fertility)$p.value
str(swiss)
myfun <- function(x) res <- shapiro.test(x)$p.value
swiss %>% 
  sapply(myfun)





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

# полезные ф-ии:
# select  - выбор колонок (переменных)
# slice   - выбор строк (наблюдений)
# filter  - фильтрация
# arrange - упорядочивание
# rename  - переименование
# mutate  - создание новых переменных

diamonds <- as_data_frame(diamonds)

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

# смотрим справку по ф-ии select
select(diamonds, starts_with("c"))
select(diamonds, ends_with("t"))

### 1.5.6
# Выбор строк
slice(diamonds, 1)
slice(diamonds, 1:10)
slice(diamonds, c(1, 4, 5))

### 1.5.7
# Фильтрация
filter(diamonds, carat > 0.3, color == "J")
filter(diamonds, carat > 0.3 | color == "J")
# базовые методы фильтрации
diamonds[diamonds$carat > 0.3 & diamonds$color == "J", ]
subset(diamonds, carat > 0.3 & color == "J")

### 1.5.8
# упорядочивание
arrange(diamonds, price) # по возрастанию
arrange(diamonds, -price) # по убыванию
arrange(diamonds, desc(price)) # по убыванию (громоздко)))
arrange(diamonds, cut)
arrange(diamonds, price, x) # по нескольким переменным
# в базовом  R
order(c(1, 0, -1, 4)) # возвращает набор индексов 
diamonds[order(diamonds$price),] # применяем ранее полученный набор индексов
sort(c(1, 0, -1, 4)) # просто сортировка вектора

### 1.5.9
library(dplyr)
# переименование переменной ()
diamonds <- rename(diamonds, new_cut = cut, new_depth = depth)
# базовый R (переименовываем обратно)
names(diamonds)
names(diamonds)[c(2, 5)] <- c("cut", "depth")

# добавляем новые переменные
mutate(diamonds, 
       sqrt_price = sqrt(price),
       log_carat = log(carat))

str(mtcars)
mt <- mutate(mtcars, am = factor(am), vs = factor(vs))
str(mt)

### 1.5.10
slice(diamonds, seq(1, nrow(diamonds), by = 2))

# ответы других
diamonds[c(T,F), ]
filter(diamonds, row_number() %% 2 != 0)

### 1.5.11

#     %>% (Ctrl + Shift + m ; для MacOS Command + Shift + m)

# Оператор %>% в прямом смысле слова перетаскивает то, что написано перед ним 
# в качестве аргумента, в следующую функцию. На первом этапе мы отправляем 
# данные iris в функцию filter, в которой теперь достаточно указать только 
# условие фильтрации. Далее результат фильтрации мы отправляем на сортировку 
# по переменной Sepal.Length. И на последнем этапе уже отфильтрованные и 
# отсортированные данные мы отправляем в функцию select, чтобы отобрать 
# нужные колонки.

iris %>% 
  filter(Petal.Length > 1.7) %>% 
  arrange(Sepal.Length) %>% 
  select(Sepal.Length, Sepal.Width)

### 1.5.12
# Потренируемся использовать изученные функции. Из данных mtcars отберите 
# только четыре переменные: mpg, hp, am, vs. Оставьте только те наблюдения, 
# для которых значения mpg > 14 и hp > 100. Отсортируйте получившиеся данные 
# по убыванию переменной mpg и возьмите только первые 10 строчек. Переменную mpg 
# переименуйте в Miles per gallon, а переменную hp в  Gross horsepower 
# (обратите внимание, dplyr позволит нам создать пременные с пробелами 
# в названии). Получившийся dataframe сохраните в переменную my_df.

library(dplyr)
mydf <- mtcars %>% 
  select(mpg, hp, am, vs) %>% 
  filter(mpg > 14, hp > 100) %>% 
  arrange(-mpg) %>% 
  slice(1:10) %>% 
  rename("Miles per gallon" = mpg, "Gross horsepower" = hp)

#*******************************************************************************
### 1.6 Работа с данными при помощи dplyr. Продолжение
### 1.6.2
d <- as_data_frame(matrix(rnorm(30), 5))
# изменение всех колонок (переменных)
# на входе и на выходе - дата фрейм!!!
mutate_each(d, funs(abs))
mutate_each(d, funs(. * 2)) # точка означает все столбцы (и)


### 1.6.3
all_to_factor <- function(x){
  mutate_each(x, funs(as.factor)) # можно и без точки)
  
}
str(all_to_factor(mtcars))

### 1.6.4
df <- data_frame(V1 = c(1.5, -0.1, 2.5, -0.3, -0.8),
                        V2 = c(-0.9, -0.3, -2.4, 0, 0.4),
                        V3 = c(-2.8, -3.1, -1.8, 2.1, 1.9),
                        V4 = c("A", rep("B", 4)))


num_var <- names(df[sapply(df, is.numeric)])
mutate_each_(df, funs(log((. - min(.))/(max(.)-min(.))+1)), num_var)

# чужие ответы
# эталонный и большой
log_transform_1 <- function(test_data){      
  rescaling <- function(x) log((x - min(x)) / (max(x) - min(x)) + 1)     
  num_var <- sapply(test_data, is.numeric)      
  test_data[num_var] <- mutate_each(test_data[num_var], funs(rescaling))      
  return(test_data)
}

# самы оптимальный
log_transform_2 <- function(td) {
  mutate_if(td, is.numeric, funs(log(((.) - min(.))/(max(.)-min(.)) + 1)))
}
log_transform_2(df)

### 1.6.5
# бла-бла-бла


### 1.6.6
# groupe_by

library(ggplot2)
df <- as_data_frame(diamonds)
str(df)
levels(df$cut) # уровни кач-ва огранки

group_df <- group_by(df, cut)
group_df # вроде ничего не изменилось, но есть приписка Groups: cut [5]

sample_n(df, 2) # выбирает n случайных наблюдений
slice(df, 1) # просто первая строка

# а теперь применим эти ф-ии для сгруппированного массива
sample_n(group_df, 2) #
slice(group_df, 1) # 

### 1.6.7
# summarise - грубо говоря это объединение apply и aggregate

str(mtcars)
summarise(mtcars, mean(disp), sd(disp))
summarise(mtcars, mean_disp = mean(disp), sd_dips = sd(disp))

summarise(group_df, mean_price = mean(price)) # средняя цена по группам
as.data.frame(summarise(group_by(df,clarity), mean_price = mean(price)))

summarise(group_df,
          mean_price = mean(price),
          mean_x = mean(x),
          median_y = median(y),
          min_y = min(y))

### 1.6.8
group_df_2 <- group_by(df, cut, color) # группировка по двум переменным

s <- summarise(group_df_2,
          mean_price = mean(price),
          mean_x = mean(x),
          median_y = median(y),
          min_y = min(y))
View(s)

# n
# can only be used from within summarise, mutate and filter !!!!
summarise(group_df_2,
          observations = n(),       # подсчет наблюдений в текущей группе
          mean_price = mean(price),
          mean_x = mean(x),
          median_y = median(y),
          min_y = min(y))

s <- summarise(group_df_2,
          mean_price = mean(price),
          mean_x = mean(x),
          median_y = median(y),
          min_y = min(y),
          observations = n(),                 
          g_p = sum(price > 5000)) # кол-во брюликов в группе с ценой выше 5000
slice(s, 1) # запоминаем g_p первой строки и проверяем далее:
nrow(filter(df, cut == "Fair", color == "D", price > 5000))
# вариатн от преподавателя:
sum(filter(df, cut == "Fair", color == "D")$price > 5000)

### 1.6.9
# summarise_all

gr_mtcars <- group_by(mtcars, am, vs)
my_means <- summarise_all(gr_mtcars, funs(mean))
my_means <- summarise_all(gr_mtcars, funs(sum(. > 10)))
View(my_means)

### 1.6.10
group_by(iris, Species) %>% 
  summarise_all(funs(mean))

### 1.6.11
# А если мы не знаем имена переменных в данных, но хотим применять dplyr?

# В завершении необходимо разобрать продвинутую, но очень важную тему: 
# использование стандартного вычисления SE (standard evaluation) и 
# нестандартного вычисления NSE (nonstandard evaluation), используемого 
# в функциях пакета dplyr.

# Давайте рассмотрим простой пример применения функции select:
select(mtcars, am, hp)

# Обратите внимание, что все аргументы написаны без кавычек, но R понимает, 
# что первый аргумент mtcars - это имя переменной в рабочем окружении, что 
# не удивительно, если мы просто напишем mtcars в консоль, то выведем уже 
# знакомый нам набор данных. При этом am и hp, написанные без кавычек, 
# не вызывают никаких ошибок. То есть функция select понимает, что первый 
# аргумент - это имя переменной, а последующие аргументы это не переменные 
# в нашем рабочем окружении, а именно имена колонок в данных. Поясню, если мы 
# попытаемся исполнить такой код:
mtcars[, am] 

# то получим ошибку Error in `[.data.frame`(mtcars, , am) : object 'am' not 
# found. Т.к. R не поймет, что am - это имя колонки в данных, и попытается 
# найти переменную с именем am.  Для корректной работы нам было бы необходимо 
# поместить имя столбика в кавычки:
mtcars[, "am"]

# Однако, в контексте функции select и других изученных функций из пакета dplyr 
# такой ошибки не произойдет. Возможность использовать имена колонок в данных 
# без кавычек обуславливается нестандартным вычислением (NSE) подробнее смотри 
# http://adv-r.had.co.nz/Computing-on-the-language.html

# Эта особенность позволяет писать быстрый и удобный код, однако имеет серьезный 
# недостаток. Все разобранные функции мы можем применять к данным только в том 
# случае, если знаем название колонок в данных. Но что делать, если нам 
# необходимо написать собственную функцию для работы с данными, в которых мы 
# заранее не знаем имена колонок?

# На этот случай, в dplyr существуют братья близнецы изученных функций, которые 
# имеют такие же названия только с нижним подчеркиванием в конце:
slice_()
filter_()
group_by_()
mutate_()

# Все эти функции выполняют те же самые операции, однако, используют стандартное 
# вычисление (standard evaluation), позволяющее записывать имена колонок данных в 
# кавычках, и как результат -  динамически вычислять имена тех колонок, которые 
# мы хотим использовать в качестве аргументов функций dplyr. Однако, умелое 
# использование этих функций (со стандартным вычислением) требует знания 
# продвинутых приемов программирования в R. Давайте разберемся в этой теме 
# подробнее.
var_to_select <- "hp"
select_(mtcars, var_to_select)

# Таким образом, мы в процессе работы с данными можем определить, какую именно 
# переменную мы хотим отобрать при помощи функции select_, сохранить имя этой 
# переменой в var_to_select, а затем уже использовать var_to_select в качестве 
# аргумента функции select_().

# Еще один пример: часто возникает необходимость сгруппировать набор данных 
# по нескольким факторным переменным, названия которых мы не знаем заранее, 
# или таких переменных довольно много и писать их вручную не самый удобный 
# вариант. 
mtcars$am <-factor(mtcars$am)
mtcars$vs <-factor(mtcars$vs)

# сохраним имена факторов в вектор
factor_vars <- names(which(sapply(mtcars, is.factor))) 
mtcars %>% 
  group_by_(.dots = factor_vars) %>% 
  summarise(n = n())

# Функция group_by_, поддерживает передачу вектора с именами для группировки. 
# Синтаксис очень простой, внутри функции group_by_ мы должны явно сказать, 
# что будем использовать вектор с именами, используя аргумент .dots. 
# Таким образом, мы сначала сохранили в переменную имена факторных переменных и 
# использовали их для группировки исходных данных.

# Однако сложности могут начаться далее. Мы знаем, такие функции как filter и 
# mutate позволяют писать сложные выражения для преобразования данных, например:
mutate(mtcars, new_var = (hp - mean(hp)) / sd(hp))

# Таким образом мы создадим новую переменную в данных, а именно, 
# стандартизированную переменную hp. Но что делать, если мы заранее не знаем, 
# как называется переменная, которую мы хотим стандартизировать? 
# Рассмотрим такой пример:
mini_mtcars <- select(mtcars, hp, am, vs)
mini_mtcars <- mini_mtcars %>% mutate(am = factor(am), 
                                      vs = factor(vs))

# Теперь в данных mini_mtcars одна количественная переменная и две факторные, 
# предположим, мы хотим написать код, который стандартизирует количественную 
# переменную в данных, однако не обращается к ней по имени на прямую, 
# а вычисляет ее динамически, то есть если бы мы взяли другой набор данных, 
# с другими названиями переменных, все также сработало. Обратите внимание, 
# нам теперь необходимо написать целое выражение с неизвестной заранее 
# переменной.

# Очевидно нам понадобится функция mutate_. Существует несколько способов 
# написать выражение, которое будет выполнено функцией mutate_:

# 1. Поместить выражение в строку:
mutate_(mini_mtcars, new_var = "(hp - mean(hp)) / sd(hp)")

# 2. Использовать запись через формулу:
mutate_(mini_mtcars, new_var = ~ (hp - mean(hp)) / sd(hp))

# 3. Использовать функцию quote()
mutate_(mini_mtcars, new_var =  quote((hp - mean(hp)) / sd(hp)))

# У вас может возникнуть законный вопрос, чем же это нам поможет? Ведь мы все 
# еще используем имя переменной hp. Однако все эти три варианта позволяют нам 
# без труда, заменить hp на любое другое имя переменной, которое мы могли 
# вычислить заранее. И в этом нам поможет функция interp из пакета lazyeval. 
# Ох, как же все непросто!) И так давайте уже напишем финальный код:
install.packages("lazyeval")
library(lazyeval)
library(dplyr)
num_var <- names(which(sapply(mini_mtcars, is.numeric)))
mutate_(mini_mtcars, 
        new_var = interp(~(var - mean(var)) / sd(var), var = as.name(num_var)))

# Функция interp позволяет подставить на место желаемой переменной строку с 
# нужным нам названием колонки в данных. Единственный нюанс, если имя желаемой 
# переменной - это строка, ее нужно обернуть функцией as.name(). Мы также могли 
# использовать любой из двух оставшихся методов передачи нашей переменной 
# в вычисляемое выражение:
interp("(var - mean(var)) / sd(var)", var = as.name(num_var))
interp(quote((var - mean(var)) / sd(var)), var = as.name(num_var))

# Ну вот и все, таким образом, мы поместили в вычисляемое выражение имя 
# переменной, которое мы определили ранее, и в данных с другими именами 
# колонок наш код тоже будет работать.

# Этот подход мы можем использовать и при работе с другими функциями dplyr:
library(lazyeval)
var_for_group <- c("am", "vs")
var_for_filter <- "hp"
var_for_arrange <- "mpg"
var_for_mutate <- "qsec"
var_for_summirise <- "cyl"
group_by_(mtcars, .dots = var_for_group) %>% 
  filter_(interp(~var > 100, var = as.name(var_for_filter))) %>% 
  arrange_(var_for_arrange) %>% 
  mutate_(new_var = interp(~ifelse(var > mean(var), 1, 0), 
                           var = as.name(var_for_mutate))) %>% 
  summarise_(max = interp(~max(var), var = as.name(var_for_summirise)))

# P.S. из трех предложенных способов записи: в кавычках, через формулу и при 
# помощи функции quote, лучше  всегда использовать запись через тильду, т.к. 
# оставшиеся два варианта могут привести к ошибке (смотри обсуждение этой 
# особенности с автором пакета dplyr 
# https://github.com/hadley/dplyr/issues/1323 ):

summarise_(mtcars, ~shapiro.test(mpg)$p.value)
# shapiro.test(mpg)$p.value
# 1                 0.1228814

summarise_(mtcars, "shapiro.test(mpg)$p.value")
# Error: could not find function "shapiro.test"

summarise_(mtcars, quote(shapiro.test(mpg)$p.value))
# Error: could not find function "shapiro.test"

### 1.6.12
sal <- read.csv("salary.csv", na.strings = "NA")
head(sal)
str(sal)

descriptive_stats <- function (dataset){
dataset %>% 
  group_by(gender, country) %>% 
  summarise(n = n(),
            mean = mean(salary, na.rm = T),
            sd = sd(salary, na.rm = T),
            median = median(salary, na.rm = T),
            first_quartile = quantile(salary, 0.25, na.rm = T),
            third_quartile = quantile(salary, 0.75, na.rm = T),
            na_values = sum(is.na(salary)))
}
descriptive_stats(sal)

# а вот и не зависящее от кол-ва и названия переменных; не моё
# применение summarise_at !
descriptive_stats_2 <- function(data){
  grouped <- group_by_(data, .dots = names(which(sapply(data, is.factor))))
  grouped %>% summarise_at(vars(which(sapply(data, is.numeric))), 
                           funs(n = n(), 
                                mean = mean(., na.rm = T),
                                sd = sd(., na.rm = T),
                                median = median(., na.rm = T),
                                first_quartile = quantile(., 0.25, na.rm = T),
                                third_quartile = quantile(., 0.75, na.rm = T),
                                na_values = sum(sapply(., is.na))
                           )
  )
}
descriptive_stats_2(sal)

library(ggplot2)
str(diamonds)
diamonds2 <- diamonds[c()]
dz <- descriptive_stats_2(diamonds)
View(dz)

### 1.6.15
str(mtcars)
to_factors <- function(test_data, factors){
  test_data %>% mutate_at(factors, funs(as.factor(ifelse(. > mean(.), 1, 0 ))))
}
to_factors(mtcars[1:4], factors = c(1, 3))

# чужие решения (подставить в тело ф-ии):
# 1
mutate_at(df, factors, funs(factor(. > mean(.), labels = 0:1)))
# 2
df %>% mutate_at(factors, funs(as.factor(as.numeric(. > mean(.)))))
# 3
test_data %>% 
  mutate_if(.predicate=(log_col), funs(as.factor(ifelse(.>mean(.),1,0))))

### 1.6.16
str(diamonds)
high_price <- diamonds %>% 
  select(color, price) %>% 
  group_by(color) %>% 
  arrange(color, -price) %>% 
  slice(1:10)
View(high_price)

#*******************************************************************************
### 1.7 Data.Table
### 1.7.3
install.packages("data.table")
library(data.table)

# Создание data.table
# 1. переназначение
as.data.table(iris)
# 2. в ручную 
data.table(col1 = c(1:3), col2 = letters[1:3])
# 3. загрузка
fread("products.csv")
# обязательный параметр всего один - имя файла

products <- fread("products.csv")

system.time({
  for (i in seq_len(5)){
    fread("products.csv")
  }
})

system.time({
  for (i in seq_len(5)){
    read.table("products.csv", header = T, sep = ";")
  }
})

### 1.7.4
products <- fread("products.csv", encoding = "UTF-8") # чтобы русские буквы были

products[1:10, ] # первые 10 строк

products[products$price > 10000]
products[price > 10000] # с data.table можно и так
# несколько условий
products[(price > 10000) & (brand %in% c("Apple", "Epson"))]

### 1.7.5
# фильтрация

products[available, ] # не будет работать
# даже если указана логическая переменная, а не выражение, то в контексте
# data.table она не будет вычисляться

products[available == T, ] # только через выражение!

# в DT на первом месте всегда стоит выборка по строчкам, поэтому запятая после - 
# не обязательна
products[3,] # 3-я строка
products[3] # 3-я строка
iris[3,] # 3-я строка
iris[3] # 3-ий столбец

# инвертирование фильтрации
products[!products$price > 10000]
products[!1:10] # даже так можно

### 1.7.6
# выборка:

# x[i, j, by, with = TRUE, ...]
#  j = list(
#    name1 = {expr1},
#    name2 = {expr2}
#  )

products[, list(name = name,
                price.1k = price / 1000)]
# если не хотим менять переменную, то просто отсавляем ее имя
products[, list(name,
                price.1k = price / 1000)]

order(products$price, decreasing = T)
products[order(price, decreasing = T)] # сортируем по убыванию
products[order(price, decreasing = T),
         list(name, price.1k = paste0(price / 1000, " тыс.руб"))]

head(products[order(price, decreasing = T),
         list(name, price.1k = paste0(price / 1000, " тыс.руб"))], 5)

### 1.7.7 
# 1. столбец как вектор значений (как в дата фрейме)
products[order(price, decreasing = T),
         list(name, 
              price.1k = paste0(price / 1000, " тыс.руб"))]$price.1k

# 2. лист можно заменить на точку
products[, list(name, price)]
products[, .(name, price)]

# возврат к дата-фрейму with = F
products[, c("name", "price"), with = F]

# 3. трансформация
products[order(-price), .(name = head(name),
                          price = head(price))]
products[, .(price = sum(price))]

# 4. последовательное обращение
a <- products[, list(name.with.brand = paste0(brand, " - ", name))]
a[order(name.with.brand)]

products[, list(name.with.brand = paste0(brand, " - ", name))][order(name.with.brand)]

# 5. сложные вычисления - в фигурные скобки
products[, .(price = {
  a <- mean(price)
  b <- median(price)
  c(min(price), max(price), a/b)
})]

### 1.7.8
# агрегация осуществляется с помощью тех же квадратных скобок
# аналогия с SQL:
# x[i, j, by, with = true, ...]
# SELECT j from ...
# WHERE i
# GROUP BY by

# 1. В  by передается столбец, по которому будем агрегировать
# x[i, j, by, with = true, ...]
#         by = <column>

# или несколько столбцов:
# x[i, j, by, with = true, ...]
#         by = list(<column1>,
#                   <column2>, ...)  

# найдем среднее по бренду
products[, .(mean.price = mean(price)), by = brand]

# три самых дорогих товара в каждом бренде
products[order(-price), .(name = head(name, 3),
                          price = head(price, 3)), by = brand]
# использованеи head, а не [1:3] обусловлено тем, что не обязательно в бренде
# есть три товара; тогда появится NA

### 1.7.9
sample.products <- data.table(price = c(10000, 600000, 700000, 1000000),
                              brand = c("a", "b", "c", "d"),
                              available = c(T, T, F, T))
filter.expensive.available <- function(dt, nm) {
  dt[(price > 500000) & (available == T) & (brand %in% nm)]
}
filter.expensive.available(sample.products, c("a", "c", "d"))

# другие варианты:
dt[brand %in% nm][price >= 500000][available == T] # это решение чуть хуже

### 1.7.10
sample.purchases <- data.table(price = c(100000, 6000, 7000, 5000000),
                               ordernumber = 1:4,
                               quantity = c(1,2,1,-1),
                               product_id = 1:4)
ordered.short.purchase.data <- function(purchases) {
  purchases[order(-price)][!(quantity < 0), .(ordernumber, product_id)]
}
ordered.short.purchase.data(sample.purchases)

# чужой ответ: сначала лучше отфильтровать
purchases[quantity >= 0][order(-price), .(ordernumber, product_id)]

### 1.7.11
dt <- data.table(price = c(100000, 6000, 7000, 5000000),
                               ordernumber = c(1,2,2,3),
                               quantity = c(1,2,1,-1),
                               product_id = 1:4)
purchases.median.order.price <- function(dt) {
  dt(purchases[quantity > 0, 
            .(median.order = sum(price * quantity)), 
            by = ordernumber]$median.order)
}
# чужой ответ 
dt[quantity > 0][, .(w = sum(price*quantity)), by = ordernumber][, median(w)]

#*******************************************************************************
### 1.8 Data.Table продолжение
### 1.8.3
# .SD - subset of data, содержит data.table с подвыборкой группы
# если необходимо трансформировать все переменные

products[
  order(-price),
  .(
    product_id = head(product_id, 3),
    name = head(name, 3),
    price = head(price, 3),
    available = head(available, 3)
    ), by = brand]

products[
  order(-price),
  head(.SD, 3),
  by = brand]

# .N - кол-во элементов в группе
# либо nrow(.SD) или length(<column>)
products[price > 10000, .(expensive.item = .N), by = brand]

### 1.8.4
# := создает/изменяет столбец без создания копии объекта
# Изменить тип стлбца таким образои НЕЛЬЗЯ

# x[, new.column := expr]
# x[, c("col1", "col2") := list(expr1, expr2)]
# x[, `:=` list(col1 = expr1, col2 = expr2)]

# можно применять совместно с аггрегацией и фильтрацией
# x[i, new.column := expr, by]

# ф-ия set делает то же самое
# x[i, j := value]
# set(x, j, value)

# заново загружаем с прописыванием типа Price
products <- fread("products.csv", 
                  colClasses = c(price = "double"),
                  encoding = "UTF-8")
products[price < 1000, 
         name.with.price := paste0(name, " ( ", price, " .руб)")]
products[order(-price)]
# видим NA (

products[, price:=price / max(price), by = brand]

### 1.8.5
# КЛЮЧИ
products <- fread("products.csv", 
                  colClasses = c(price = "double"),
                  encoding = "UTF-8")
purchases <- fread("purchases.csv")


# создание ключей
setkey(purchases, product_id, externalsessionid)
setkey(products, product_id, brand)

# просмотр ключей
key(purchases)
key(products)

# соединение таблиц
merge(purchases, products, by = "product_id")
# если названия ключей разное, то прописываем имена отдельно
merge(purchases, products, by.x = "product_id", by.y = "product_id_2")
# левый и правый merge
merge(purchases, products, all.x = T, all.y = F)
merge(purchases, products, all.x = F, all.y = T) # будут NA

# а теперь то же самое, но в квадратных скобках)
purchases[products, on = "product_id"]
purchases[products] # ошибка, т.к. data.table пытается соединить таблицы 
                    # по всем ключам, а вторые ключи имеют разный тип
                    # если бы они имели один тым, то соединение произошло бы
                    # но результат был бы странным
# merge по дефолту делает inner join

# (J)oin, (S)orted (J)oin, (C)ross (J)oin


products[J(c(6, 9, 49, 999995))]
products[.(c(6, 9, 49, 999995))]
products[list(c(6, 9, 49, 999995))]
products[data.table(c(6, 9, 49, 999995))]

### 1.8.6
products <- fread("products.csv", 
                  colClasses = c(price = "double"),
                  encoding = "UTF-8")
purchases <- fread("purchases.csv")

purchases.with.brand <- merge(
  purchases,
  products[,list(product_id, brand)],
  by = "product_id"
)

pop.20.brand <- head(
  purchases.with.brand[,
                       list(
                         total.brand.users = length(unique(externalsessionid))
                       ),
                       by = brand][order(-total.brand.users)],20)



# че-то дата-тэйбл не пошел(((

#*******************************************************************************
### 2.1 Грамматика ggplot2, функция qplot
### 2.1.4

# ggplot2 основные принципы
# Aestetic attributes - определяют какие данные будут на графике и где
# Geometric objects - определяют, как именно будут отражены данные (линии, 
# точки, столбики и т.д.)
# Statistical transformation - определяют, какие трансформации с данными будут 
# отображены на графике (регрессионаая прямая или сгладживание) - не обязательно
# Scales - какие именно значения будут отображены на графике
# Coordinates - система координат
# Faceting - группировка данных


### 2.1.5
library(ggplot2)
data("diamonds")

# qplot - quick plot

qplot(x = price, data = diamonds)
qplot(x = price, y = carat, data = diamonds)
qplot(x = cut, y = carat, data = diamonds) # cut - фактор

v <- diamonds$carat
qplot(v)

### 2.1.6
depth_hist <- qplot(diamonds$depth)

### 2.1.7
qplot(diamonds$carat, diamonds$price)

my_plot <- qplot(x = price, y = carat, diamonds)
str(my_plot)
my_plot$mapping
my_plot$labels

### 2.1.8
str(diamonds)
qplot(x = price,
      y = carat,
      color = color,
      data = diamonds)

qplot(x = price,
      y = carat,
      color = color,
      data = diamonds,
      geom = "point")

qplot(mpg, 
      hp,
      color = factor(am),
      # color = I("green"),
      shape = factor(cyl),
      size = I(5),
      # size = 10,
      data = mtcars)

### 2.1.9
price_carat_clarity_points <- qplot(x = carat,
                                    y = price,
                                    color = clarity,
                                    data = diamonds)

### 2.1.10
?I # AsIs 
qplot(mpg, 
      hp,
      color = factor(am),
      shape = factor(cyl),
      size = I(5),
      alpha = I(0.5),
      data = mtcars)

# В лекции не сказано, но можно использовать совершенно любые hex цвета, 
# просто записывая их внутри функции I(), что очень удобно) I('#66cc66')

qplot(x = price,
      data = diamonds,
      fill = I("white"),
      color = I("black"))

qplot(x = price,
      fill = color,
      data = diamonds,
      color = I("black"))

qplot(x = price,
      fill = I('#66cc66'),
      data = diamonds,
      color = I("black"))

qplot(x = price,
      fill = color,
      data = diamonds,
      color = I("black"),
      geom = "density",
      alpha = I(0.3))

### 2.1.11
qplot(x = x, data = diamonds, geom = "density")

### 2.1.12
qplot(x = x,
      color = cut,
      data = diamonds,
      geom = "density")

### 2.1.13
qplot(x = color,
      y = price,
      data = diamonds,
      geom = "violin")

#*******************************************************************************
### 2.2 Функция ggplot и различные geoms
### 2.2.2
library(ggplot2)
ggplot(diamonds) # создастся пустое полотно
ggplot(diamonds, aes(x = price)) # уже есть шкала
ggplot(diamonds, aes(x = price)) +
  geom_histogram()

# внутри каждой подгруппы есть сглаживание
ggplot(diamonds, aes(x = price,
                     y = carat,
                     color = cut)) +
  geom_point() + 
  geom_smooth()

# а так мы сохраним одну линию тренда и разные цвета точек
ggplot(diamonds, aes(x = price,
                     y = carat)) +
  geom_point(aes(color = cut)) + 
  geom_smooth()

### 2.2.3
# переменные, задействованные в первой ggplot(, aes(...)) будут распространяться
# на все дальнейшие geom'ы и прочие натсройки графика

# а если сы хотим использовать какую-то переменную внутри только одного geom'а
# то ставим ее в этот geom
ggplot(diamonds, aes(x = price,
                     y = carat)) +
  geom_point(size = .5,
             alpha = .5) + 
  geom_smooth(size = 1.5, color = "red")

### 2.2.4
str(airquality)
library(dplyr)

glimpse(airquality) # расширенный str

# подготовим новый датафрейм
gr_airquality <- group_by(airquality, Month)
summarise(gr_airquality, mean_temp = mean(Temp), mean_wind = mean(Wind))

# а еще можно вот так
t <- airquality %>% 
  group_by(Month) %>% 
  summarise(mean_temp = mean(Temp),
            mean_wind = mean(Wind))

# так немного не корректно
ggplot(t, aes(Month,
              mean_temp,
              size = mean_wind)) +
  geom_point() + 
  geom_line()

# перенесем размер куда надо, поменяем цвет точек и порядок точка/линия
ggplot(t, aes(Month, mean_temp)) +
  geom_line() +
  geom_point(aes(size = mean_wind), color = "red")

# добавим простую горизонтальную линию
ggplot(t, aes(Month, mean_temp)) +
  geom_line() +
  geom_point(aes(size = mean_wind), color = "red") +
  geom_hline(yintercept = 75,      # (H)orisontal Line
             linetype = "dotted",
             size = 1,
             color = "blue")

### 2.2.5
?geom_errorbar
?geom_pointrange


sum_data <- mtcars %>% 
            group_by(am, cyl) %>% 
            summarise(mean_mpg = mean(mpg),
                      y_max = mean(mpg) + 
                        1.96 * sd(mpg) / sqrt(length(mpg)),
                      y_min = mean(mpg) - 
                        1.96 * sd(mpg) / sqrt(length(mpg)))

ggplot(sum_data, aes(x = factor(am),
                     y = mean_mpg,
                     col = factor(cyl), 
                     group = factor(cyl))) + 
  geom_line() +
  geom_errorbar(aes(ymin = y_min, ymax = y_max), width = 0.2) + 
  geom_point(size = 3)

ggplot(sum_data, aes(x = factor(am), y = mean_mpg)) + 
  geom_pointrange(aes(ymin = y_min, ymax = y_max))

### 2.2.6
?stat_summary
mean_cl_boot(mtcars$mpg) # сразу выдает среднее, мин и макс

# а теперь немного магии о_О (убираем предобработку)
ggplot(mtcars, aes(factor(am),
                   mpg,
                   col = factor(vs),
                   group = factor(vs))) + 
  stat_summary(fun.data = mean_cl_boot, geom = "errorbar", width = 0.2) + 
  # geom point берет первое значение из fun.data - среднее
  stat_summary(fun.data = mean_cl_boot, geom = "point") + 
  # geom_line() - выдаст абракадабру, поэтому делаем так:
  stat_summary(fun.data = mean_cl_boot, geom = "line") 
  
ggplot(mtcars, aes(factor(am),
                   mpg,
                   col = factor(vs),
                   group = factor(vs))) + 
  stat_summary(fun.data = mean_cl_boot, geom = "errorbar", width = 0.2) +
  stat_summary(fun.data = mean_cl_boot, geom = "point") +
  stat_summary(fun.y = mean, geom = "line") # так проще и интуитивней

sd_error <- function(x) {
  c(y = mean(x), ymin = mean(x) - sd(x), ymax = mean(x) + sd(x))
}

ggplot(mtcars, aes(factor(am),
                   mpg,
                   col = factor(cyl),
                   group = factor(cyl))) + 
  stat_summary(fun.data = sd_error, geom = "errorbar", width = 0.2) +
  stat_summary(fun.data = sd_error, geom = "point", size = 2) +
  stat_summary(fun.y = mean, geom = "line") # так проще и интуитивней

# чтобы не было наложения - position.dodge

ggplot(mtcars, aes(factor(am),
                   mpg,
                   col = factor(cyl),
                   group = factor(cyl))) + 
  stat_summary(fun.data = sd_error, geom = "errorbar", width = 0.2,
               position = position_dodge(0.3)) +
  stat_summary(fun.data = sd_error, geom = "point", size = 2,
               position = position_dodge(0.3)) +
  stat_summary(fun.y = mean, geom = "line",
               position = position_dodge(0.3))

### 2.2.7

ggplot(mtcars, aes(factor(am), mpg)) +
  geom_violin() +
  geom_boxplot(width = 0.2) 

### 2.2.8
sales = read.csv("https://stepic.org/media/attachments/course/724/sales.csv",
                 encoding = "UTF-8")
str(sales)
# sale - число проданных товаров
# shop - номер магазина
# date - год, за который велась статистика
# season - время года
# income - доход магазина

ggplot(sales, aes(income, sale)) + 
  geom_point(aes(col = shop)) + 
  geom_smooth()

### 2.2.9
ggplot(sales, aes(shop, income, col = season)) +
  stat_summary(fun.data = mean_cl_boot,
               position = position_dodge(0.2),
               size = 1)
# 
my_plot <- ggplot(sales, aes(shop, income, col = season))+
  stat_summary(geom = "pointrange", position = position_dodge(0.2)) 

### 2.2.10
library(ggplot2)
install.packages("Hmisc")
library(Hmisc)
ggplot(sales, aes(date, sale, color = shop), position = position_dodge(0.2)) + 
  stat_summary(fun.data = mean_cl_boot,
               geom = "errorbar",
               # position = position_dodge(0.2),
               width = 0.2,
               size = 1) +
  stat_summary(fun.data = mean_cl_boot,
               geom = "point",
               # position = position_dodge(0.2),
               size = 2) +
  stat_summary(fun.y = mean,
               geom = "line",
               # position = position_dodge(0.2),
               size = 1)







### 3.1.8
# csv взят отсюда
# http://open.canada.ca/data/en/dataset/b52664cf-bfd9-49ad-849a-cb88c92553b9 
gl <- read.csv("glacier.csv", na.strings = "..")
str(gl)
nlevels(gl$GEO) # кол-во ледников

# 1 ответ
gl %>% 
  group_by(GEO) %>%
  summarise(Val = max(Ref_Date) - min(Ref_Date)) %>% 
  filter(Val == min(Val)) %>% 
  select(GEO)

# 2 ответ
gl %>%
  filter(MEASURE == "Annual mass balance") %>% 
  group_by(GEO) %>% 
  summarise(M = median(Value, na.rm = T)) %>% 
  filter(abs(M) == min(abs(M))) %>% 
  select(GEO)

# 3 ответ
gl %>% 
  filter(is.na(Value)) %>% 
  select(GEO)


