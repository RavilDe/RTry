# Раскладываем по папкам Урал

library(readxl)
library(dplyr)

# путь к файлу с таблицей
path <- "~/Desktop/Уральский свод СФ.xlsx" # mac

# загружаем таблицу в гряззном варианте
df_raw <- read_excel(path, 
           sheet = "ВОТ"
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
            folder_dog = `Договор` %>% cleaner(),
            bill = `Номер СФ` %>% cleaner(),
            app = `Номер Акта` %>% cleaner(),
            id_bill = `ид сф`,
            id_app = `ид апп`)

# путь к папке с файлами
path_files <- dir(path = "~/Desktop/OES_output", full.names = T)

# создаем папки с именами из ИНН
fold_inn <- df$folder_inn %>% unique()

for (i in seq_along(fold_inn)) {
  new_dir <- paste0("~/Desktop/Урал по папкам/", fold_inn[i])
  dir.create(new_dir)
}

# создаем в папках ИНН подпапки  с именами из номера договора
for (i in 1:nrow(df)) {
  new_dir <- paste0("~/Desktop/Урал по папкам/", df$folder_inn[i], "/", df$folder_dog[i])
  dir.create(new_dir)
}

# раскладываем по этим папкам сф и апп
for (i in 1:nrow(df)) {
  new_dir <- paste0("~/Desktop/Урал по папкам/", df$folder_inn[i], "/", df$folder_dog[i])
  
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
