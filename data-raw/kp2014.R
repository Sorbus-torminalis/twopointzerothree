## code to prepare `DATASET` dataset goes here
#Data from Keiser & Pruitt (2014) https://figshare.com/articles/Data_for_Keiser_and_Pruitt_2014_-_Behavioral_Ecology/11778552

library(tidyverse)

if(!fs::file_exists("data-raw/kp2014.xlsx")){
  download.file(
    url = "https://ndownloader.figshare.com/files/21495579", 
    destfile = "data-raw/kp2014.xlsx")
}

kp2014 <- readxl::read_excel(path = "data-raw/kp2014.xlsx", sheet = 1) %>% 
  select(-matches("^Attack \\d+$")) %>% 
  mutate(across(-c(`Singleton/Pair`, `Behavioral Types`, Treatment), as.numeric))

usethis::use_data(kp2014, overwrite = TRUE)
