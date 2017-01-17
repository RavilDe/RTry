#### Анализ данных в R. Часть 2
#### https://stepik.org/724 

#*******************************************************************************
### 1.2 Функции семейства apply. Часть 1
### 1.2.2

library(ggplot2)
data(diamonds) # загрузка (показ) данных в окружение в виде обещания
str(diamonds)  # обещание выполнено :)

# немного тренировки и проверки
i <- 1
diamonds[i, 8:10]
min(diamonds[i, 8:10])

# неправильный код ))
min_size <- c()
system.time({ for (i in 1:nrow(diamonds)) {
  min_size <- c(min_size, min(diamonds[i, 8:10]))
}
}) # почти 50 секунд на маке (при работающем FAH :)

head(min_size)

# вторая попытка
min_size <- numeric(nrow(diamonds))
system.time({ for (i in 1:nrow(diamonds)) {
  min_size[i] <- min(diamonds[i, 8:10])
}
}) # 21 секунда на маке (при работающем FAH :)

# а теперь быстрый вариант
system.time(min_size2 <- apply(diamonds[, 8:10], 1, min))
  # работаем только с 8-10 столбцами датафрейма
  # 1 - применяем функцию к строкам (2 - к столбцам)
  # min - применяемая функция
  ### расчет занял 0,414 секунды :)


