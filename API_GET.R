ams_api <- function(path, query, ...) {
  # Connection to AMS API
  #
  # Args:
  #   path: Link to Arbetsförmedlingens API
  #   query: Specify query as a list
  #
  # Returns:
  #   TODO: Explain returned object
  url <- "http://api.arbetsformedlingen.se/"
  link <- httr::modify_url(url = url, query = query, path = path)
  print(link)
  response <- GET(url = link, add_headers("Accept-Language" = "sv"))
  print(response$headers[9])
  # Error handliing
  if (!is.list(query)){
    stop("Invalid input")
  }
  # Error handling
   if (response$headers[9] != "application/json;charset=utf-8") {
    stop("API did not return json", call. = FALSE)
  }
  response <- jsonlite::fromJSON(content(response, "text"),
                                 simplifyVector = FALSE)
  return(response)
}

ams_stat <- ams_api(path = "af/v0/platsannonser/matchning",
                    query = list(nyckelord = "statistiker"))

ams_datascien <- ams_api(path = "af/v0/platsannonser/matchning",
                         query = list(nyckelord = "data scietist"))

ams_bi <- ams_api(path = "af/v0/platsannonser/matchning",
                  query = list(nyckelord = "business intelligence"))