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


# Attempt nr. 2 to create all variables in the same process
job_all <- bind_cols(
  id        = job_full %>% map("annons") %>% map_chr("annonsid"),
  workplace = job_full %>% map("arbetsplats") %>% map_chr("arbetsplatsnamn"),
  title     = job_full %>% map("annons") %>% map_chr("annonsrubrik"),
  Work      = job_full %>% map("annons") %>% map_chr("yrkesbenamning"),
  text      = job_full %>% map("annons") %>% map_chr("annonstext"),
  web       = job_full %>% map("ansokan") %>% map_chr("webbplats"),
  adress    = job_full %>% map("arbetsplats") %>% map_chr("besoksadress"),
  county    = job_full %>% map("arbetsplats") %>% map_chr("postord")
  ) %>% 
  mutate(
    
  )



