library(rio)
library(tidyverse)
library(here)

rio::import(here("data/Study_1/meta_survey_researchers_raw.csv")) %>%
  dplyr::filter(!is.na(submitdate) & !(id == 52)) %>% # remove empty rows and one duplicate
  mutate(dwellData = str_match(dwellData, '"name"":""(.*?)"",""')[, 2],
         id = 1:nrow(.)) %>%
  rio::export(here("data/Study_1/meta_survey_researchers_clean.csv"))

rio::import(here("data/Study_1/meta_survey_researchers_raw.sav")) %>%
  dplyr::filter(!is.na(submitdate)) %>%
  mutate(dwellData = str_match(dwellData, '"name":"(.*?)","')[, 2],
         id = 1:nrow(.)) %>%
  rio::export(here("data/Study_1/meta_survey_researchers_clean.sav"))
