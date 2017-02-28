# ******************************************************************************
# Загрузка данных из оборотки
install.packages("lubridate")
library(readxl)
library(dplyr)
library(zoo) # для na.locf - заменяет все следующик NA последним не NA

# detach(package:dplyr) # отключение пакета

# путь до файла
path_to_file <- file.path("оборотки", "Дальневосточный_рег_201701_ЛС.xlsx")

# читаем весь лист
dt_tmp <- read_excel(path = path_to_file, sheet = 1, col_names = F)

# формируем массив данных
dt <- dt_tmp[-(1:9),] # убираем заголовки и все остальное
names(dt) <- names_tmp <- paste0("col_", dt_tmp[9,]) # добавляем заголовок

patt_type <- c("Прочие потребители",
               "Министерство обороны",
               "Компенсация потерь")
summ_type <- c("ИТОГО", "ВСЕГО")

# вектор T/F только для числовые значения
digit_row <- grepl(pattern = "[[:digit:]]", dt$col_1)
# вектор T/F только для типа (прочка, МО, потери)
type_row <- grepl(paste(patt_type, collapse = "|"), dt$col_1)
# вектор T/F для всяких итого/всего
summ_row <- grepl(paste(summ_type, collapse = "|"), dt$col_1)

dt$filial <- dt_tmp$X0[[1]] # филиал (ячейку дф -> в значение)
dt$date <- dt_tmp$X8[[2]] # дата оборотки (ячейку дф -> в значение)
dt$otdelenie <- dt$col_1
# оставляем только отделение/регион
dt$otdelenie[type_row | digit_row | summ_row] <- NA
# оставляем только цифровые значения
dt$col_1[!digit_row] <- NA

# переносим столбцы в самое начало
dt <- dt[c("filial", "otdelenie", "date", names_tmp)]

dt <- dt %>% 
  mutate(otdelenie = na.locf(otdelenie)) %>% 
  filter(col_1 != "NA")

# удаляем всякое ненужное
rm(dt_tmp, names_tmp, digit_row, type_row, summ_row)

View(dt)




# ДОДЕЛАТЬ распознавание даты
# dmy(date_obo) # не работает, разобраться позже

fil <- c("Центральный", 
         "Северо-Западный",
         "Южный",
         "Уральский", 
         "Дальневосточный")

# cat(obo_filial)
#*******************************************************************************
# Выгрузка договоров РД с сайта АТС
install.packages("XML")
library(XML)

url_ <- "http://www.oes.su/upload/"
url_f <- "http://www.oes.su/upload/copy_prilozhenie_16_fas.pdf"




# Пример сохраннения файла
download.file(url_f, "Приложение.pdf", method = "internal")

#******************
install.packages("rvest")
library(rvest)

url_1 <-"http://www.perfectgame.org/"              
url_2 <-"https://www.yandex.ru"                    
url_3 <-"https://protected.atsenergo.ru/reports/" 
pgsession <- html_session(url_2)                   ## create session
pgform <- html_form(pgsession)[[2]]                ## pull form from session

filled_form <- set_values(pgform, `text` = "rstudio")
pgsession_get <- submit_form(pgsession, filled_form)



pgsession_get$url %>% 
  read_html() %>% 
  html_node("a") #%>% 
  xml_attr("href")

# httr::GET(url_3)
