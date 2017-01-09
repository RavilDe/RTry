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



