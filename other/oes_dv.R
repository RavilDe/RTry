# Раскладываем по папкам Дальниц восток

library(readxl)
library(dplyr)

# путь к файлу с таблицей
path <- "~/Desktop/свод СФ.xlsx"

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
path_files <- dir(path = "~/Desktop/ДВ для отправки", full.names = T)

# создаем папки с именами из покупателя и номера договора
for (i in 1:nrow(df)) {
  new_dir <- paste0("~/Desktop/ДВ по папкам/", df$buyer[i], " ", df$contract[i])
  dir.create(new_dir)
}

# раскладываем по этим папкам сф и апп
# по частям ибо, если запулить все - комп вешается наглухо!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
for (i in 1:nrow(df)) {
  new_dir <- paste0("~/Desktop/ДВ по папкам/", df$buyer[i], " ", df$contract[i])
  file.copy(from = paste0("~/Desktop/ДВ для отправки/", df$bill[i], "_", df$id_bill[i],".xlsx"),
            to = paste0(new_dir,"/" ,df$bill[i], "_", df$id_bill[i], ".xlsx")
  )
  file.copy(from = paste0("~/Desktop/ДВ для отправки/", df$app[i], "_", df$id_app[i],".xlsx"),
            to = paste0(new_dir,"/" ,df$app[i], "_", df$id_app[i], ".xlsx")
  )
}
