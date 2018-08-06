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

word_tech <- c(" r ","sas", "spss", "excel", " git ", "sql", "mysql",
               "machine learning", "data mining", "ssis", "ssas", 
               "ssrs", " bi ", "business intelligence", "microsoft bi",
               "etl ", "'databas", "database", "nosql", "tensorflow",
               "github", "power bi", "regression", "classification",
               "clustering", "natural language", "neural network",
               "models", "algorithms")

word_profession <- c("statistiker", "data scientist", "business analyst",
                     "data analyst", "data engineer", "data scientist",
                     "data scientist/ml engineer", "marketing analyst",
                     "bi-analytiker")

word_profile <- c("data driven", "analyse", "data science", "time series",
                  "statistics", "statistik", "data", "university",
                  "universitet", "matematik", "fraud", "statistiska")


word_count <- str_extract(string = job_all$text[2],
                          pattern = coll(c(word_tech,
                                           word_profession,
                                           word_profile),
                                         ignore_case = TRUE))


word_count
length(na.omit(word(word_count)))
