# Раскладываем по папкам Дальниц восток

library(readxl)
library(dplyr)

# путь к файлу с таблицей
# path <- "~/Desktop/свод СФ.xlsx" # mac
path <- "~/Рабочий стол/свод СФ.xlsx" # ubuntu

# загружаем таблицу в гряззном варианте
df_raw <- read_excel(path, 
           sheet = 1
           # skip = 3
           )
# вычищаем строки от слэшей и прочей гадости
cleaner <- function(vec) {
  vec %>% 
    gsub(pattern = "/", replacement = "-") %>% 
    gsub(pattern = "\\?", replacement = "-") %>% 
    gsub(pattern = "\r", replacement = "") %>% 
    gsub(pattern = "\n", replacement = "")
}

# формируем нормальный дата-фрейм из грязного
df <- df_raw %>% 
  transmute(buyer = `Наименование покупателя` %>% cleaner(),
            bill = `№СФ` %>% cleaner(),
            app = `№АПП` %>% cleaner(),
            contract = `№ Договора` %>% cleaner(),
            id_bill,
            id_app)

# путь к папке с файлами
# path_files <- dir(path = "~/Desktop/ДВ для отправки", full.names = T)
path_files <- dir(path = "~/Рабочий стол/ДВ для отправки", full.names = T)

# создаем папки с именами из покупателя и номера договора
for (i in 1:nrow(df)) {
  # new_dir <- paste0("~/Desktop/ДВ по папкам/", df$buyer[i], " ", df$contract[i])
  new_dir <- paste0("~/Рабочий стол/ДВ по папкам/", df$buyer[i], " ", df$contract[i])
  dir.create(new_dir)
}

# раскладываем по этим папкам сф и апп
# по частям ибо, если запулить все - комп вешается наглухо!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# хм, а на убунте все моментально сработало
for (i in 1:nrow(df)) {
  # new_dir <- paste0("~/Desktop/ДВ по папкам/", df$buyer[1], " ", df$contract[1])
  new_dir <- paste0("~/Рабочий стол/ДВ по папкам/", df$buyer[1], " ", df$contract[1])
  # file.copy(from = paste0("~/Desktop/ДВ для отправки/", df$bill[1], "_", df$id_bill[1],".xlsx"),
  file.copy(from = paste0("~/Рабочий стол/ДВ для отправки/", df$bill[1], "_", df$id_bill[1],".xlsx"),
            to = paste0(new_dir,"/" ,df$bill[1], "_", df$id_bill[1], ".xlsx")
  )
  # file.copy(from = paste0("~/Desktop/ДВ для отправки/", df$app[i], "_", df$id_app[i],".xlsx"),
  file.copy(from = paste0("~/Рабочий стол/ДВ для отправки/", df$app[i], "_", df$id_app[i],".xlsx"),
            to = paste0(new_dir,"/" ,df$app[i], "_", df$id_app[i], ".xlsx")
  )
}
