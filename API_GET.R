# Connection to AMS API

#### PACKAGES ####


library(httr)
library(jsonlite)


#### API function ####


ams_api <- function(path, q) {
  url <- "http://api.arbetsformedlingen.se/"
  link <- httr::modify_url(url = url, query = q, path = path)
  print(link)
  response <- GET(url = link, add_headers("Accept-Language" = "sv"))
  print(response$headers[9])
   if (response$headers[9] != "application/json;charset=utf-8") {
    stop("API did not return json", call. = FALSE)
  }
  jsonlite::fromJSON(content(response, "text"),
                     simplifyVector = FALSE)
}