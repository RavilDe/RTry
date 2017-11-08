# Раскладываем по папкам Южный
library(readxl)
library(dplyr)

# путь к файлу с таблицей

path <- "~/Desktop/Южный свод СФ.xlsx"

# загружаем таблицу в гряззном варианте
df_raw <- read_excel(path, sheet = "Лист6", col_names = F)

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
  transmute(folder_inn = X__2 %>% cleaner(),
            folder_dog = X__8 %>% cleaner(),
            bill = X__4 %>% cleaner(),
            app = X__6 %>% cleaner(),
            id_bill = X__5,
            id_app = X__7)

# путь к папке с файлами
path_files <- dir(path = "~/Desktop/Южный переименованный/", full.names = T)

# создаем папки с именами из ИНН
fold_inn <- df$folder_inn %>% unique()

for (i in seq_along(fold_inn)) {
  new_dir <- paste0("~/Desktop/Юг по папкам/", fold_inn[i])
  dir.create(new_dir)
}

# создаем в папках ИНН подпапки  с именами из номера договора
for (i in 1:nrow(df)) {
  new_dir <- paste0("~/Desktop/Юг по папкам/", df$folder_inn[i], "/", df$folder_dog[i])
  dir.create(new_dir)
}

# раскладываем по этим папкам сф и апп
for (i in 1:nrow(df)) {
  new_dir <- paste0("~/Desktop/Юг по папкам/", df$folder_inn[i], "/", df$folder_dog[i])
  
  bill_name <- dir(
    "~/Desktop/Южный переименованный",
    pattern = paste0(".*_", df$id_bill[i], ".xlsx$"),
    full.names = T
  )
  
  app_name <- dir(
    "~/Desktop/Южный переименованный",
    pattern = paste0(".*_", df$id_app[i], ".xlsx$"),
    full.names = T
  )
  
  file.copy(from = bill_name,
            to = paste0(new_dir,"/" ,df$bill[i], "_", df$id_bill[i], ".xlsx")
  )
  file.copy(from = app_name,
            to = paste0(new_dir,"/" , df$app[i], "_", df$id_app[i], ".xlsx")
  )
}



path_files_xlsx <- dir(path = "~/Desktop/Юг по папкам",
                       pattern = ".*\\.xlsx",
                       recursive = T) %>% 
  as_data_frame() %>% 
  separate(value, into = c("inn","dogovor","filename"), sep = "/")

write.xlsx(
  path_files_xlsx,
  "~/Desktop/Юг по папкам/Список файлов.xlsx"
)





