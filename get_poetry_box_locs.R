
library(tidyverse)
library(googlesheets4)
poetry_locs <- st_read("https://poetrybox.info/poetry-boxes150301.geojson")

poetry_locs %>% arrange(submittedDate) %>% write.csv("trotter_boxes.csv")
 read_csv("trotter_boxes.csv")
 
write_sheet(st_drop_geometry(poetry_locs), "https://docs.google.com/spreadsheets/d/1aeXAja0M0s7ZNB7eLedvgWtjP32i0MZkA6nOaGjzh6w/edit?usp=sharing")

            