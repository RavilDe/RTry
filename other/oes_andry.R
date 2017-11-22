# Раскладываем по папкам Центральный

library(readxl)
library(dplyr)

# путь к файлу с таблицей

path <- "~/Desktop/Опт 2кв16.xls"

# загружаем таблицу в гряззном варианте
df_raw <- read_excel(
  path, 
  sheet = 2,
  col_names = F
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
  slice(-1) %>% 
  transmute(
    folder_inn = X__6 %>% cleaner(),
    folder_dog = X__18 %>% cleaner()
  ) %>% 
  distinct()


# создаем папки с именами из ИНН
fold_inn <- df$folder_inn %>% unique()

for (i in seq_along(fold_inn)) {
  new_dir <- paste0("~/Desktop/По папкам/", fold_inn[i])
  dir.create(new_dir)
}

# создаем в папках ИНН подпапки  с именами из номера договора
for (i in 1:nrow(df)) {
  new_dir <- paste0("~/Desktop/По папкам/", df$folder_inn[i], "/", df$folder_dog[i])
  dir.create(new_dir)
}



# 
# # раскладываем по этим папкам сф и апп
# for (i in 1:nrow(df)) {
#   new_dir <- paste0("~/Desktop/ЦФ по папкам/", df$folder_inn[i], "/", df$folder_dog[i])
#   
#   bill_name <- dir(
#     "~/Desktop/ЦФ файлы/",
#     pattern = paste0(".*_", df$id_bill[i], ".xlsx$"),
#     full.names = T
#   )
#   
#   app_name <- dir(
#     "~/Desktop/ЦФ файлы/",
#     pattern = paste0(".*_", df$id_app[i], ".xlsx$"),
#     full.names = T
#   )
#   
#   file.copy(from = bill_name,
#             to = paste0(new_dir, "/", df$bill[i], "_", df$id_bill[i], ".xlsx")
#   )
#   file.copy(from = app_name,
#             to = paste0(new_dir, "/", df$app[i], "_", df$id_app[i], ".xlsx")
#   )
# }
# 
# path_files_xlsx <- dir(path = "~/Desktop/ЦФ по папкам",
#                        pattern = ".*\\.xlsx",
#                        recursive = T) %>% 
#   as_data_frame() %>% 
#   separate(value, into = c("inn","dogovor","filename"), sep = "/")
# 
# write.xlsx(
#   path_files_xlsx,
#   "~/Desktop/Список файлов Центр.xlsx"
# )





