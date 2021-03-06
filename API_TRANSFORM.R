#### TRANSFORMATION ####

ads <- function(ads_format){
  # Reformat list data into tidy data.
  #
  # Args:
  #   ads_format: List object from ams_api
  #
  # Returns:
  #   data.frame with ads from a specific query
  
  # Error handling
  if (is.null(ads_format$matchningslista$matchningdata)){
    stop("Zero ads")
  }
  
  job_meta <- bind_rows(
    ads_format$matchningslista$matchningdata
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
    mutate(publiceraddatum   = ymd(str_sub(
      publiceraddatum,
      start = 1L, end = 10L
    )),
    sista_ansokningsdag = ymd(str_sub(
      sista_ansokningsdag,
      start = 1L, end = 10L
    )))
  
  job_full <- map(job_meta$annonsid, ams_query_text) %>%
    flatten()
  
  
  job_all <- bind_cols(
    id        = job_full %>% map("annons") %>% map_chr("annonsid"),
    workplace = job_full %>% map("arbetsplats") %>% map_chr("arbetsplatsnamn"),
    title     = job_full %>% map("annons") %>% map_chr("annonsrubrik"),
    Work      = job_full %>% map("annons") %>% map_chr("yrkesbenamning"),
    text      = job_full %>% map("annons") %>% map_chr("annonstext"),
    web       = job_full %>% map("ansokan") %>% map_chr("webbplats"),
    address   = job_full %>% map("arbetsplats") %>% map_chr("besoksadress"),
    county    = job_full %>% map("arbetsplats") %>% map_chr("postort"),
    firstday  = job_full %>% map("annons") %>% map_chr("publiceraddatum"),
    lastday   = job_full %>% map("ansokan") %>% map_chr("sista_ansokningsdag")
  ) %>%
    mutate(firstday = ymd(str_sub(
      firstday,
      start = 1L, end = 10L
    )),
    lastday = ymd(str_sub(
      lastday,
      start = 1L, end = 10L
    )),
    shiny_menu = paste(id, title)
    )
  
  return(job_all)

}


ads(ams_stat)
ads(ams_datascien)
ads(ams_ams_bi)

ams_datascien$matchningslista$matchningdata

do.call(r.bind, list(ads(ams_stat),
                     ads(ams_datascien),
                     ads(ams_ams_bi)))

do.call(r.bind, )


#### KEYWORD SEARCH ####


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


word_count <- str_extract(string  = job_all$text[i],
                          pattern = coll(c(word_tech,word_profession,word_profile),
                                         ignore_case = TRUE)) %>% na.omit(c())