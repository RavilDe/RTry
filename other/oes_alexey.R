library(dplyr)
library(tidyr)
library(readxl)
library(openxlsx)

df_reestr <- read_excel(
  path = "~/Desktop/свести.xlsx",
  sheet = 1,
  col_names = c("inn", "dog", "number", "value"),
  col_types = c("text", "text", "text", "numeric")
) %>% 
  slice(-1)

df_kp <- read_excel(
  path = "~/Desktop/свести.xlsx",
  sheet = 2,
  col_names = c("inn", "num_bill", "value"),
  col_types = c("text", "text", "numeric")
) %>% 
  slice(-1)

######################
# КП
######################

# вектор с дубликатами в паре ИНН - Деньги
kp_dup <- df_kp %>% 
  select(inn, value) %>% 
  duplicated()

# уникальный КП  
df_kp_uniq <- df_kp %>% 
  filter(!kp_dup)

# КП для разнесения вручную
df_kp_dup <- df_kp %>% 
  filter(kp_dup)

######################
# Реестр
######################

# вектор с дубликатами в паре ИНН - Деньги
reestr_dup <- df_reestr %>% 
  select(inn, value) %>% 
  duplicated()

# уникальный Реестр  
df_reestr_uniq <- df_reestr %>% 
  filter(!reestr_dup)

# Реестр для разнесения вручную
df_reestr_dup <- df_reestr %>% 
  filter(reestr_dup)

df_join <- left_join(df_kp_uniq, df_reestr_uniq, by = c("inn", "value"))

# не найденные значения при левом джоине df_kp_uniq - df_reestr_uniq
df_join_rest <- df_join %>% 
  filter(is.na(dog))

# готовый дата-фрейм
df_join <- df_join %>% 
  filter(!is.na(dog))



path_files <- dir(
  path = "~/Desktop/СФ"
)

# создаем папки с именами из ИНН
fold_inn <- df_join$inn %>% unique()

for (i in seq_along(fold_inn)) {
  new_dir <- paste0("~/Desktop/По папкам СФ/", fold_inn[i])
  dir.create(new_dir)
}

# создаем в папках ИНН подпапки  с именами из номера договора
for (i in 1:nrow(df_join)) {
  new_dir <- paste0("~/Desktop/По папкам СФ/", df_join$inn[i], "/", df_join$dog[i])
  dir.create(new_dir)
}


# раскладываем по этим папкам сф
for (i in 1:nrow(df_join)) {
  new_dir <- paste0("~/Desktop/По папкам СФ/", df_join$inn[i], "/", df_join$dog[i])

  bill_name <- dir(
    "~/Desktop/СФ/",
    pattern = paste0(df_join$inn[i], "_", df_join$num_bill[i] , "_СФ.pdf$"),
    full.names = T
  )

  file.copy(from = bill_name,
            to = paste0(new_dir, "/", df_join$inn[i], "_", df_join$num_bill[i] , "_СФ.pdf")
  )
}


path_files_xlsx <- dir(path = "~/Desktop/По папкам СФ",
                       pattern = ".*\\.pdf",
                       recursive = T) %>%
  as_data_frame() %>%
  separate(value, into = c("inn","dogovor","filename"), sep = "/")

write.xlsx(
  path_files_xlsx,
  "~/Desktop/Список разнесенных файлов.xlsx"
)


df_not_raznos <- right_join(
  path_files_xlsx, 
  as_tibble(path_files), 
  by = c("filename" = "value")
) %>% 
  filter(is.na(inn))

write.xlsx(
  df_not_raznos,
  "~/Desktop/Не разнеслось.xlsx"
)

