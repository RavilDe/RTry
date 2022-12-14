#### Анализ даных в R
#### https://stepik.org/129

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
### 1.3 Работа с data frame
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
### 1.4 Элементы синтаксиса
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
### 1.5 Описательные статистики
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
### 1.6 Описательные статистики. ГРАФИКИ
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
gp1 <- ggplot(df, aes(x = am, y = hp, col = vs))+
  geom_boxplot()+
  ggtitle("Gross horsepower and engine type")
str(gp1)

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# ggplot сломался
packageurl <- "https://cran.rstudio.com/bin/macosx/mavericks/contrib/3.3/ggplot2_2.2.1.tgz"
install.packages(packageurl, repos = NULL)
# не помогло в этот раз( установил через Packages -> Install 
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

ggplot(df, aes(x = mpg, y = hp, col = vs, size = qsec)) + 
  geom_point()

# Модульность ggplot'a ; можно сохранить заготовку

my_plot2 <- ggplot(df, aes(x = mpg, y = hp, col = vs, size = qsec))
my_plot2 + geom_point()

# пример с githab'a ggplot'a
?mpg
ggplot(mpg, aes(displ, hwy, colour = class)) + 
  geom_point()
str(mpg)

### 1.6.5
str(airquality)
# для boxplot'а необходима факторная переменная для x
ggplot(airquality, aes(x = factor(airquality$Month), y = Ozone )) + 
  geom_boxplot()

# это было в предупреждении gglot'a
ggplot(airquality, aes(x = Month, y = Ozone, group = Month )) + 
  geom_boxplot()

# через простой boxplot
boxplot(Ozone ~ Month, airquality)

### 1.6.6
str(mtcars)
ggplot(mtcars, aes(x = mpg, y = disp, col = hp)) + 
  geom_point()


### 1.6.8
ggplot(iris, aes(x = Sepal.Length, 
                 y = Sepal.Width, 
                 col = Species, 
                 size = Petal.Length)) + 
  geom_point()

#*******************************************************************************
### 1.7 Сохранение результатов
### 1.7.2

df <- mtcars
str(df)

library(ggplot2)
library(psych)

mean_mpg <- mean(df$mpg)
descr_df <- describe(df[ , -c(8, 9)])


boxplot <- ggplot(df, aes(x = factor(am), y = disp))+
  geom_boxplot() + 
  xlab("Transmission")+
  ylab("Displacemrnt (cu.in.")+
  ggtitle("Box - plot")

oldwd <- getwd() # проверяем текущую рабочую директорию
list.files() # список файлов в рабочей директории
list.dirs(getwd(), recursive = F) # папки в рабочей директории

dir.create("Stepik 2 Analysis") # создаем в рабочей директории новую папку
unlink("Stepik 2 Analysis", recursive = TRUE) # удаляем папку (на попробовать)

setwd("Stepik 2 Analysis") # переходим в новую папку
getwd()

# сохранение таблиц
write.csv(df, "df-mtcars.csv")
write.csv(descr_df, "descr-df.csv")

# сохранение переменных
my_mean <- mean(10^6:10^8)
save(my_mean, file="my_mean.Rdata")

# загрузка ранее сохраненных переменных 
load("~/RTry_01/Stepik 2 Analysis/my_objects.RData")

#*******************************************************************************
### 2.1 Анализ номинативных данных
### 2.1.2
# Номинативные данные говорят к какому классу принадлежат наши наблюдения.

### 2.1.3
# Categorical data

oldwd <- getwd()
list.dirs(recursive = F)
setwd("Stepik 2 Analysis")
df <- read.csv("grants.csv")
setwd(oldwd)
rm(oldwd)

str(df)
summary(df)
sapply(df[,-c(2,4)], unique) # видно, что нужно переделать в фактор

# factor: lable vs level
df$status <- as.factor(df$status)
levels(df$status) <- c("Not funded", "Funded")
# или
df$status <- factor(df$status, labels = c("Not funded", "Funded"))


### 2.1.4
# Таблица 1-dimention
tb1 <- table(df$status)
dim(tb1)

# Таблица 2-dimention
tb2 <- table(df$status, df$field)
dim(tb2) 

tb2 <- table(status = df$status, field = df$field) # с именами полей

prop.table(tb2) # сумма = 1 по всем данным
prop.table(tb2, 1) # сумма = 1 по строкам
prop.table(tb2, 2) # сумма = 1 по столбцам

# Таблица 3-dimention
tb3 <- table(Year = df$years_in_uni, field = df$field, status = df$status)

### 2.1.5
HairEyeColor
str(HairEyeColor)
dim(HairEyeColor)

red_men <- prop.table(HairEyeColor[, "Blue", "Male" ] )[3]
# ответ из урока
prop.table(HairEyeColor[ , ,'Male'],2)['Red','Blue']

### 2.1.6
sum(HairEyeColor[,"Green","Female"]) # сумма зеленоглазых)

### 2.1.7
barplot(tb1)
barplot(tb2)
barplot(tb2, 
        legend.text = T, 
        args.legend = list(x = "topright"))

barplot(tb2, 
        legend.text = T, 
        args.legend = list(x = "topright"),
        beside = T)

mosaicplot(tb2)

### 2.1.8

library(ggplot2)
mydata <- as.data.frame(HairEyeColor)
str(mydata)
a <- subset(mydata, Sex == "Female")

obj <- ggplot(subset(mydata, Sex == "Female"), 
       aes(x =  Hair, y = Freq, fill = Eye))+
  geom_bar(stat = "identity", position = "dodge")+
  scale_fill_manual(values = c("Brown", "Blue", "Darkgrey", "Darkgreen"))

ggplot(mydata, aes(x =  Hair, y = Freq, fill = Eye))+
  geom_bar(stat = "identity", position = "dodge")+
  scale_fill_manual(values = c("Brown", "Blue", "Darkgrey", "Darkgreen"))

### 2.1.8
# Биномиальный тест
binom.test(x = 5, n = 20, p = 0.5)
binom.test(tb1)

### 2.1.9
# критерий хи-квадрат пирсона

chisq.test(tb1)
chi <- chisq.test(tb1)
chi$exp
tb2
chi <- chisq.test(tb2)

### 2.1.10
# точный критерий фишера
fisher.test(tb2)

### 2.1.11
chisq.test(HairEyeColor["Brown", ,"Female"])
str(HairEyeColor)

### 2.1.12
str(diamonds)
a <- table(diamonds$cut, diamonds$color)
main_stat <- chisq.test(a)$statistic

### 2.1.13
mean_pr <- mean(diamonds$price)
mean_cr <- mean(diamonds$carat)
factor_price <- factor(diamonds$price >= mean_pr)
factor_carat <- factor(diamonds$carat >= mean_cr)
a <- table(factor_carat, factor_price)
main_stat <- chisq.test(a)$statistic
str(chisq.test(a))

### 2.1.14
str(mtcars)
fisher_test <- fisher.test(table(mtcars$am, mtcars$vs))$p.value

#*******************************************************************************
### 2.2 Сравнение двух групп
### 2.2.2 - 2.2.4
library(ggplot2)
?iris
df <- iris
str(df)
df1 <- subset(df, Species != "setosa")
table(df1$Species)
hist(df1$Sepal.Length)

ggplot(df1, aes(x = Sepal.Length)) + 
  geom_histogram(binwidth = 0.4,
                 fill = "white", 
                 col = "black") + # fill - заливка, col - граница
  facet_grid(Species ~ .)

ggplot(df1, aes(Sepal.Length, fill = Species))+
  geom_density(alpha = 0.5)

ggplot(df1, aes(Species, Sepal.Length))+
  geom_boxplot()

### 2.2.5
shapiro.test(df1$Sepal.Length)
shapiro.test(df1$Sepal.Length[df1$Species == "versicolor"])
shapiro.test(df1$Sepal.Length[df1$Species == "virginica"])

bartlett.test(Sepal.Length ~ Species, df1)

### 2.2.6

tt <- t.test(Sepal.Length ~ Species, df1)
# количественную переменную (Sepal.Length) разбиваем на группы (Species) 
# в датасете (fd1)
str(tt)
tt$p.value

t.test(Sepal.Length ~ Species, df) # выдаст ошибку, т.к. группирующий фактор 
                                    # должен иметь строго два уровня
t.test(df1$Sepal.Length, mu = 8) # сравнение истинного среднего с мнимым (8)
mean(df1$Sepal.Length)
 
### 2.2.7
t.test(df1$Petal.Length, df1$Petal.Width, paired = T)

### 2.2.9
# t-Критерий Стьюдента для НЕзависимых выборок
t.test(Var1 ~ Var2, data) # если первая переменная количественная, 
                          # а вторая фактор
t.test(data$Var1, data$Var2) # если обе переменные количественные

# t-Критерий Стьюдента для зависимых выборок
t.test(data$Var1, data$Var2, paired = T)

# Проверка на нормальность распределения
shapiro.test(Var1) # проверка на нормальность распределения переменной Var1
# но не удобно когда есть группирующая факторная переменная

# Поможет функция by(), которая применяет различные функции на каждом 
                                                            # уровне фактора.  
# проверка на нормальность переменной 
by(iris$Sepal.Length, INDICES = iris$Species, shapiro.test) 

# Sepal.Length в трех разных группах в соответствии с переменной Species

# Проверка на гомогенность дисперсий
bartlett.test(mpg ~ am, mtcars) #Критерий Бартлетта 

### 2.2.10
str(ToothGrowth)
head(ToothGrowth)

tg1 <- subset(ToothGrowth, dose == 0.5 & supp == "OJ")
tg2 <- subset(ToothGrowth, dose == 2 & supp == "VC")
t_stat <- t.test(tg1$len, tg2$len)$statistic

# решение из проврки
correct_data <- subset(ToothGrowth, supp=='OJ' & dose==0.5 | supp=='VC' & dose==2)    
t_stat <- t.test(len ~ supp, correct_data)$statistic

### 2.2.11
# смотрим какие есть папки
list.dirs(getwd(), recursive = F)
#смотрим что есть в нужной папке
list.files("/Users/macmini/RTry_01/Stepik 2 Analysis")
# читаем нужный файл
dfdf <- read.csv("Stepik 2 Analysis/lekarstva.csv")
# подсмотрел в ответах
dfdf <- read.csv(url('https://stepic.org/media/attachments/lesson/11504/lekarstva.csv'))
str(dfdf)
table(dfdf$Group)

t.test(dfdf$Pressure_before, dfdf$Pressure_after, paired = T)

### 2.2.12
# визуализация 
library(ggplot2)
t.test(Sepal.Length ~ Species, df1)

ggplot(df1, aes(Species, Sepal.Length))+
  stat_summary(fun.data = mean_cl_normal, geom = "errorbar", width = 0.1)

# эту функцию можно использовать отдельно
mean_cl_normal(df1$Sepal.Length) # среднее и доверительные интервалы

### 2.2.13
# на предыдущем графике нет среднего значения, исправляем
ggplot(df1, aes(Species, Sepal.Length))+
  stat_summary(fun.data = mean_cl_normal, geom = "errorbar", width = 0.1)+
  stat_summary(fun.y = mean, geom = "point", size = 4)

ggplot(df1, aes(Species, Sepal.Length))+
  stat_summary(fun.data = mean_cl_normal, geom = "pointrange", size = 1)

### 2.2.14
# мало данных или не очень нормальное распределение?
# тошда t.test не подходит
# берем wilcox.test

length(ls(pos = "package:stats", pattern = ".*\\.test$")) # это все тесты

?wilcox.test
test2 <- wilcox.test(Petal.Length ~ Species, df1)
str(test2)

ggplot(df1, aes(Species, Petal.Length))+
  geom_boxplot()

wilcox.test(df1$Petal.Length, df1$Petal.Width, paired = T) # зависимые выборки
# V = 5050 - значение критерия
# p-value - p-уровень значимости; 
# т.к. p-value < 0,05 то гипотеза о равенстве характеристик не верна

### 2.2.15
list.dirs(getwd(), recursive = F)
df <- read.table("D:/Miheykin/Documents/RTry_01/Stepik 2 Analysis/dataset_11504_15.txt")
str(df)
table(df$V2)
#Критерий Бартлетта 
b_answ <- bartlett.test(V1 ~ V2, df)$p.value
print("Бартлет:")
print(b_answ)
if (b_answ >= 0.05) {
  t_answ <- t.test(V1 ~ V2, df, var.equal = TRUE)$p.value
  print("Стьюдент:")
} else {
  t_answ <- wilcox.test(V1 ~ V2, df)$p.value
  print("Вилкокс:")
}
print(round(t_answ, digits = 4))

### 2.2.16

df <- read.table("D:/Miheykin/Documents/RTry_01/Stepik 2 Analysis/dataset_11504_16.txt")
t_answ <- t.test(df$V1, df$V2)$p.value
if (t_answ >= 0.05) {
  print("The difference is not significant")
} else {
  print(c(mean(df$V1), mean(df$V2), t_answ))
}


#*******************************************************************************
### 2.3 Применение дисперсионного анализа
### 2.3.3
# Дисперсионный анализ - основной интсрумент, для сравнения нескольких групп

# DV - зависимая переменная
# IV - НЕзависимая переменая
# ~ - влияние 

DV ~ IV # one-way
DV ~ IV1 + IV2 # two-way

# влияние одной переменной на другую зависит от третьей
DV ~ IV1:IV2 # two way interaction
DV ~ IV1 + IV2 + IV1:IV2 # main effect + interaction
DV ~ IV1 * IV2 # the same; main effect + interaction
DV ~ IV1 + IV2 + IV3 + IV1:IV2
DV ~ (IV1 + IV2 + IV3)^2 # main effect + all possiple interactions 
DV ~ IV1 + Error(subject/IV1) # повтрный измерения

### 2.3.5

old_wd <- getwd()

df <- read.csv("Stepik 2 Analysis/shops.csv")
str(df)
table(df$food)

boxplot(price ~ origin, df)

ggplot(df, aes(origin, price))+
  geom_boxplot()

# one-way ANOVA
fit <- aov(price ~ origin, df)
str(fit)
summary(fit)

### 2.3.6

