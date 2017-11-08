# Раскладываем по папкам Северо-Запад

library(readxl)
library(dplyr)


# предподготовка файлов - удаляеем из имени  СФ строку с ИСПРАВЛЕНИЕМ

# bill_list <- dir(
#   path = "~/Desktop/Северо-западный Итог/OES_output/",
#   pattern = "^СЧЕТ",
#   full.names = T
# )
# 
# to_remome <- " ИСПРАВЛЕНИЕ № --- от --- г."
# 
# file.rename(
#   from = bill_list,
#   to = sub(to_remome, "", bill_list)
# )

# путь к файлу с таблицей

path <- "~/Desktop/Северо-западный Итог/СЗФ свод СФ.xlsx"

# загружаем таблицу в гряззном варианте
df_raw <- read_excel(path, sheet = "Лист4")

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
            bill = `№ СФ` %>% cleaner(),
            app = `№ АПП` %>% cleaner(),
            id_bill = `ИД СФ`,
            id_app = `ИД АПП`)

# путь к папке с файлами
path_files <- dir(path = "~/Desktop/Северо-западный Итог/OES_output/", full.names = T)
# path_files <- dir(path = "~/Desktop/Северо-Западный/", full.names = T)

# создаем папки с именами из ИНН
fold_inn <- df$folder_inn %>% unique()

for (i in seq_along(fold_inn)) {
  new_dir <- paste0("~/Desktop/СЗ по папкам/", fold_inn[i])
  dir.create(new_dir)
}

# создаем в папках ИНН подпапки  с именами из номера договора
for (i in 1:nrow(df)) {
  new_dir <- paste0("~/Desktop/СЗ по папкам/", df$folder_inn[i], "/", df$folder_dog[i])
  dir.create(new_dir)
}

# раскладываем по этим папкам сф и апп
for (i in 1:nrow(df)) {
  new_dir <- paste0("~/Desktop/СЗ по папкам/", df$folder_inn[i], "/", df$folder_dog[i])
  
  file.copy(from = paste0("~/Desktop/Северо-западный Итог/OES_output/", df$bill[i], "_", df$id_bill[i],".xlsx"),
            to = paste0(new_dir,"/" ,df$bill[i], "_", df$id_bill[i], ".xlsx")
  )
  file.copy(from = paste0("~/Desktop/Северо-западный Итог/OES_output/", df$app[i], "_", df$id_app[i],".xlsx"),
            to = paste0(new_dir,"/" ,df$app[i], "_", df$id_app[i], ".xlsx")
  )
}

path_files_xlsx <- dir(path = "~/Desktop/СЗ по папкам",
                       pattern = ".*\\.xlsx",
                       recursive = T) %>% 
  as_data_frame() %>% 
  separate(value, into = c("inn","dogovor","filename"), sep = "/")

write.xlsx(
  path_files_xlsx,
  "~/Desktop/СЗ по папкам/Список файлов.xlsx"
)





