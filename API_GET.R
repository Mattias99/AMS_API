ams_api <- function(path, query, ...) {
  # Connection to AMS API
  #
  # Args:
  #   path: Link to Arbetsförmedlingens API
  #   query: Specify query as a list
  #
  # Returns:
  #   TODO(Mattias): Explain returned object
  url <- "http://api.arbetsformedlingen.se/"
  link <- httr::modify_url(url = url, query = query, path = path)
  print(link)
  response <- GET(url = link, add_headers("Accept-Language" = "sv"))
  print(response$headers[9])
  # Error handling
   if (response$headers[9] != "application/json;charset=utf-8") {
    stop("API did not return json", call. = FALSE)
  }
  jsonlite::fromJSON(content(response, "text"),
                     simplifyVector = FALSE)
}