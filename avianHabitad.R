#### Урок 2.2.9 практика

# importing and inspecting data
# avian <- read.csv("D:/Miheykin/Desktop/avianHabitat_sewardPeninsula_McNew_2012.csv")
options(stringsAsFactors = F) # изменения внесенный в уроке 2.3.11
avian <- read.csv("avianHabitat_sewardPeninsula_McNew_2012.csv") # т.к. все в одной директории, то не нужно писать полный путь
avian$Observer <- as.factor(avian$Observer) # изменения внесенный в уроке 2.3.11

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

# изменения внесенный в уроке 2.3.11
library(stringr) 
coverage_variables <- names(avian)[str_detect(names(avian), "^P")] # ^ - wildcard начало строки
sapply(coverage_variables, function(name) check_percent_range(avian[[name]])) # двойные квадратные скобки, т.к. нужен вектор!


# transforming variables
names(avian)
# coverage_variables <- names(avian)[-(1:4)][c(T,F)] # остекаем первые 4 имени столбцов и берем только первый из двух
avian$total_coverage <- rowSums(avian[, coverage_variables]) # создаем новую переменную(столбец) и заносим туда сумму по строке
summary(avian$total_coverage)

# изменения внесенный в уроке 2.3.11
# создаем новую переменную (фактор) для географических названий, заменяя в Site все цифры на пустую строку
avian$Site_name <- factor(str_replace(avian$Site, "[:digit:]+", ""))
# [:digit:] - любая цифра
# +         - повторенная несколько раз

tapply(avian$DBHt, avian$Site_name, mean)

