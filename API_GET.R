# Connection to AMS API

#### PACKAGES ####
library(httr)
library(jsonlite)

#### API function ####

AMS_API <- function(path, q) {
  link <- modify_url(url = "http://api.arbetsformedlingen.se/", query = q, path = path)
  print(link)
  
  response <- GET(url = link,
      add_headers('Accept-Language' = 'sv'))
  
  print(response$headers[9])

  # if (response$headers[9] != "application/json;charset=utf-8") {
  #   stop("API did not return json", call. = FALSE)
  # }
  
  fromJSON(content(response, 'text'), simplifyVector = FALSE)
  
}

