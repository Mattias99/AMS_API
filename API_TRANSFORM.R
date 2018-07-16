# PACKAGE
#install.packages('tidyverse')
library(dplyr)
library(lubridate)
library(stringr)
library(tibble)
library(forcats)


#======================================
# TRANSFORMATION
#======================================


testDat <- str_sub(test$publiceraddatum, start = 1L, end = 10L) %>% ymd()

df <- as.tibble(test)

API_df <- 
  select(df,
         annonsid,
         annonsrubrik,
         yrkesbenamning,
         yrkesbenamningId,
         arbetsplatsnamn,
         kommunnamn,
         lan,
         publiceraddatum,
         sista_ansokningsdag) %>%
  mutate(publiceraddatum = ymd(str_sub(publiceraddatum, start = 1L, end = 10L)),
         sista_ansokningsdag = ymd(str_sub(sista_ansokningsdag, start = 1L, end = 10L)))