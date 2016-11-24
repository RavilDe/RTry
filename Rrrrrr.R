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

matrix(1:6, ncol = 3)
matrix(1:6, ncol = 3, byrow = TRUE)

# dim - атрибут матрицы, отвечаюзий за размерность

m <- matrix(1:6, ncol = 3)
dim(m)
c(nrow(m), ncol(m))
dim(m) <- NULL; m
dim(m) <- c(2, 3); m

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
colnames(m) <- paste0("column", 1:5)
m["row2", c("column2", "column4"), drop=F]

# Присоединение матриц: rbind / cbind
rbind(m1, m2)  # сложение по вертикали
cbind(m1, m2)  # сложение по горизонтали

# Аргумент ... (elipsis)
# позволяет передавать неограниченное кол-во элементов 
cbind(m1, m2, 1:2, c(5,3), m2[ , 1], m1 * 3, cbind(m2, m1))

# Применение функции к матрице: apply
m <- matrix(1:25, 5)
f <- function(x) sum(x ^ 2)

# три аргумента функции apply:
# - матрица
# - индекс (1 - по строкам, 2 - по столбцам)
# - функция
apply(m, 1, f)
apply(m, 2, f)

apply(m, 1:2, function(i) if (i > 13) i else 13) # 1:2 - обращение ко всей матрице
# функция без имени - анонимная функция
m[m <= 13] <- 13; m # но так проще

# rowSums, rowMeans, colSums, colMeans
# сумма и среднее
m <- matrix(1:25, 5)
rowSums(m)
# проверим
all.equal(rowSums(m), apply(m, 1, sum))
all.equal(rowMeans(m), apply(m, 1, mean))
# задача 2.1.3
mat <- matrix(0, 3, 2)
mat[3, 2]
mat > 5

##### Задача 2.1.4
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
list(a = 1, b = 2, "1to5" = 1:5, 42 )
list(a = list(1, 2, 3), b = list(list(4), 5, 6)) # немного рекурсии

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
lapply(l, function(s) paste(s, collapse = "|")) # то же самое, но через анонимную функцию

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

gen_list <- function(n_elements, max_len, seed = 111) {  # seed = 111 - аргумент по умолчанию, если не задать третий аргумент
  set.seed(seed)
  len <- sample(1:max_len, n_elements)
  lapply(1:n_elements, function(i) rnorm(len[i]))
}

l1 <- gen_list(4, 10) 
l1
gl1 <- get_longest(l1)
gl1$number

l2 <- gen_list(4, 10, 777)
l2
gl2 <- get_longest(l2)
gl2$number


#### Задача 2.1.11
count_elements <- function(x) {
 y <- sort(unique(x))
 rbind(y, colSums(sapply(y, function(i) ifelse(i == x, 1 , 0.))))
}

count_elements_2 <- function(x) sapply(sort(unique(x)), function (n) c(n, sum(x == n))) # не мое

#### Задача 2.1.13

bastille <- list(
       "La Chapelle Tower" = rbinom(5, 10, 1/2), 
       "Tresor Tower" = rbinom(8, 12, 1/4), 
       "Comte Tower" = rbinom(14, 3, 1/5) + 1,
       "Baziniere Tower" = rbinom(8, 4, 4/5), 
       "Bertaudiere Tower" = rbinom(4, 8, 2/3),
       "Liberte Tower" = rbinom(1, 100, 0.1), 
       "Puits Tower" = rbinom(5, 5, 0.7),
       "Coin Tower" = rbinom(3, 16, 0.4)
   )

bb8 <- lapply(bastille, sum)
bb <- unlist(bb8)
c <- sum(unlist(bb8))
a <- names(which.min(unlist(bb8)))
b <- bb[which.min(bb)]
names(b) <- NULL
a; b; c

#### Урок 2.2.2
# Data frame!!!!!!!

df <- data.frame(x = 1:4, y = LETTERS[1:4], z = c(T, F))
str(df) # структура
summary(df) # более полная картина)

# имена
df <- data.frame(x = 1:4, y = LETTERS[1:4], z = c(T, F),
                 row.names = c("Alpha", "Bravo", "Charlie", "Delta" ))
rownames(df); colnames(df) 
dimnames(df) # лист из имен строк и столбцов

# размерности
nrow(df)
ncol(df)

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
merge(df, df_salary, by = "x") # inner join 
merge(df, df_salary, by = "x", all = TRUE) # outer join
merge(df, df_salary, by = "x", all.df = TRUE) # left outer
merge(df, df_salary, by = "x", all.df_salary = TRUE) # right outer
merge(df, df_salary, by = NULL) # right outer

# Задача 2.2.5
which.max(rowSums(attitude[order(-attitude$lear),][1:5,][c("complaints", "raises", "advance")]))
# слизал с подсказки((((    АД

# Задача 2.2.8
# Количество станций, зарегистрировавших землетрясение, записанное третьим
quakes[3,]["stations"]

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
summary(avian)

#### Задача 2.2.11
names(avian)
height_variables <- names(avian)[-(1:4)][c(F, T)][-7]; height_variables
names(sort(colSums(avian[,height_variables]), decreasing = TRUE))
summary(avian[, height_variables]) # чит; не вывел упорядоченный вектор имен ((((((

names(sort(unlist(lapply(avian[,height_variables],max)), decreasing = TRUE)) # об дошло)))


