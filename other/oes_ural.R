# Раскладываем по папкам Урал

library(readxl)
library(dplyr)

# путь к файлу с таблицей
path <- "~/Desktop/Уральский свод СФ.xlsx" # mac

# загружаем таблицу в гряззном варианте
df_raw <- read_excel(path, 
           sheet = "Для папок"
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
  transmute(folder_name = `Название папки` %>% cleaner(),
            bill = `Номер СФ` %>% cleaner(),
            app = `Номер Акта` %>% cleaner(),
            id_bill = `id сф`,
            id_app = X__2)
df %>% 
  select(folder_name) %>%
  unique()


a <- df %>% 
  select(1, 3, 4, 2, 5)

# путь к папке с файлами
path_files <- dir(path = "~/Desktop/OES_output", full.names = T)

# создаем папки с именами из покупателя и номера договора
for (i in 1:nrow(df)) {
  new_dir <- paste0("~/Desktop/Урал по папкам/", df$folder_name[i])
  dir.create(new_dir)
}

# раскладываем по этим папкам сф и апп
for (i in 1:nrow(df)) {
  new_dir <- paste0("~/Desktop/Урал по папкам/", df$folder_name[i])
  
  file.copy(from = paste0("~/Desktop/OES_output/", df$bill[i], "_", df$id_bill[i],".xlsx"),
            to = paste0(new_dir, "/", df$bill[i], "_", df$id_bill[i], ".xlsx")
  )
  
  file.copy(from = paste0("~/Desktop/OES_output/", df$app[i], "_", df$id_app[i],".xlsx"),
            to = paste0(new_dir, "/", df$app[i], "_", df$id_app[i], ".xlsx")
  )
}

path_files_xlsx <- dir(path = "~/Desktop/Урал по папкам",
                      pattern = ".*\\.xlsx",
                      recursive = T)
                      
path_files_folders <- dir(path = "~/Desktop/Урал по папкам")
