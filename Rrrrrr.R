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
c(nrow(m),ncol(m))
dim(m) <- NULL; m
dim(m) <- c(2,3); m

m1 <- matrix(1:4, nrow = 2)
m2 <- matrix(c(1,2,2,3), nrow = 2)
m1+m2
m1+5


