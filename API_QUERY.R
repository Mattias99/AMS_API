#======================================
# QUERY DEFINITIONS:
#
# lanid 01 : Stockholm
# lanid 05 : Östergötland
# lanid 04 : Södermanland
#
# kommunid 0483 : Katrineholm
# kommunid 0480 : Nyköping
# kommunid 0181 : Södertälje
# kommunid 0180 : Stockholm 
#======================================

# Job ads, meta data

ams_query <- function(lan, kommun, text){
  response <- ams_api(path = "af/v0/platsannonser/matchning",
                      q = list(lanid = lan,
                               kommunid = kommun,
                               nyckelord = text))
  return(response)
}

# Job ads, text

ams_query_text <- function(id){
  url <- "http://api.arbetsformedlingen.se/af/v0/platsannonser/"
  url <- paste0(url,id)
  response <- GET(url = url, add_headers("Accept-Language" = "sv"))
  response <- jsonlite::fromJSON(content(response, "text"),
                     simplifyVector = FALSE)
  return(response)
}
