#### Урок 1.2.5
help("sin")
help.search("sin")

#### Урок 1.2.8
2+1
sin(pi / 3)
sin(pi / 2)

cats <- 3
dogs <- 4
pets <- cats + dogs

?rnorm # нормальное распределение
rnorm(15)
rnorm(15, mean = 5, sd = 3) # mean - среднее, sd - стандартное отклонение

# Функции

return_two <- function() {
  y <- 2
  return(y)
}
return_two()

# Окружение функции
addten <- function(x) {
  x <- x + 10
}
addten(cats)  # не работает, т.к. мы переприсвоили Х в локальном окружении, а вглобальном он так и остался

addten <- function(x) {
  return(x + 10)
}
addten(cats)  # вот теперь все верно

# Глобальное присваивание (лучше не использовать)
addten <- function(x) {
  moredogs <<- (x + 10)
}
addten(dogs); dogs; moredogs
# Функции меняющие глобальные переменные - это функции со сторонним эффектом (side effect)

# Удаление переменных из окружения
ls() # List Object
rm(dogs) # Remove
rm(moredogs)
rm(list = ls()) # Remove all
ls()

#### Урок 1.3.2 - Векторы
x <- c(5,8); x # c - combine; данная функция может быть вложенной и принимать переменные
1:10
3:-7  # оператор : - создание числовых последовательностей с шагом 1

seq(1,2, by =0.25) # seq - Sequence Generation; by - по сколько делить
seq(3,4, length.out = 5)  # length.out - на сколько частей делить
seq(3,4, length = 5) # сокращенное написанеи

rep(1:3, times = 4)       # rep - replicate; times - сколько раз повторять САМ вектор
rep(1:3, each = 3)        # each - сколко раз повторить КАЖДЫЙ элемент
rep(1:3, length.out = 7)  # length.out - длинна повторения всего вектора


#### Урок 1.3.5

hello <- "Hello world"
print(hello)
hello

0.1 + 0.1 == 0.2
0.1 + 0.05 == 0.15 
all.equal(0.1 + 0.05, 0.15)
# http://stackoverflow.com/questions/9508518/why-are-these-numbers-not-equal 

u <- seq(0, 1, 1/3)
v <- seq(0, 1, 1/7)
c(u, v)
help.search('sort')
w <- sort(c(u,v))
unique(w)

#### Урок 1.3.7
# Типы векторов:
# - logical (T/F)
# - integer (целые числа)
# - numeric/double (числа с плавающей точкой)
# - complex (комплексные)
# - character (строки)
# - raw (байтовые последовательности)

# typeof и is.*
a <- c("Дуб - дерево", "Роза - цветок", "Воробей - птица", "Учится - круто")
typeof(a)
is.character(a)
s.logical(a)

# Приведение типов
# logical ---> integer ---> double ---> character

b <- c(FALSE, 1.5)
typeof(b)
b <- c(5, b, "abc")
typeof(b)

as.numeric(b)
as.integer(b)

# Длина вектора: length
x <- 1:100
length(x)

length(x) <- 4; x
length(x) <- 7; x

# Именованные вектора
a <- c(uno = 1, dos = 2, "universal answer" = 42, 99)
names(a)
names(a) <- c("one", "two", "forty two", "ninety nine")
a
names(a) <- NULL

# Векторная арифметика
1:3 + c(-1, 2, 0)
1:3 * c(-1, 2, 0)
c(TRUE, TRUE, TRUE) & c(0, 1, 999)

# Векторизация
# vectorized
sqrt(1:4)
# vectorized
floor(seq(0, 3, by = 0.25))
# not vectorized
sum(1:100)

#### Урок 1.4.2 
# Управляющие конструкции и работа с пакетами
# if и else

# if (condition) {
#   do somthing
#   } else {
#    do another thing 
#   }

# condition - это выражение, результатом которого будет логический вектор длины 1 (T или F; NA - приведет к ошибке)
# переносить else нельзя

if (sqrt(2) < 1.5) {
  print("Меньше")
} else {
  print("Больше")
}

if (c(T, F)) print("Hmmm...")
# выдает предупреждение, и считывает только первое из условий
# поэтому ->

# ifelse
ifelse(runif(8) > 0.5, "Орел", "Решка")

x <- runif(8)
ifelse(x > 2/3, "Камень",
       ifelse(x > 1/3, "Бумага", "Ножницы"))

# Switch - множественный выбор (используется редко)
switch("factorial", 
       sum = 5 + 5,
       product = 5 * 5,
       factorial = factorial(5),
       0)

# Циклы Repeat
i <- 0
repeat {
  i <- i + runif(1)
  print(i)
  if (i > 5) break
}


# Циклы While
i <- 2 ^ 14
while (i > 1000) {
  i <- i/2
  print(i)
}
# repeat выполнится хотя бы 1 раз, while может ни разу

# Циклы For
for (i in 1:8) {
  if (i %% 2 == 0) print(i)
}

for (i in letters) {
  if (i == "c") next
  if (i == "f") break
  print(i)
}

# for против векторизации
v <- 1:1e5
system.time({
  x <- 0
  for (i in v) x[i] <- sqrt(v[i])
})
# подсчет идет 62с (на рабочем компе)

system.time({
  y <- sqrt(v)
})
# подсчет идет 0с (на рабочем компе)
identical(x, y)


# Задача 1.4.4
set.seed(1337)
x <- runif(1e6, min = -1, max = 1)

sum(ifelse(x > -0.2 & x < 0.3, 1, 0))

# Задача 1.4.5
dice_roll <- function(n) {
  return(floor(runif(n,1,6)))
}

#### Урок 1.4.6
.libPaths() # список библиотек, где лежат пакеты
# CRAN - центральный репозиторий
installed.packages()

grid.newpage()
library(grid)
grid.lines()

library(xts)
install.packages("xts", dependencies = T)

update.packages() # обновление пакетов
sessionInfo()

#### Урок 1.5.2
# Правила переписывания (recycling)

# - Длина результата равна длине большего из векторов
# - Меньший вектор дублируется (переписывается) несколько раз, чтобы длина переписанного вектора совпала с длиной большего
# - Если длина большего вектора не делится нацело на длину меньшего, выдаётся предупреждение

1:5 + 0:1
# выдаст предупреждение

1:10 + 3
(7:9) * -1
(7:9) ^ -1
1:4 == 2

# Доступ к элементам
x <- seq(10, 100, by = 10)

# Положительные индексы - выводит номер элемента
x[1]
x[3:7]
x[c(8, 7, 5, 6:9, x[1])]

# Отрицательные индексы - все кроме этих
x[-5]
x[-(2:9)]
x[-length(x)] # все кроме последнего
x[c(-7, -5, -length(x), -5)]

# логическое индексирование
# элементы, соответствующие значению TRUE
x[rep(c(F, T), 5)]
x[c(F, T)]
x[x > 77 & x < 99]

# индексация по имени
a[c("one", "two", "forty two")]

# all и any
all(x < 200); all(x > 150)
any(x < 150); any(x > 5)

# функция which

which(x >= 50)
which.min(x); which.max(x)

# Атрибуты объектов
# length - свойство объекта, оно есть всегда
# Атрибуты (names, dimnames, dim, ...) могут присутствовать если это необходимо

x <- c(5, 3 ,9)
names(x) <- c("V", "III", "IX"); x

attr(x, "autor") <- "Caesar"
attributes(x)
attributes(x) <- NULL

##### Урок 1.5.6  
# fizz-buzz imperative style
y <- vector(mode = "character", length = 100) # резервируем пустой вектор на 100
y <- character(100) # так кроче
for (i in 1:100) {
  if (i %% 15 ==0) {
    y[i] <- "fizz buzz"
  } else if (i %% 3 ==0) {
    y[i] <- "fizz"
  } else if (i %% 5 ==0) {
    y[i] <- "buzz"
  } else {
    y[i] <- i
  }
}

# fizz-buzz vector-orientesd style
x <- 1:100
z <- 1:100
x %% 5
x %% 5 == 0
z[x %% 5 == 0] <- "buzz"
z[x %% 3 == 0] <- "fizz"
z[x %% 15 == 0] <- "fizz buzz"
all.equal(y,z)

##### Урок 1.5.8
(0:7)/7
# Geometric progression
x <- 2 ^ (0:10)
x
log2(x)

# Some randomes
set.seed(42)
x <- sample(1:100, 50)
x

# Neighbors with greatest diff
x[-1]
x[-length(x)]
x[-1] - x[-length(x)]
k <- which.max(abs(x[-1] - x[-length(x)]))
x[c(k, k + 1)]

# Multiply min/max
x <- sample(1:100, 50, replace = T) # replace - с повторами или без (T/F)
min(x)
which.min(x)
which((x == min(x))) #!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

# Packing into function

maxdiff <- function(x) {
  y <- abs(x[-1] - x[-length(x)])
  k <- which(y == max(y))
  print("First neighbour (s):")
  print(x[k])
  print("Second neighbour (s):")
  print(x[k+1])
  print("Maximum absolute diff is:")
  print(max(y))
}

xx <- sample(1:100, 1e4, replace = T)

##### 2.1 Матрицы и списки
#"Alt" + "-" автоматически выводит знак присваивания "<-"
# Матрица - двумерный массив данных одного типа
# По сути это вектор уложенный по столбцам

matrix(1:6, ncol = 3)
matrix(1:6, ncol = 3, byrow = TRUE)

# переписывание матрицы, если вектор меньше общего числа элементов матрицы
matrix(7:8, nrow = 2, ncol = 5)

# отличие матрицы от вектора - у первой есть атрибут dim
# dim - атрибут матрицы, отвечаюзий за ее размерность

m <- matrix(1:6, ncol = 3)
dim(m)
c(nrow(m), ncol(m)) # делают то же самое
dim(m) <- NULL; # превращаем матрице в вектор
dim(m) <- c(2, 3); m # и обратно вектор в матрицу

# арифметические операции действуют поэлементно, с учетом правил переписывания
m1 <- matrix(1:4, nrow = 2)
m2 <- matrix(c(1, 2, 2, 3), nrow = 2)

m1 + m2   # операции производятся поэлементно
m1 + 5
m1 * 2
m1 * m2

m1 %*% m2  # умножение по правилам линейной алгебры

#  Индексирование матриц
m <- matrix(1:10, ncol = 5)
m[1, 3]
m[2, ]
m[ ,4]

m[1, ] <- 0; m
m[ , -5] <- 11:18; m

# Схлопывание размерности
m <- matrix(1:10, ncol = 5)
ind <- c(1, 3, 5)
m[ , ind]

ind <- 3
m[ , ind]
m[ , ind, drop=FALSE]   # drop - чтобы столбец не превратился в вектор и оставался столбцом
# TRUE и FALSE - T и F

# Именованые матрицы
m <- matrix(1:10, ncol = 5)
rownames(m) <- c("row1", "row2")
colnames(m) <- paste0("column", 1:5) # past0 отличается от paste только отсутсвием зазора по дефолту ("")
# тперь можно обращаться к матрице по именам столбцов и строк
m["row2", c("column2", "column4"), drop=F]

# Присоединение матриц: rbind / cbind
rbind(m1, m2)  # сложение по вертикали
cbind(m1, m2)  # сложение по горизонтали

# Аргумент [...] (elipsis)
# позволяет передавать неограниченное кол-во элементов 
cbind(m1, m2, 1:2, c(5,3), m2[ , 1], m1 * 3, cbind(m2, m1))

# Применение функции к матрице: apply
m <- matrix(1:25, 5)
f <- function(x) sum(x ^ 2)

# три аргумента функции apply:
# - матрица
# - индекс (1 - по строкам, 2 - по столбцам)
# - функция
apply(m, 1, f) # по строкам (первое измерение)
apply(m, 2, f) # по столбцам (второе измерение)

apply(m, 1:2, function(i) if (i > 13) i else 13) # 1:2 - обращение ко всей матрице
# функция без имени - анонимная функция
m[m <= 13] <- 13; m # но так проще

# rowSums, rowMeans, colSums, colMeans
# сумма и среднее
m <- matrix(1:25, 5)
rowSums(m)
colSums(m)

# проверим
all.equal(rowSums(m), apply(m, 1, sum))
all.equal(colMeans(m), apply(m, 2, mean))

# задача 2.1.3
mat <- matrix(0, 3, 2)

mat[3, 2]
mat > 5

##### Задача 2.1.4
# Предположим, что у нас есть целочисленный вектор v и число n. Наша задача — найти позицию элемента в векторе, 
# который ближе всего к числу n. При этом если таких элементов несколько, необходимо указать все позиции.
# Напишите функцию, которая принимает на вход вектор и число и возвращает вектор индексов, отвечающих указанному условию. 
# Индексы должны быть выстроены по возрастанию.
# Пример. Пусть v <- c(5, 2, 7, 7, 7, 2, 0, 0) и n=1. 
# Ответом будет вектор
# 
# 2 6 7 8
# 
# Подсказки: 
#   "ближе всего" означает минимальную разницу между числами;
#   не забудьте про модуль!

a1 <- c(5, 2, 7, 7, 7, 2, 0, 0)
b1 <- 1

a2 <- 10:1
b2 <- 4.5

find_closest <- function(v, n) {
  r <- abs(v-n)
  which(r == min(r))
}

##### Урок 2.1.5
# bind matrices  diagonally
bind_diag <- function(m1, m2, fill) {
  m3 <- matrix(fill, 
               nrow = nrow(m1) + nrow(m2),
               ncol = ncol(m1) + ncol(m2))
  m3[1:nrow(m1), 1:ncol(m1)] <- m1
  m3[nrow(m1) + 1:nrow(m2), ncol(m1) + 1:ncol(m2)] <- m2 # у двоеточия приоритет выше!!!
  m3
}

m1 <- matrix(1:12, nrow = 3)
m2 <- matrix(10:15, nrow = 3)
bind_diag(m1, m2, fill = NA)
bind_diag(m1, m2, fill = 0)

#### Задача 2.1.6
zikkurat <- function(n) {
  m <- matrix(nrow = 2 * n - 1, ncol = 2 * n - 1)
  for (i in 1:n) {
    m[i:(2 * n - i),i:(2 * n - i)] <- i
  }
  print(m)
}

#### Урок 2.1.7 

# Списки
list(1:5, "my_data", matrix(0, 2, 2))
# именование некоторых элементов списка
list(a = 1, b = 2, "1to5" = 1:5, 42 )
# немного рекурсии - элементом списка может быть список
list(a = list(1, 2, 3), b = list(list(4), 5, 6))

# Конкатенация списков (объединение)
l1 <- list(name = "Jhon", salary = 1000)
l2 <- list(has_car = T, car = "lambo")
c(l1, l2)

# конверсия между списком  вектором
# любой вектор легко свести к списку:
v <- 1:5
l <- list(v)

# но не наоборт; если сведение осмыслено, то есть unlist
l <- list(1:3, 4:5, last = 6)
unlist(l)
unlist(c(l, "spy"))

# доступ к элементам списка
l[3:2]; l[-(1:2)]
l[c(F, T, F)]; l["last"]

# доступ к конкретному элементу [[]]
l[[1]]
l[['last']]

# доступ по имени с частичным дополнением, $
l$last
l$l
l$la
l$las

# Одинарные скобки
#   действуют векторные правила индексирования
#   возвращаемое значение -- подсписок
# Двойные скобки
#   (скалярный) номер элемента или его полное имя
#   возвращаемое значение -- элемент списка
# Знак доллара
#   частичное имя элемента
#   возвращаемое значение -- элемент списка



# Замена и добавление элементов списка
l <- list(1:3, 4:5, last = 6)
l[[3]] <- NULL; l
l[[4]] <- 99; l # не обязательно указывать элементы подряд

l <- list(vec = 1:7, fun = sqrt) # l$fun(4)
names(l)
is.null(l$string) # проверка на наличие такого элемента по названию
l$string <- "Cititus, altius, fortius" # элемент добавляется в конец
l

# Применение функции к списку  lapply
l <- list(a = c("12", "34"), b = LETTERS[5:10], c = 1:5)
lapply(l, length)
lapply(l, paste, collapse = "|")
lapply(l, function(s) paste(s, collapse = "|")) # то же самое, но через анонимную функцию; и длинно

sapply(l, paste, collapse = "|") # simplify apply - преобразует в вектор

# частичное дополнение по $ и аргументам функции
l <- list(some_name = 1, incredibly_long_name = 2)
l$inc + 1   # чтобы каждый раз не писать длинное имя
f <- function(x, ridiculously_long_arg) x + ridiculously_long_arg
f(3, ridic = 5) # в функции не обязательно писать имя аргуента полностью
f(3, 5)

# NA -- это пропущенное значение ("not available"). Например, респондент не ответил 
#  на все вопросы предложенной анкеты, или данные с метеостанции за определённый период потерялись 
#  из-за сбоя оборудования. NA в этом случае обозначает, что эти данные существуют и имеют смысл, 
#  но их не удалось узнать.
# NaN -- "not-a-number" -- результат недопустимой арифметической операции, 
#  например 0/0 или Inf - Inf.
# NULL -- отсутствие объекта, "пустота". Применяется в тех случаях, 
#  когда объект действительно не существует, не может иметь осмысленного значения.
# Для проверки значений есть три функции, is.na, is.nan и is.null, соответственно.

#### урок 2.1.10

get_longest <- function(l) {
  len <- sapply(l, length)
  ind <- which.max(len)
  list(number = ind, element = l[[ind]])
}

gen_list <- function(n_elements, max_len, seed = 111) {  # seed = 111 - аргумент по умолчанию, 
                                                         # если не задать третий аргумент
  set.seed(seed)
  len <- sample(1:max_len, n_elements)  # создаем вектор случайных длин;
                                        # из ветора 1:max_len выбираем n_elements-элементов
  lapply(1:n_elements, function(i) rnorm(len[i]))
}

l1 <- gen_list(4, 10); l1
gl1 <- get_longest(l1)
gl1$number

l2 <- gen_list(4, 10, 777); l2
gl2 <- get_longest(l2)
gl2$number

#### Задача 2.1.11
count_elements <- function(x) {
 y <- sort(unique(x))
 rbind(y, colSums(sapply(y, function(i) ifelse(i == x, 1 , 0.))))
}

count_elements_2 <- function(x) sapply(sort(unique(x)), function (n) c(n, sum(x == n))) # не мое

#### Задача 2.1.13
set.seed(1789)
bastille <- list(
       "La Chapelle Tower" = rbinom(5, 10, 1/2), 
       "Tresor Tower"      = rbinom(8, 12, 1/4), 
       "Comte Tower"       = rbinom(14, 3, 1/5) + 1,
       "Baziniere Tower"   = rbinom(8, 4, 4/5), 
       "Bertaudiere Tower" = rbinom(4, 8, 2/3),
       "Liberte Tower"     = rbinom(1, 100, 0.1), 
       "Puits Tower"       = rbinom(5, 5, 0.7),
       "Coin Tower"        = rbinom(3, 16, 0.4)
       )

bb <- unlist(lapply(bastille, sum)); bb # именованый вектор сумм солдат на каждой башне
c <- sum(bb); c                         # сумма всех солдат
a <- names(which.min(bb)); a            # название башни с минимальным кол-вом солдат
b <- bb[which.min(bb)]; b               # кол-во солдат на этой башне
names(b) <- NULL; b                     # убираем имя
a; b; c                                 # выводим

#### Урок 2.2.2
# Data frame!!!!!!!

df <- data.frame(x = 1:4, y = LETTERS[1:4], z = c(T, F))
str(df) # структура
summary(df) # более полная картина; obs - obserwation, наблюдение

# имена
df <- data.frame(x = 1:4,
                 y = LETTERS[1:4],
                 z = c(T, F),
                 row.names = c("Alpha", "Bravo", "Charlie", "Delta" ))

rownames(df); colnames(df) 
dimnames(df) # список (list) из имен строк и столбцов

# размерности
nrow(df)
ncol(df)
dim(df)

# особенности
# length(df) - возвращает кол-во столбцов (переменных), 
# names(df) - так же возвращает имена столбцов
length(df); names(df)

# индексация data frame
   # индексация в матричном стиле
df[3:4, -1]
df[c(F, T), c("z", "x")]
df[ ,1]; df[ , 1, drop = F] # drop - читобы колонка не схлопнулась в строку

   # индексация как для списка
# если необходимо обратится к столбцу, это проще сделать через $
df$z; df[[3]]; df[["z"]]
df[[1]]; df[1] # равносильно предыдущему "матричному" вызову

# фильтрация по условию
df[df$x > 2,]
subset(df, x > 2) # нет повтора названия df, нет $, не нужны кавычки для имени столбца
subset(df, x > 2, select = c(x, z)) # select - условия на столбцы

# Комбинирование data frame
rbind(df, data.frame(x = 5:6, y = c("K", "Z"), z = TRUE, row.names = c("Kappa", "Zulu")))
cbind(df, data.frame(season = c("Summer", "Autumn", "Winter", "Spring"), temp = c(20, 5 , -10, 5)))

# Комбинирование data frame'ов: merge
df
df_salary <- data.frame(x = c(3, 2, 6, 1), salary = c(100, 1000, 300, 500))
df_salary
merge(df, df_salary, by = "x")                       # inner join 
merge(df, df_salary, by = "x", all = TRUE)           # outer join
merge(df, df_salary, by = "x", all.df = TRUE)        # left outer
merge(df, df_salary, by = "x", all.df_salary = TRUE) # right outer
merge(df, df_salary, by = NULL)                      # right outer

# Задача 2.2.5
names(which.max(rowSums(attitude[order(-attitude$lear),][1:5,][c("complaints", "raises", "advance")])))
# слизал с подсказки((((    АД

#### Урок 2.2.6
# Импорт данных

# Из файла:
# Comma separated values (.csv), tab separated values
# Неструктурированный текст -- readLines, scan
# XML, HTML -- library(XML), library(httr), ...
# JSON, YAML -- library(rjson), library(RJSONIO), ...
# Excel -- library(XLConnect), library(readxl)
# SAS, Stata, SPSS, MATLAB -- library(foreign), library(sas7bdat)
# Web -- library(rvest)
# Базы данных:
#   Реляционные -- library(DBI), library(RSQLite), ...
# Нереляционные -- library(rmongodb), ...
# ...

# Основной инструмент: read.table
# file -- имя файла
# header -- наличие или отсутствие заголовка в первой строке
# sep -- разделитель значений, dec -- десятичная точка
# quote -- символы, обозначающие кавычки (для строкового типа)
# na.strings -- строки, кодирующие пропущенное значение
# colClasses -- типы столбцов (для быстродействия и указания типа: строка-фактор-дата/время)
# comment.char -- символ, обозначающий комментарий (после этого символа все выкидывпется)
# skip -- количество строк пропускаемых c начала файла

# Функции read.csv, read.csv2, read.delim и read.delim2 суть оболочки над read.table с расставленными умолчаниями

# Типичные этапы (пред)обработки данных

# Импорт в дата фрейм
# Очистка значений, проверка типов
# Работа со строками: имена, переменные строкового типа, факторы
# Пропущенные значения: идентификация, способ обработки
# Манипулирование переменными: преобразование, создание, удаление
# Подсчёт описательных статистик: split-apply-combine
# Визуализация данных
# Экспорт
# Очистка значений, проверка типов
 
# Типы переменных, на которых легко ошибиться при импорте:
  
#   Числовые типы становятся строковыми
# из-за пропущенных значений, отмеченных не как NA na.strings = c("NA", "Not Available", "Missing")
# из-за неверно указанных разделителя, десятичного знака 
# sep = ",", dec = "."
# из-за кавычек, сопроводительного текста или комментариев 
# quote, comment.char, skip
# Строковые типы становятся факторами либо наоборот 
# as.character, as.factor
# Тип "дата/время" остаётся строковым as.POSIXct, as.POSIXlt, as.Date
# . . .
 
# Функции str, summary, head и tail помогут определить, всё ли в порядке

# Работа с переменными

# Функции complete.cases и na.omit для удаления наблюдений с пропущенными значениями: 
#   df[complete.cases(df), ] либо na.omit(df)
# Замена NA на некоторые значения может быть потенциально опасной
# заполнение средним может вносить смещение в данные
# заполнение нулями в большинстве случаев вообще некорректно!
#   Создание, изменение и удаление переменных выполняется конструкциями 
# df$new_var <- <...>, 
# df$old_var <- f(df$old_var), 
# df$old_var <- NULL
# Кроме того, для работы сразу с большим количеством переменных есть функция within

#### Задача 2.2.7
# Какими из нижеуказанных способов можно выбрать только те строки, 
# которые соответствуют департаментам с рейтингом (rating) ниже пятидесяти, 
# при этом сохранив все столбцы, кроме rating?

attitude[attitude$rating < 50, -"rating"]                   # нет
attitude[rating < 50, names(attitude) != "rating"]          # нет
subset(sel = -rating, sub = rating < 50, attitude)          # да
subset(attitude, rating < 50, -rating)                      # да
attitude[attitude$rating < 50, names(attitude) != "rating"] # да


# Задача 2.2.8

# Количество станций, зарегистрировавших землетрясение, записанное третьим
quakes[3,]["stations"]
quakes$stations[3]
head(quakes)

# Медианная глубина землетрясений (км)
median(quakes$depth)
summary(quakes)

# Средняя глубина землетрясений (км)
mean(quakes$depth)
summary(quakes)

# Минимальная сила землетрясений по шкале Рихтера
min(quakes$mag)
summary(quakes)

# Максимальная сила землетрясений по шкале Рихтера
max(quakes$mag)
summary(quakes)

# Количество станций, зарегистрировавших землетрясение, записанное предпоследним
quakes[nrow(quakes) - 1, ]["stations"]

#### Урок 2.2.9 практика

# importing and inspecting data
avian <- read.csv("D:/Miheykin/Desktop/avianHabitat_sewardPeninsula_McNew_2012.csv")
# P* -  процентные переменные
# *Ht -  переменные с высотой

# checking data
str(avian)
summary(avian)
head(avian) # выводит нескоько первых строк таблицы
tail(avian) # выводит нескоько последних строк таблицы

any(!complete.cases(avian)) # проверка на пропуски
any(avian$PDB < 0) # есть ли проценты меньше нуля
any(avian$PDB > 100) # есть ли проценты больше сотни

check_percent_range <- function(x) {
  any(x < 0 | x > 100)
}

# tranforming variables
names(avian)
coverage_variables <- names(avian)[-(1:4)][c(T,F)] # остекаем первые 4 имени столбцов и берем только первый из двух
avian$total_coverage <- rowSums(avian[, coverage_variables]) # создаем новую переменную(столбец) и заносим туда сумму по строке
summary(avian$total_coverage)

#### Задача 2.2.10
avian_2 <- read.csv("D:/Miheykin/Desktop/avianHabitat_2.csv", 
                    dec = ".",
                    skip = 5, # пропускаем первые пять строк
                    comment.char = "%", # убираем комментарии, начинающиеся с %
                    na.strings = "Don't remember", # убиваем нечисловые значения
                    sep = ";"); avian_2

any(!complete.cases(avian_2))
which(!complete.cases(avian_2))

str(avian)
str(avian_2)

avian_2$total_coverage <- rowSums(avian_2[, coverage_variables]) # добавляем переменную итогового покрытия
avian_2$Observer <- NA # добавляем пустую переменную Observer
str(avian_2)

summary(rbind(avian, avian_2))
summary(rbind(avian, avian2)$total_coverage) # так тоже можно)))

#### Задача 2.2.11
names(avian)
height_variables <- names(avian)[-(1:4)][c(F, T)][-7]; height_variables
(hight_variables <- names(avian)[str_detect(names(avian), "Ht$")]) # можно еще вот так!) wildcard $ - это окончание строки
names(sort(colSums(avian[,height_variables]), decreasing = TRUE))
summary(avian[, height_variables]) # чит; не вывел упорядоченный вектор имен ((((((
names(sort(unlist(lapply(avian[,height_variables], max)), decreasing = TRUE)) # об дошло)))

sort(sapply(avian[, hight_variables], max), decreasing = T) # добавлено 13/12/2016 - упорядоченный именованиый вектор с ответами

#### Урок 2.3.2
# Факторы и строкиы
# строка (string) - это элемент типа  character
s <-c("Терпение и труд все перетрут",
      "Кончил дело - гуляй смело",
      "Без труда не вытащишь и рыбку из пруда",
      "Работа не волк, в лес не убежит"); s

ss <- 'Операция "Ы"'; ss # - случай, когда нужны оба типа кавычек

# функции  paste и paste0 - конкатенация строквых векторов
# sep - разделитель
# для paste разделитель по умолчанию - пробел
# для paste0 разделитель по умолчанию - ничего (пусто)
# аргумент collapse - схлопывает вектор в одну строку

paste(c("веселящий", "углекислый"), "газ")
paste(c("веселящий", "углекислый"), "газ", sep = "_")
paste(c("веселящий", "углекислый"), "газ", collapse = ", а так же ")

# strsplit - разделение строки; на выходе имеем list
strsplit(s, " и ", fixed = T)
# если не указывать аргумент fixed (по умолчанию FALSE), то строка, 
# по которой проводится разбиение, будет рассматриваться как регулярное вырвжение
strsplit(s, "[[:punct:]]")

# http://stackoverflow.com/questions/10738729/r-strsplit-with-multiple-unordered-split-arguments - пара примеров

# Регулярные выражения
# метаязык поиска и манипуляции подстрок
# образец для поиска может включать обычные символы и т.н. wildcards

grep("труд", s) # в какие элементы вектора s входит слово "труд" 
grepl("труд", s) # логический grep
gsub("\\b[[:alpha:]]{4,5}\\b", "####", s) # ВАЩЕ КОСМОС!) замена всех слов длинной 4 и 5 букв на решетки

# Пакет stringr
install.packages("stringr") # если надо установить пакет
library(stringr) # подключение пакета

str_extract(s, "н.") # находит первое вхождение "н." в строке; точка означает любой сигнал
str_extract_all(s, "н.") # находит все вхождения "н."; на выходе получаем лист
ls("package:stringr") # выводит все функции в пакете

str_replace(s, "[иа]", "?") # заменяет первое вхождение И или А в строке на знак вопроса
str_replace_all(s, "[иае]", "?") # заменяет все вхождения "н." в строке на знак вопроса

# Функции tolower / toupper - манипулироание регистром
tolower(month.name)
toupper(month.abb)

#### 2.3.3 Задача
length("Аэрофотосъёмка ландшафта уже выявила земли богачей и процветающих крестьян.")
# результат 1
nchar("Аэрофотосъёмка ландшафта уже выявила земли богачей и процветающих крестьян.")
# нужный нам результат - кол-во букв в строке

#### 2.3.5 урок
# пути к файлам
getwd() # рабочая директория; get working directory
# к файлам, находящимся в этой директории можно обратится без указания полного пути!
list.files()
list.files(pattern = ".R$") # все R-файлы
head(list.files()) # выводит первые 6 элементов
list.dirs("..", recursive = F) # ".." - на уровень выше; recursive - без заглядывания во вложенные папки 

setwd # смена рабочей директории

# форматирование чисел!!!
c(pi, exp(pi))
format(c(pi, exp(pi)), digits = 4)
formatC(c(pi, exp(pi)), digits = 4) 
formatC(c(pi, exp(pi)), digits = 4, format = "e") 

# функция cat
print('Операция "Ы"'); cat('Операция "Ы"')

print("трус\tбалбес\nбывалый"); cat("трус\tбалбес\nбывалый")
# escape-последовательности
# \t - табуляция
# \n - новая строка
# подробнее - ?Quotes

#### 2.3.6 Задача

hamlet <- "To be, or not to be: that is the question:
Whether 'tis nobler in the mind to suffer
The slings and arrows of outrageous fortune,
Or to take arms against a sea of troubles,
And by opposing end them?"

hamlet <- str_replace_all(hamlet, "[:punct:]", "") # убираем все знаки препинания
hamlet <- tolower(unlist(str_split(hamlet, "[:space:]")))

length(grep("to", hamlet)) # кол-во слов "to"  
length(grep("[fqw]", hamlet)) # кол-во слов, содержащих "f" , "q" или "w"
length(grep("b.",hamlet)) # кол-во слов содержащих букву b и еще одну (хотя бы) после нее
length(grep("\\b[[:alpha:]]{7}\\b",hamlet)) # кол-во 7-буквенных слов; без \\b выдает все слова от 7-ми букв и больше 

# а еще можно было сделать через sum(str_count())
sum(str_count(hamlet, "\\bto\\b"))
sum(str_count(hamlet, "\\b[[:alpha:]]{7}\\b"))

#### Урок 2.3.8
    # Факторы
# В статистике существует деление на количественные и качественные переменные
# Для качественных переменных есть factor
# Фактор -- это гибрид целочисленного (integer) и строкового (character) вектора
set.seed(1337)
f <- factor(sample(LETTERS, 30, replace = T))
f
as.numeric(f) # выводит порядковый номер
as.character(f) # выводит строковый вектор
levels(f) # вернет строковый вектор, состоящий из уровней, уникальных градациях фактора
nlevels(f) # кол-во градаций; length(levels(f)) - то же самое :)

# индексирование определено для == и !=
f[f == "A"] <- "Z" # меняем все А на Z
f
f <- droplevels(f) # удаляем все пустые градации фактора
f
(f <- droplevels(f)) # если операцю присваивания обернуть в круглые скобки, то автоматом будет печататься результат!!!!!!

# преобразование уровней фактора
(levels(f) <- tolower(levels(f))) # переводим все уровни в нижний регистр
#(levels(f) <- LETTERS[letters %in% levels(f)])
f
levels(f)[2] <- "zzz"
f

# Упорядоченные факторы
temper <- c("freezing cold", "cold", "comfortable", "hot", "burning hot")
ft <- ordered(sample(temper, 14, replace = TRUE), temper)
ft
ft[ft <= "cold"]
ft[ft >= "hot"]

# Преобразование количественной переменной в качественную
# cut разбивает numeric интервалы
# table производит подсчет кол-ва элементов для каждого уровня фактора
cut(rnorm(10), -5:5)
table(cut(rnorm(1e3), -5:5)) # распредеение всех испытаний по категориям

# небольшой шаг в сторону - options

# У сессии R есть набор активных настроек, отвечающих за подсчёт и вывод результатов вычислений
# ?options :
#   digits -- количество знаков при печати чисел
# error -- поведение при ошибке
# width -- длина строки при печати векторов и матриц
options()
# По умолчанию, все строковые переменные становятся факторами, 
# отменить такое поведение можно вызовом options(stringsAsFactors = FALSE)

# возвращаемся к факторам - tapply
# Факторы чаще всего встречаются как переменные в дата фреймах
# Одна из наиболее распространённых задач -- подсчёт некоторой статистики по группам
?warpbreaks
str(warpbreaks)
summary(warpbreaks)
tapply(warpbreaks$breaks, warpbreaks$wool, max)
?tapply

##### Задача 2.3.10
sort(table(cut(quakes$mag, breaks = seq(4, 6.5, 0.5), right = F)), decreasing = T)
# границы взял в лоб, наверное можно по-другому

##### Практика 2.3.11

# какой-то негодяй удалил все переменный в окружении
rm(list = ls())

# копируем урок 2.2.9 в отдельный файл avianHabitad.R,
# кладем его в рабочую папку проекта, туда же кидаем .csv с данными
# проверяем рабочую директорию
getwd()

# запускаем все еще раз
source("avianHabitad.R")

head(avian) # проверяем образовался ли data.frame

# попробуем найти avianHabitad(..).csv самостоятельно
list.files() # если слишком много файлов, то попробуем задать паттерн

list.files(pattern = ".*\\.csv$")
# расшифровка wildcard'ов
# точка - любой символ
# звездочка после точки - означает что точка может повторяться какое угодно кол-во раз, т.е. нам не важно название файла
# два бэкслэша - чтобы экранировать настоящую точку перед буквами csv
# доллар - конец строки

# если файл слишком большой и открыть его сложно (съест всю память)
readLines("avianHabitat_sewardPeninsula_McNew_2012.csv", 5) # печатает перве 5 строк

# удостоверямся в верности файла и загружаем его
avian <- read.csv("avianHabitat_sewardPeninsula_McNew_2012.csv")
# а если нет, то загружаем более осторожно
avian <- read.table("avianHabitat_sewardPeninsula_McNew_2012.csv", header = T, sep = ",", dec = ".")
head(avian)

# анализируем таблицу в Enviroment->Data->Avian (стрелочка вниз):
# у Observer всего три уровня фактора, а у Site целых 101 - это много!
# см файл avianHabitad.R с новым строками, которые переводят Observer в строковый тип (character)
# см файл на предмет автоматизации проверки процентов в соответствующих столбцах

unique(avian$Site)

#### задача 2.3.13
sort(tapply(avian$total_coverage, avian$Site_name, mean), decreasing = T)

#### задача 2.3.14
# находим названия переменных с высотами
height_variables <- names(avian)[str_detect(names(avian), ".*Ht$")]

# 
t(sapply(height_variables, function(htht) tapply(avian[[htht]], avian$Observer, max)))

#### Урок 3.1.2
# Функция как объект
str(c(mean, max))
fun_list <- c(mean, max)
sapply(fun_list, function(f) f(1:100))

# функция как аргумент
apply_f <- function(f, x) f(x)
sapply(fun_list, apply_f, x = 1:100)

# анонимная функция тоже подойдет
apply_f(function(x) sum(x^2), 1:10)

# Функция как возвращаемое значение (return value)
square <- function() function(x) x^2
square()
square()(2)

# Функции внутри функций
f <- function(x) {
  g <- function(y) if (y > 0) 1 else if (y < 0) -1 else 0
  sapply(x, g)
}
all.equal(f(-100:100), sign(-100:100)) # можно проще))

# Исходный код функции
# Простейший случай: напечатать имя функции без скобок (напр., sd)
(f <- function(x) x^5)
# Если в выводе есть .C, .Call, .Fortran, .External, .Internal, .Primitive, 
# то это обращение к скомпилированному коду: нужно смотреть исходный код R (напр., var)
# Если в выводе есть UseMethod или standardGeneric, то это method dispatch для классов S3/S4 (полиморфизм; напр., plot)
methods(plot)[1:20]

# Возвращаемое значение функции
# определяется ключевым словом return
has_na <- function(v) {
  for (k in v) if (is.na(k)) return(TRUE) 
  return(FALSE)
} # после return работа функции прекращается
# либо последним вычисленным значением (если нет return'a)
has_na <- function(v) any(is.na(v)) # узнали, что ф-я is.na векторизована; упрощаем

# Аргументы по умолчанию
seq(from = 1, to = 1, by = ((to - from)/(length.out - 1)),
    length.out = NULL, along.with = NULL, ...)
seq() # from = 1, to = 1
seq(1, 5, length.out = 11) # by = (5 - 1)/(11 - 1)

# Правила разбора аргументов
# Рассмотрим на примере:
  
  f <- function(arg1, arg2, remove_na = TRUE, ..., optional_arg) {}
f(1, arg2 = 2, remove = F, optional_arg = 42, do_magic = TRUE)

# Разбор аргументов проходит в три этапа:
  
# 1. Точное совпадение имени аргумента - arg2, optional_arg
# 2. Частичное совпадение имени аргумента (только до ...) - remove_na
# 2. Разбор аргументов по позиции - arg1
# Неразобранные аргументы попадают в ... - do_magic

# Проброс аргументов
# Один случай использования ellipsis - "произвольное количество передаваемых объектов", функции sum, c, cbind, paste
# Другой характерный случай - "проброс аргументов":
  
f <- function(x, pow = 2) x^pow
integrate(f, 0, 1) # lower = 0, upper = 1, pow = 2
integrate(f, 0, 1, pow = 5) # same, but pow = 5
# неразобранный для ф-ии integrate арг-т paw попадает в ... и передается дальше в ф-ию f 

# Бинарные оперторы
# Оператор x %in% y: есть ли вхождение элементов x в y?
1:5 %in% c(1, 2, 5)
"%nin%" <- function(x, y) !(x %in% y)

#### Задача 3.1.4

decorate_string <- function(pattern, x, ...) {
  rev_pattern <- paste(rev(strsplit(pattern, NULL)[[1]]), collapse = "")
  paste0(pattern, paste(x, ...), rev_pattern)
}

#### Урок 3.1.6 (практика)

# Generate deck card
values <- c("Ace", 2:10, "Jack", "Qeen", "King")
suits <- c("Clubs", "Diamonds", "Hearts", "Spades")
card_deck <- outer(values, suits, paste, sep = " of ") # outer - возвращает все возможные комбинации двух векторов; результат ф-ии paste
card_deck # визуально проверим
length(card_deck) # 52 Ok

# Function factory
# внутренняя функция выбирает n случайных чисел из набора set с повтарениями
# внешняя функция 
generator <- function(set) function(n) sample(set, n, replace = T)

# Define generators
card_gen <- generator(card_deck)
coin_gen <- generator(c("Heads", "Tails"))

# let's play
card_gen(7)
coin_gen(15)

#### Задача 3.1.7
generator <- function(set, prob = rep(1/length(set), length(set))) { 
  function(n) sample(set, n, replace = TRUE, prob)
}

roulette_values <- c("Zero!", 1:36)
fair_roulette <- generator(roulette_values)
rigged_roulette <- generator(c(roulette_values, "Zero!"))

fair_roulette(10); rigged_roulette(10)

# проверка вероятностей
plot(table(fair_roulette(1e5)))
plot(table(rigged_roulette(1e5))) 

#### Задача 3.1.8
svd # ответ
base::norm() # - если необходимо обратится к функции из другого пакета при совпадении имен
detach(package:QuantPsyc) # отключение пакета

#### Задача 3.1.9
# пишем бинарник

"%+%" <- function(x, y) {
  max_l <- max(length(x),length(y))
  min_l <- min(length(x),length(y))
  a <- c(rep(NA, max_l))
  a[1:min_l] <- x[1:min_l] + y[1:min_l]
  return(a)
}

# крутое решение Сергея Козырева
'%+%' <- function(x, y) {
  length(x) <- length(y) <- max(length(x), length(y))
  x + y
}


#### Урок 3.2.2
# Объектно-ориентированные системы
 
# В R их сразу три:
   
# 1. S3
#  - Нет формальной декларации класса
#  - Функция может иметь разное поведение (method dispatch) в зависимости от класса
#  - Такие функции называются generic
# 2.  S4
#  - Строгое определение класса и его полей
#  - Больше возможностей для поведения методов
# 3. Reference classes
 
# Больше об объектно-ориентированном программировании можно узнать в "Advanced R"


# Generic функции
# Например, функция print - generic:
   
length(methods(print))
# То есть, если x - дата фрейм, то вызовется print.data.frame(x); если x - функция, то print.function(x) и так далее
# Если ни один из методов не подходит, то print.default(x)
print.data.frame <- function(df) print(dim(df))
print(warpbreaks)


# Функции без сторонних эффектов
# В R нет указателей на объекты, все объекты передаются "по значению" (есть нюансы!)
# При попытке изменить переданный объект заводится его копия в локальном окружении (copy-on-modify semantics)
f <- function(k) {
  k <- k + 1
  a <- a + k^2
  a
}
k <- 5
f(k)
a <- 10
c(f(k), k, a)

# функция replicate
# Многократный вызов функции, зависящей от датчика случайных чисел

# Устройство работает исправно (0) либо ломается (1)
# моделирование работы такого устройства с подсчетом кол-ва поломок
get_status <- function(n, p = 0.1) {
  x <- rbinom(n, 1, p)
  sum(x)
}
replicate(5, get_status(100)) # повторяем 5 раз вызов функции get_status

# функция mapply
# Многомерная sapply
mapply(seq, from = 1:4, to = 2:5, by = 1 / (1 + 1:4))
# суть результатов:
list(
  seq(1, 2, 1/2), seq(2, 3, 1/3),
  seq(3, 4, 1/4), seq(4, 5, 1/5)
)

# функция outer
# Перебор всех возможных комбинаций элементов
m <- outer(LETTERS, letters, paste0)
dim(m)
diag(m)
m[1:5, 1:5]
str(m)
summary(m)

# Vectorize
# это способ векторизовать функцию, которая таковой не является
lp_norm <- function(x, p = 2) {
  if (p >= 1) sum(abs(x)^p)^(1/p) else NaN
}
lp_norm(1:10, -1:4)
lp_norm <- Vectorize(lp_norm, "p")

# Вызов ф-ии на списке аргументов - do.call
df1 <- data.frame(id = 1:2, value = rnorm(2))
df2 <- data.frame(id = 3:4, value = runif(2))
df3 <- data.frame(id = 222, value = 7)
rbind(df1, df2, df3)
do.call(rbind, list(df1, df2, df3))
# Но зачем? А для тех случаем, когда объектов неизвестно сколько:
do.call(rbind, lapply(list.files(), function(file) read.csv(file)))

#### Задача 3.2.4
# Просмотр всех функций семейства apply
ls(pos = "package:base", pattern = "apply")

#### Задача 3.2.5
# Про котиков
cat_temper <- c("задиристый", "игривый", "спокойный", "ленивый")
cat_color <- c("белый", "серый", "чёрный", "рыжий")
cat_age <- c("кот", "котёнок")
cat_trait <- c("с умными глазами", "с острыми когтями", "с длинными усами")


cat_catalogue <- do.call(outer, list(cat_temper, cat_color, cat_age, cat_trait))
outer(outer(cat_temper, cat_color, paste), outer(cat_age, cat_trait, paste), paste)

mapply(outer, list(cat_temper, cat_color, cat_age, cat_trait), paste)

replicate()

# решение в лоб((((((
a <- outer(cat_temper, cat_color, paste)
b <- outer(cat_age, cat_trait, paste)
c <- outer(a, b, paste)
library(stringi)
stri_sort(c)[42]

# через 
cat_catalogue1 <- expand.grid(cat_temper, cat_color, cat_age, cat_trait)

#### Урок 3.2.6 (практика)
# Random walk with absorption
simulate_walk <- function(lower = -10, upper = 10, n_max = 200, p = 1e-3) {
  current_position <- (lower + upper) / 2
  for (i in 1:n_max) {
    is_absorbed <- rbinom(1, 1, p)
    if (is_absorbed) return(list(status = "Absorbed", 
                                 position = current_position, 
                                 steps = i))
    current_position <- current_position + rnorm(1)
    if (current_position < lower) return(list(status = "Left breach", 
                                              position = current_position, 
                                              steps = i))
    if (current_position > upper) return(list(status = "Right breach", 
                                              position = current_position, 
                                              steps = i))
  }
  return(list(status = "Max steps reached", 
              position = current_position,
              steps = n_max))
}

# Simulate results
result <- replicate(10000, simulate_walk(), simplify = FALSE)
result <- data.frame(
  status = sapply(result, function(x) x$status),
  position = sapply(result, function(x) x$position),
  steps = sapply(result, function(x) x$steps)
)

# Inspect results
# сумма всех испытаний по категориям
tapply(result$position, result$status, length)
# Средняя длина траектории
tapply(result$steps, result$status, mean)

#### Задача 3.2.7
# Теперь на плоскости
simulate_walk_2 <- function(x = 0, y = 0, border = 6, n_max = 100, p = 1e-2) {
  current_position <- sqrt(x^2 + y^2)
  for (i in 1:n_max) {
    is_absorbed <- rbinom(1, 1, p)
    if (is_absorbed) return(1)
    x <- x + rnorm(1)
    y <- y + rnorm(1)
    current_position <- sqrt(x^2 + y^2)
    if (current_position > border) return(2)
  }
  return(3)
}
system.time({
  result_2 <- replicate(100000, simulate_walk_2(), simplify = TRUE)
})
table(result_2)

#### Задача 3.2.8

ls(pos = "package:graphics", pattern = "^plot[.]")
ls(pos = "package:base", pattern = "^summary[.]")
ls(pos = "package:base", pattern = "^print[.]")
# на рабоче компе нет print.default
# проверял тут - http://www.r-fiddle.org/


sapply(c("matrix", "function", "default"), function(pat) grep(pat, methods(print)))

#### Задача 3.2.9
# сам не ответил(((
f <- function(y) {
  y <- x + y
  y
}

g <- function(x) {
  y <- f(x)
  f <- function(x) {
    y - x
  }
  y - f(x)
}

x <- 10
y <- 1
f(x); f(y)
g(x); g(y)
x; y

#### Задача 3.2.10
m1 <- function(x, y) {
  m <- matrix(0, length(x), length(y))
  for (i in 1:length(x)) 
    for (j in 1:length(y)) {
      m[i, j] = x[i] * y[j]
    }
  m
}

m2 <- function(x, y) {
  vapply(y, function(i) i * x, numeric(length(x)))
}

m3 <- function(x, y) x %o% y

x <- rnorm(100)
y <- runif(1000)
all.equal(m1(x, y), m2(x, y))
all.equal(m2(x, y), m3(x, y))

library(microbenchmark)
microbenchmark(m1(x, y), m2(x, y), m3(x, y))

#### Урок 3.3.2
# Пакет tidyr
set.seed(1122)
df <- data.frame(Name = c("Jhon", "Piter", "Mary", "Caroline"),
                 DrugA_T1 = runif(4, 35, 36),
                 DrugA_T2 = runif(4, 36, 39),
                 DrugB_T1 = runif(4, 36, 36.6),
                 DrugB_T2 = runif(4, 37, 38.5)
); df
install.packages("tidyr")
library(tidyr)
# Связка gather-spread
df <- gather(df, Variable, Temperature, -Name)
# Связка separate-unite
df <- separate(df, Variable, c("DrugType", "Time"), "_")

# Пакет dplyr
library(dplyr)
select(df, Time, Temperature)
select(df, 3:4)
select(df, -Name, -Time)
select(df, starts_with("T"))

filter(df, Temperature>37, Name %in% c("Mary","Piter"))

# select - работает по столбцам
# filter - по строкам
# subset - аналог из base

# сортировка сначала по Name, потом (внутри каждогоимени) по убыванию Т
arrange(df, Name, -Temperature)

# изменение переменных
mutate(df, DrugType = gsub("Drug", "", DrugType))

# связка ф-ий group_by и summarise
summarize(group_by(df, Time),
          AvgTemp = mean(Temperature))

# Полезные ссылки
library(data.table)
# Cheat sheet по tidyr и dplyr: https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf
# Современный взгляд на предобработку данных: dplyr, tidyr и magrittr. https://github.com/tonytonov/spbr-1-dataproc


#### Задача 3.3.4
dfdf <- data.frame(first_name = "Eugene",
                   last_name  = "Oldman",
                   email_address  = "ping@pong.org",
                   postal_address = "Somewhere in Rusland",
                   date_added = "22/12/2016")

#### Урок 3.3.5
# Конвеерная запись
df <- data.frame(type = c(1, 1, 2, 2, 3, 3), value = c(5, 10, 50, 100, 7, 7))
arrange(
  summarize(
    group_by(df, type),
    Total = sum(value)
  ),
  -Total
)

a <- group_by(df, type)
b <- summarise(a, Total = sum(value))
c <- arrange(b, -Total)

df %>%
  group_by(type) %>%
  summarise(Total = sum(value)) %>%
  arrange(-Total)

# Эквивалентная запись:

#   x %>% f 
# f(x)

#  x %>% f(y) 
# f(x, y)

#  x %>% f(y, param = .) 
# f(y, param = x)

#### Задача 3.3.6
?transmute
?sample_n
?inner_join 

#### Урок 3.3.9 (практика)
# см avianHabitad.R после 

#### Задача 3.3.11
avian <- read.csv("avianHabitat_sewardPeninsula_McNew_2012.csv")
summary(avian)
str(avian)

avian %>% mutate(Site = factor(str_replace(Site, "[:digits:]+", "")))

#### 3.4.1

# Что дальше?

# Визуализация (base R, ggplot2, lattice, ...)
# Огромное количество методов и алгоритмов в разных областях (CRAN Task Views)
# knitr/rmarkdown
# Разработка и поддержка пакетов
# Advanced R
# Параллельные алгоритмы и оптимизация кода

# Intro to ggplot2: https://github.com/tonytonov/ggplot-lecture

# Rmarkdown: https://github.com/tonytonov/tcts-rmarkdown

# dplyr, tidyr, magrittr: https://github.com/tonytonov/spbr-1-dataproc

# R and С++, Parallel R, plotting, etc.: SPb R user group http://vk.com/spbrug

# Послесловие

# Материалы курса: https://github.com/tonytonov/Rcourse
# Увидимся! Всем спасибо!..
# ... with best Regards, Антон Антонов
