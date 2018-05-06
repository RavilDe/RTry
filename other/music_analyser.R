library(dplyr)
library(stringr)

files_path <- dir("~/Music/iTunes/iTunes Media/Music", full.names = T, recursive = T)
# files_path <- dir("~/Music/iTunes/iTunes Media/Music", recursive = T)


db <- bind_cols(
  tibble(file_path = row.names(file.info(files_path))), 
  file.info(files_path)
) %>% 
  select(1:2) %>% 
  mutate(size_h = size / (1024^2)) %>% 
  mutate(file_path = gsub("/Users/macmini/Music/iTunes/iTunes Media/Music/", "", file_path)) %>% 
  mutate(type = str_extract(file_path, "\\.[[:alnum:]]{1,}$"))


db %>% 
  group_by(type) %>% 
  summarise(count = n(), sum_size = sum(size_h, na.rm = T))
