library(googlesheets)
library(dplyr)
library(tidyr)
library(stringr)


movie <- gs_title("Кино по заявкам")

gs_ws_ls(movie)

df_movie <- movie %>% 
  gs_read(ws = "movie") %>% 
  slice(-(184:187)) %>% 
  gather(- film, key = "player", value = "foo") %>% 
  mutate(
    foo = tolower(foo),
    foo = case_when(
      str_detect(foo, "^не помню ничего") ~ "не помню ничего",
      str_detect(foo, "ебанина") ~ "да",
      str_detect(foo, "^да") ~ "да",
      T ~ foo
    )
  )

df_movie %>% 
  group_by(foo) %>% 
  summarise(count = n()) %>% 
  arrange(-count)

df_movie$player %>% unique()

df_movie %>% 
  filter(!is.na(foo)) %>% 
  group_by(film) %>% 
  summarise(
    count_no = sum(foo == "нет"),
    count_x3 = sum(foo == "не помню ничего"),
    count_yes = sum(foo == "да")
  ) %>% 
  arrange(-count_no, -count_x3) %>% 
  filter(count_yes == 0)
  
options(tibble.min_count = Inf)
