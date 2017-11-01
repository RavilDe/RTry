# Раскладываем по папкам Дальниц восток

library(readxl)
library(dplyr)

# путь к файлу с таблицей
path <- "~/Desktop/Дальневосточный свод СФ.xlsx" # mac

# загружаем таблицу в гряззном варианте
df_raw <- read_excel(path, 
           sheet = "Лист1"
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
  transmute(folder_inn = `ИНН` %>% cleaner(),
            folder_dog = `№ Договора` %>% cleaner(),
            bill = `№СФ` %>% cleaner(),
            app = `№АПП` %>% cleaner(),
            id_bill = `ид сф`,
            id_app = `ид апп`)

# путь к папке с файлами
path_files <- dir(path = "~/Desktop/ДВ для отправки", full.names = T)

# создаем папки с именами из ИНН
fold_inn <- df$folder_inn %>% unique()

for (i in seq_along(fold_inn)) {
  new_dir <- paste0("~/Desktop/ДВ по папкам/", fold_inn[i])
  dir.create(new_dir)
}

# создаем в папках ИНН подпапки  с именами из номера договора
for (i in 1:nrow(df)) {
  new_dir <- paste0("~/Desktop/ДВ по папкам/", df$folder_inn[i], "/", df$folder_dog[i])
  dir.create(new_dir)
}

# раскладываем по этим папкам сф и апп
for (i in 1:nrow(df)) {
  new_dir <- paste0("~/Desktop/ДВ по папкам/", df$folder_inn[i], "/", df$folder_dog[i])
  file.copy(from = paste0("~/Desktop/ДВ для отправки/", df$bill[i], "_", df$id_bill[i],".xlsx"),
            to = paste0(new_dir,"/" ,df$bill[i], "_", df$id_bill[i], ".xlsx")
  )
  file.copy(from = paste0("~/Desktop/ДВ для отправки/", df$app[i], "_", df$id_app[i],".xlsx"),
            to = paste0(new_dir,"/" ,df$app[i], "_", df$id_app[i], ".xlsx")
  )
}

path_xlsx <- dir(
  "~/Desktop/ДВ по папкам/",
  pattern = "\\.xlsx",
  recursive = T
) %>% 
  basename() %>% 
  as_data_frame()

file_xlsx <- rbind(
  as_data_frame(paste0(df$bill, "_", df$id_bill, ".xlsx")),
  as_data_frame(paste0(df$app, "_", df$id_app, ".xlsx"))
)

a <- left_join(file_xlsx, path_xlsx)
b <- left_join(path_xlsx, file_xlsx)





