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

job_full <- map(api_df$annonsid, ams_query_text) %>%
  flatten()


job_adress <- job_full %>%
  map("arbetsplats") %>%
  map_chr("besoksadress")


job_full %>% map_chr(c("arbetsplats", "besoksadress"))