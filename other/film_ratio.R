library(readxl)
library(openxlsx)
library(dplyr)
library(stringr)

df <- read_excel("~/Desktop/фильмы.xlsx", col_types = "text", col_names = "film")

df_mod <- df %>% 
  mutate(
    film = tolower(film),
    film = str_remove(film, "^\\d*\\."),
    film = str_remove(film, "^\\s|^-\\s|\\s*$"),
    film = case_when(
      str_detect(film, "^властелин колец") ~ "властелин колец",
      str_detect(film, "^гордость и предубеждени") ~ "гордость и предубеждения",
      str_detect(film, "^kingsman") ~ "кингсмен",
      str_detect(film, "^мортал комбат") ~ "мортал комбат",
      str_detect(film, "^таинственный лес") ~ "таинственный лес",
      T ~ film
    )
  )
  

df_mod %>% 
  group_by(film) %>% 
  summarise(count = n()) %>% 
  arrange(-count) %>% 
  # arrange(film)
  write.xlsx("~/Desktop/films_rating.xlsx", asTable = T)
    

df_mod %>% arrange(film)

options(tibble.print_min = Inf)
