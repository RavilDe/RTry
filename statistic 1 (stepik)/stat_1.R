### Основы статистики
### https://stepik.org/76

a <- c(157, 159, 161, 164, 165, 166, 167, 167, 167, 168, 169, 169, 170, 170,
       170, 171, 171, 172, 172, 172, 172, 173, 173, 175, 175, 177, 178, 178, 
       179, 185)
d <- data.frame(b = a)
ggplot(d, aes(b)) + 
  geom_dotplot()
# или
qplot(a, geom = "dotplot")

require(ggplot2)
set.seed(789)
x <- data.frame(y = sample(1:20, 100, replace = TRUE))
ggplot(x, aes(y)) + 
  geom_dotplot()
ggplot(x, aes(y)) + 
  geom_dotplot(binwidth = 1, method = 'histodot') + 
  ylim(0, 15)

# меняем шкалу на z-score 
ggplot(d, aes(scale(x))) + geom_dotplot()

### 1.7.6
h_hat <- 175
sd <- 8
h <- 186.2
z <- (h - h_hat) / sd

### 1.7.11
M <- 100 # выборочное среднее
D <- 25 # дисперсия
sd <- sqrt(D)
M + 2*sd
M - 2*sd

### 1.7.12
M <- 100
sd <- 15
z <- (125 - M) / 15
# смотрим таблицы http://www.stat.ufl.edu/~athienit/Tables/Ztable.pdf или
# http://www.normaltable.com/ztable-righttailed.html

# подсмотрел в ответах
n <- 10000
dt <- rnorm(n, mean = 100, sd = 15)
d <- length(dt[dt > 125]) / n * 100

### 1.7.13
M <- 100
sd <- 15
z1 <- (125 - M) / 15

n <- 10000
dt <- rnorm(n, mean = 100, sd = 15)
d <- length(dt[dt > 70 & dt < 112]) / n * 100

### 1.8.7
x_hat <- 10
D <- 4
n <- 100
se <- sqrt(D/n)

### 1.9.2
x <- c(102, 91, 99, 100, 103, 98, 99, 101, 106, 88, 103, 97, 103, 101,
       101, 91, 104, 105, 105, 100, 101, 91, 99, 98, 107, 102, 100, 97,
       98, 104, 100, 98, 103, 99, 95, 103, 104, 97, 99, 102, 98, 107, 101,
       93, 98, 101, 93, 91, 107, 102, 96, 93, 100, 105, 103, 107, 99, 102,
       106, 102, 94, 104, 103, 103)
summary(x)
sd(x)
se <- sd(x) / sqrt(length(x))
doverit_int <- c(mean(x) - 1.96 * se, mean(x) + 1.96 * se)

### 1.9.8
x_hat <- 10
sd <- 5
n <- 100
doverit_int <- c(x_hat - 2.58 * sd / sqrt(n), x_hat + 2.58 * sd / sqrt(n))
