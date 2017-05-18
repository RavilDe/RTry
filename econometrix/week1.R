### Lesson 1.2.1
5 + 6
factorial(10)
 
b <- 11
5 -> a
a + b
 
# Зависит от регистра
A <- 55
a + A
 
# Не забываем про табуляцию
very_long_variable <- 12
very_long_variable
 
# Вектора
y <- c(3, 5, -2, NA, 9)
# NA - not available
 
# операции с векторами
y + 2
 
0 / 0 # NaN - not a number
1 / 0 # Inf - бесконечность
1 / Inf 
atan(Inf) # 1.570796
all.equal(atan(Inf), pi / 2) # TRUE

z <- 100:200

### Lesson 1.2.2
x <- c(23, 15, 46, NA)
z <- c(5, 6, NA, 8)

# Простые операции над векторами
mean(x)
mean(x, na.rm = T)
mean(z, na.rm = T)

sum(x)
sum(x, na.rm = T)

# Создадим датафрейм
d <- data.frame(rost = x, ves = z)
d

# Адресция
d[4, 1]
d[3, 1]

d[2, ]
d[, 2]

d$rost
d$ves

# Списки
my_list <- list(a = 7, b = 10:20, table = d)
my_list

my_list$a
my_list$b
my_list$table


my_list[2] 
my_list[[2]] # второй объект в списке

### Lesson 1.2.3
library(ggplot2)
library(dplyr)
library(GGally) # диаграммы рассеивания
library(psych) # описательные статистики
library(devtools)

install_github("bdemeshev/sophisthse")
library(sophisthse)

?predict
?describe

### Lesson 1.2.4
?cars
d <- cars
str(d)
glimpse(d) # круче str, выводит больше переменных
head(d)
tail(d)
describe(d)
ncol(d)
nrow(d)

mean(d$speed)

# Преобразуем переменные в человеческий вид
d2 <- mutate(d, 
             speed = 1.67 * speed, 
             dist = 0.3 * dist, 
             ratio = dist / speed)
glimpse(d2)

# Строим графики
qplot(data = d2, dist) # для себя:)
qplot(data = d2,
      dist,
      xlab = "Длина тормозного пути (м)",
      ylab = "Кол-во машин",
      main = "Данные 1920х годов")

qplot(data = d2, speed, dist)

### Lesson 1.2.5
# МНК на примеер машин
model <- lm(data = d2, dist ~ speed) # dist - зависимая переменная
                                   # speeв - объясняющая переменная (регрессор)
model
# выводятся оценки коэффициентов 
# 1 коэф (intersept) - это длина тормозного пути у машины с нулевой скоростью; в
# теории он должен быть равен нулю
# 2 коэф (speed) - насколько увеличится тормозной путь, при увеличении
# скорости на 1км/ч (в среднем)

# Извлечем полезности из модели
beta_hat <- coef(model) # бэты с крышками
eps_hat <- residuals(model) # эпсилон с крышкой
y <- d2$dist
y_hat <- fitted(model) # y с крышкой

RSS <- deviance(model)
TSS <- sum((y - mean(y)) ^ 2)
ESS <- TSS - RSS
R2 <- ESS / TSS
cor(y, y_hat) # выборочная корреляция
cor(y, y_hat)^2 # R2 по другому

X <- model.matrix(model)

# Используем модель для прогнозирования
nd <- data.frame(speed = c(40, 60)) # новый набор данный
predict(model, nd)

# Рисуем график
qplot(data = d2, speed, dist) +
  stat_smooth(method = "lm")

### Lesson 1.2.6
# Пример с фертильностью

t <- swiss
?swiss
glimpse(t)
describe(t)

# Диаграммы рассеивания
ggpairs(t)
model2 <- lm(data = t,
             Fertility ~ Agriculture + Education + Catholic)
coef(model2)
fitted(model2) # спрогнозированные значения
residuals(model2) 

report <- summary(model2)
report$r.squared

cor(t$Fertility, fitted(model2)) # корреляция м/у исходной и спрогнозированной
cor(t$Fertility, fitted(model2))^2 # R^2

# Новый набор данны
nd2 <- data.frame(Agriculture = 0.5,
                  Catholic = 0.5,
                  Education = 20)

# Прогонозируем новый набор данных по модели 2
predict(model2, nd2) # спрогнозированный показатель фертильности

### Test Week 1
# 1
weighted.mean(c(-1, 0, 1), c(0.3, 0.2, 0.5))

# 2
  # 7 - неа
  # E(aX+bY+c)=aE(X)+bE(Y)+c  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# 3
  # 22 - неа
  # Var(aX+bY+c)=a2Var(X)+b2Var(Y)+2abCov(X,Y) %%%%%%%%%%%%%%%%%%%%%

# 4
  # Прогнозирование заработной платы выпускника ВУЗа
  # Установление направления причинно-следственной связи (определяет ли
  # образование продолжительность жизни или наоборот)
  #  - все наоборот((((( %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# 5
  # Отклонений реальных данных от предсказаний по модели

# 6
  # Одна зависимая переменная объясняется при помощи набора независимых

# 7
  # RSS не верно%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# 8
checkSS <- function(TSS, RSS, ESS, R2) {
  if (TSS == RSS + ESS & R2 == ESS / TSS) {
    print("Подходит")
  } else {
    print("Не подходит")
  }
}
checkSS(20, 8, 12, 0.6) # только этот подходит
checkSS(10, 8, 4, 0.4)
checkSS(20, 8, 6, 0.6)
checkSS(20, 9, 12, 0.6)

# 9
  # Точность "подгонки" модели к данным

# 10
TSS <- 100
RSS <- 70
R2 <- (TSS - RSS) / TSS # 0.3

# 11
R2 <- 0.7
TSS <- 130
RSS <- TSS - R2 * TSS # 39

# 12
  # 0 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# 13
y <- c(2, 2, 1.75, 2.25, 2)
y_hat <- 2
TSS <- sum((y - mean(y))^2)
ESS <- sum((y_hat - mean(y))^2)
R2 <- ESS / TSS

# 14
data(sleep)
str(sleep)
sleep[7, 1] # 3.7

# 15
data(sleep)
a <- mean(sleep$extra)^2 # 2.37
round(a, 2)

# 16
data(sleep)
min(sleep$extra) + max(sleep$extra)

# 17
data(sleep)
mean((sleep[1:10, 1] - mean(sleep[1:10, 1]))^2)
var(sleep[1:10, 1]) # variaty или дисперсия случайной величины 
sd(sleep[1:10, 1])^2

# 18
data(mtcars)
str(mtcars)
model <- lm(data = mtcars, mpg ~ disp + hp + wt)
coef(model)

y <- mtcars$mpg
y_hat <- fitted(model)
cor(y, y_hat)^2 # выборочная корреляция в квадрате = R2

RSS <- deviance(model)
TSS <- sum((y - mean(y)) ^ 2)
ESS <- TSS - RSS
R2 <- ESS / TSS
R2

# 19
data(mtcars)
str(mtcars)
model <- lm(data = mtcars, mpg ~ disp + hp + wt + am)
coef(model)

# 20
data(mtcars)
model_1 <- lm(data = mtcars, mpg ~ disp + hp + wt)
model_2 <- lm(data = mtcars, mpg ~ cyl + hp + wt)
model_3 <- lm(data = mtcars, mpg ~ disp + cyl + wt)
model_4 <- lm(data = mtcars, mpg ~ disp + hp + cyl)

r_from_model <- function(model) {
  y <- mtcars$mpg
  y_hat <- fitted(model)
  cor(y, y_hat)^2
}

r_from_model(model_1)
r_from_model(model_2)
r_from_model(model_3)
r_from_model(model_4)
