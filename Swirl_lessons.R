##### R Programming
### 1
### Basic Building Blocks

5 + 7
x <- 5 + 7
x
y <- x - 3
y
z <- c(1.1, 9, 3.14) # с - combine, concatinate
?c
z

c(z, 555, z)
z * 2 + 100

# sqrt - square root
my_sqrt <- sqrt(z-1)
my_sqrt

my_div <- z / my_sqrt
my_div

# recycling
c(1, 2, 3, 4) + c(0, 10) # recycling в действии
c(1, 2, 3, 4) + c(0, 10, 100) # выдаст предупреждение, но выполнит расчет

### 2
### Workspace and Files

getwd() # рабочая директория
ls() # список переменных в окружении
args() # список аргументов функции

list.files() # список файлов в рабочей директории
dir() # то же самое

args(list.files)

old.dir <- getwd() # сохраняем в переменную путь к старой рабочей директории

dir.create("testdir") # создаем в рабочей директории новую папку
setwd("testdir") # задает новую рабочую директорию

file.create("mytest.R") #  создаем новый файл 
file.exists("mytest.R") # проверка существования файла
file.info("mytest.R") # информация о файле; выводит таблицу! поэтому к ней можно обращаться напримерк file.info("mytest.R")$mode 

file.rename("mytest.R", "mytest2.R")# переименовываем файл
file.copy("mytest2.R", "mytest3.R") # копируем файл
file.path("mytest3.R") # с помощью этой функции можно составлять пути к файлам вне зависимости от операционки
file.path("folder1", "folder2")
dir.create(file.path("testdir2","testdir3"), recursive = TRUE)

setwd(old.dir) # переходим в старую директорию
unlink("testdir", recursive = TRUE) # удаляем все что насоздовали

### 3
### Sequences of Numbers

1:20 # вектор от 1 до 20 с шагом 1 
pi:10 # очень интересный пример! начинаем с 3,14 с шагом 1 до 10
15:1 # вектор с обратным отсчетом - от 15 до 1

seq(1, 20) # то же самое, что и 1:20
seq(0, 10 , by = 0.5) # с шагом 0,5
my_seq <- seq(5, 10, length = 30) # не знае мшаг, но знаем на сколько частей нужно раздробить
length(my_seq) # длинна полученного вектора

1:length(my_seq) # от одного до длинны вектора 
seq(along.with = my_seq) # то же самое, но по-другому
seq_along(my_seq) # отдельная функция

rep(0, times = 40)
rep(c(0, 1, 2), times = 10)
rep(c(0, 1, 2), each = 10)


### 4
### Vectors
num_vect <- c(0.5, 55, -10, 6)
tf <- num_vect < 1
tf
num_vect >= 6

# The `<` and `>=` symbols in these examples are called 'logical operators'. 
# Other logical operators include `>`, `<=`, `==` for exact equality, and
# `!=` for inequality.

# If we have two logical expressions, A and B, we can ask whether at least one is TRUE with A | B (logical 'or' a.k.a. 'union') 
# or whether they are| both TRUE with A & B (logical 'and' a.k.a. 'intersection'). 
# Lastly, !A is the negation of A and is TRUE when A is FALSE and vice versa.

my_char <- c("My", "name", "is")
paste(my_char, collapse = " ")
my_name <- c(my_char, "Eugene")
paste(my_name, collapse = " ")
paste("Hello", "world!", sep = " ")

paste(1:3, c("X", "Y", "Z"), sep = "")
paste(LETTERS, 1:4, sep = "-")

### 5
### Missing Values
x <- c(44, NA, 5, NA)
x * 3
y <- rnorm(1000) # 1000 рандомных чисел
z <- rep(NA, 1000) # 1000 NA-шек
my_data <- sample(c(y, z), 100) # случайная выборка 100 чисел из 2000 смешанных чисел и NAшек
my_na <- is.na(my_data)
my_na # получаем смесь из 100 TRUE и FALSE

my_data == NA # в ответ получаем 100 NA
# The reason you got a vector of all NAs is that NA is not really a value, but just a placeholder for a quantity that is not available.
# Therefore the logical expression is incomplete and R has no choice but to return a vector of the same length as my_data that contains all NAs.

sum(my_na)
my_data

0/0
Inf - Inf
### 6
### Subsetting Vectors

x
x[is.na(x)] # выводит вектор со всеми NA
y <- x[!is.na(x)] # выводит вектор со НЕ NA 
y
y[y > 0] # векторвсех положительных чисел в векторе Y
x[x > 0] # выводит все положительные НО с NA
x[!is.na(x) & x > 0] # а вот это уже выдаст то что мы хотели

x[c(3, 5, 7)]
x[0]
x[3000]

x[c(-2, -10)]
x[-c(2, 10)] # тоже самое и еороче

# именованые вектора
vect <- c(foo = 11, bar = 2, norf = NA)
vect
names(vect)
vect2 <- c(11, 2, NA)
names(vect2) <- c("foo", "bar", "norf")
identical(vect, vect2)

vect["bar"]
vect[c("foo", "bar")]

### 7
### Matrices and Data Frames

my_vector <- 1:20
my_vector
dim(my_vector) # т.к. это пока вектор, у него нет dimensions
length(my_vector) # а вот длина есть
dim(my_vector) <- c(4, 5)
dim(my_vector) # оп! появилась матрица; мы присвоиили атрибуту dim нашего вектора размерность 4х5 и вектор преобразовался в матрицу
attributes(my_vector)
my_vector
class(my_vector) # выдает нам класс объекта

my_matrix <- my_vector
my_matrix2 <- matrix(1:20, nrow = 4, ncol = 5) 
identical(my_matrix, my_matrix2)

patients <- c("Bill", "Gina", "Kelly", "Sean")
cbind(patients, my_matrix)

my_data <- data.frame(patients, my_matrix)
my_data
class(my_data)

cnames <- c("patient", "age", "weight", "bp", "rating", "test")
colnames(my_data) <- cnames
my_data
