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
desc




