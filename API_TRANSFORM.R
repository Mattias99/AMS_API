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
# Purrr-package resource:
#   https://jennybc.github.io/purrr-tutorial/ls13_list-columns.html
#

job_full <- map(job_meta$annonsid, ams_query_text) %>%
  flatten()


# Attempt nr. 2 to create all variables in the same process
job_all <- bind_cols(
  id        = job_full %>% map("annons") %>% map_chr("annonsid"),
  workplace = job_full %>% map("arbetsplats") %>% map_chr("arbetsplatsnamn"),
  title     = job_full %>% map("annons") %>% map_chr("annonsrubrik"),
  Work      = job_full %>% map("annons") %>% map_chr("yrkesbenamning"),
  text      = job_full %>% map("annons") %>% map_chr("annonstext"),
  web       = job_full %>% map("ansokan") %>% map_chr("webbplats"),
  address    = job_full %>% map("arbetsplats") %>% map_chr("besoksadress"),
  county    = job_full %>% map("arbetsplats") %>% map_chr("postort"),
  firstday  = job_full %>% map("annons") %>% map_chr("publiceraddatum"),
  lastday   = job_full %>% map("ansokan") %>% map_chr("sista_ansokningsdag")
  ) %>%
  mutate(firstday   = ymd(str_sub(
    firstday,
    start = 1L, end = 10L
  )),
  lastday = ymd(str_sub(
    lastday,
    start = 1L, end = 10L
  )))

#### Remove unused objects ####


rm(katrineholm, norrkoping, stockholm, nykoping, job_meta, job_full)


#### KEYWORD SEARCH ####

job_all$text[3]

word_tech <- c("R","SAS", "SPSS", "Excel", "git", "SQL", "MySQL",
               "Machine learning", "Data mining", "SSIS", "SSAS", 
               "SSRS", "BI", "Business Intelligence", "Microsoft BI",
               "ETL", "'databas", "database", "NoSQL", "TensorFlow",
               "GitHub", "Power BI", "regression", "classification",
               "clustering", "natural language", "neural network",
               "models", "algorithms")

word_profession <- c("Statistiker", "Data scientist", "Business Analyst",
                     "Data Analyst", "Data Engineer", "Data Scientist",
                     "Data Scientist/ML Engineer", "Marketing Analyst",
                     "Bi-analytiker")

word_profile <- c("data driven", "analyse", "data science", "Time series",
                  "Statistics", "statistik", "data", "university",
                  "universitet", "matematik", "Fraud")


str_extract(string = job_all$text[3],pattern = c(word_tech,
                                                 word_profession,
                                                 word_profile))
