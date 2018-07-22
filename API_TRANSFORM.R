#### PACKAGE ####


library("tidyverse")


#### TRANSFORMATION ####


testdat <- str_sub(test$publiceraddatum, start = 1L, end = 10L) %>% ymd()

df <- as.tibble(testdat)

api_df <- select(df,
                 annonsid,
                 annonsrubrik,
                 yrkesbenamning,
                 yrkesbenamningId, # Uppercase in recived data
                 arbetsplatsnamn,
                 kommunnamn,
                 lan,
                 publiceraddatum,
                 sista_ansokningsdag) %>%
  mutate(publiceraddatum = ymd(str_sub(publiceraddatum,
                                       start = 1L, end = 10L)),
         sista_ansokningsdag = ymd(str_sub(sista_ansokningsdag,
                                           start = 1L, end = 10L)))