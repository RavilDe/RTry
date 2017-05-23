# Мастецкий, Шитиков

?help.start

installed.packages(priority = "base") # базовые пакеты
installed.packages(priority = "recommended") # базовые пакеты

# копируем в буфер обмена список пакетов
packlist <- rownames(installed.packages())
write.table(packlist, "clipboard", sep = "\t", col.names = NA)

args(write.csv) # выводит аргументы функции

# ввод функции без скобок приводит к выводу исходного текста функции 
args 
sin
IQR

# вывод всех методов этой функции
methods("predict")
methods("as")
methods("plot")
methods("print")
methods("is")

### Описание языка R
# 2.2 векторы и матрицы

my.vector <- c(1, 2, 3, 4, 5); my.vector
# c - от слова concatenate (объединять, связывать)

X <- scan() # считывает вводимые последовательно с клавиатуры значения

s <- seq(from = 1, to = 7); s # от слова sequence (последовательность)
s <- 1:7; s
s <- seq(1, 5, by = 0.5); s # с шагом 0,5

text <- rep("test", 5); text # от repeat

v1 <- c(1, 2, 3)
v2 <- c(4, 5, 6)
v <- c(v1, v2); v
text_vect <- c("a", "b", "c"); text_vect
new_vect <- c(v1, text_vect)
mode(new_vect) # typeof :)

z <- c(0.5, 0.6, 0.3); z
sort(z) # по умолчанию decreasing = FALSE
sort(z, decreasing = TRUE)

# Матрицы
mmm <- matrix(1:16, nrow = 4, ncol = 4); mmm
mmm <- matrix(1:16, 4, 4); mmm
mmm <- matrix(1:16, 4, 4, byrow = T); mmm

rownames(mmm) <- c("A", "B", "C", "D")

mm <- matrix(1:12, 4, 4, byrow = T); mm # recycling в действии

m <- 1:16
dim(m) <- c(4, 4); m # если вектору задать размернось 4х4, то он станет матрицей
dim(m)


a <- c(1, 2, 3, 4)
b <- c(5, 6, 7, 8)
d <- c(9, 10, 11, 12)
e <- c(13, 14, 15, 16)
cbind(a, b, d, e) # складываем вектора как столбцы
rbind(a, b, d, e) # складываем вектора как строки
cbind(a, b, d, e) - t(cbind(a, b, d, e)) # t - транспонирование

