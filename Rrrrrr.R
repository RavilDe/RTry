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

seq(1,2, by=0.25) # seq - Sequence Generation; by - по сколько делить
seq(3,4, length.out = 5)  # length.out - на сколько частей делить
seq(3,4, length= 5) # сокращенное написанеи

rep(1:3,times=4)       # rep - replicate; times - сколько раз повторять САМ вектор
rep(1:3,each=3)        # each - сколко раз повторить КАЖДЫЙ элемент
rep(1:3,length.out=7)  # length.out - длинна повторения всего вектора


#### Урок 1.3.5

hello <- "Hello world"
print(hello)
hello
c(1,3,2)
0.1+0.1==0.2


all.equal(0.1+0.05,0.15)
u <- seq(0,1,1/3)
v <- seq(0,1,1/7)
c(u,v)
help.search('sort')
get_fractions <- function(m,n) {
  u <- seq(0,1,1/3)
  v <- seq(0,1,1/7)
}
if (sqrt(2)<1.5) {
  print("Меньше")
} else {
  print("Больше")
}

i <- 0
repeat {
  i <- i +runif(1)
  print(i)
  if (i>5) break
}

i <- 2^14
while (i>1000) {
  i <- i/2
  print(i)
}

system.time({
  count_num <- 0
  for (i in 1:length(x)) {
    if (x[i]>(-0.2)) {
      if (x[i]<0.3) count_num<-count_num+1
    }
  }
})


dice_roll <- function(n) {
  return(floor(runif(n,1,6)))
}

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
