#### PACKAGE ####


library("tidyverse")
library("lubridate")


#### TRANSFORMATION ####


norrdata <- do.call(rbind.data.frame, norrkoping$matchningslista$matchningdata) %>%
  as.tibble()


sthlmdata <- do.call(rbind.data.frame, stockholm$matchningslista$matchningdata) %>%
  as.tibble()


api_df <- bind_rows(norrdata, sthlmdata) %>% 
  select(
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
                                           start = 1L, end = 10L))) %>%
  filter(yrkesbenamning == "Statistiker")
