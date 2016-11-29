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