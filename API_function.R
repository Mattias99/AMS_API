library(httr)
library(jsonlite) #fromJSON
library(xml2)
library(lintr)

url <- "http://api.arbetsformedlingen.se/af/v0/platsannonser/matchning"

AMS_API <- function(q){
  url <- modify_url(url = url,
                    query = q)
  resp <- httr::GET(url)
  #fromJSON(content(resp, "text"), simplifyVector = FALSE)
  resp
}


# Query list object
vardyrke <- AMS_API(q = list(
  lanid = 05,
  kommunid = 0581,
  yrkesid = 5321,
  nyckelord = "test"
))




#vardYrkejson <- fromJSON(vardYrke) # Transform json object to list object

status_code(vardyrke)
#headers(vardYrke)
content(vardyrke, type = "application/xml")
content(vardyrke, as = "text")


# EX
# [url]/platsannonser/matchning?lanid={M}&kommunid={M}& yrkesid={M}&
# nyckelord ={M}&sida={V}&antalrader={V}


GET("http://api.arbetsformedlingen.se/af/v0/platsannonser/matchning",
    query = list(lanid = 05,
                 kommunid = 0581,
                 yrkesid = 5321))
