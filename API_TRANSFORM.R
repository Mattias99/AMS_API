#### PACKAGE ####


library("tidyverse")
library("lubridate")


#### TRANSFORMATION ####



job_meta <- bind_rows(
  norrkoping$matchningslista$matchningdata,
  stockholm$matchningslista$matchningdata,
  katrineholm$matchningslista$matchningdata,
  nykoping$matchningslista$matchningdata
) %>%
  select(
    annonsid,
    annonsrubrik,
    yrkesbenamning,
    yrkesbenamningId,
    arbetsplatsnamn,
    kommunnamn,
    lan,
    publiceraddatum,
    sista_ansokningsdag
  ) %>%
  filter(yrkesbenamning == "Statistiker") %>%
  mutate(publiceraddatum   = ymd(str_sub(
    publiceraddatum,
    start = 1L, end = 10L
  )),
  sista_ansokningsdag = ymd(str_sub(
    sista_ansokningsdag,
    start = 1L, end = 10L
  )))

#### FULL JOB ADS ####
#
# Resource:
#   https://jennybc.github.io/purrr-tutorial/ls13_list-columns.html
#
job_full <- map(job_meta$annonsid, ams_query_text) %>%
  flatten()

# Extract a single variable the correct way
job_adress <- job_full %>%
  map("arbetsplats") %>%
  map_chr("besoksadress")

job_adress <- job_full %>%
  map("arbetsplats") %>%
  map_chr("land")

# Attempt to create all variables in the same process
job_all <- job_full %>% 
  mutate(
    land   = map("arbetsplats") %>% map_chr("land"),
    adress = map("arbetsplats") %>% map_chr("besoksadress") 
  )
