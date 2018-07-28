ams_query <- function(lan_id, kommun_id, text){
  # Specify your API query.
  #
  # Args:
  #   lan_id: Specify one numeric county ID
  #   kommun_id: Specify one numeric municipality ID
  #   text: Search by character, use + for multiple words
  #
  # Returns:
  #   List of job ads found by query
  #
  # Error handling
  if (!is.numeric(lan_id) | !is.numeric(kommun_id) |
      !is.character(text)){
    stop("Invalid input.")
  }
  response <- ams_api(path = "af/v0/platsannonser/matchning",
                      query = list(lanid = lan_id,
                               kommunid  = kommun_id,
                               nyckelord = text))
  return(response)
}


ams_query_text <- function(job_id){
  # Download full job ad by specifying JobAnnonsID.
  #
  # Args:
  #   job_id: Numeric ID for job ad
  #
  # Returns:
  #   List of one job ad
  if (!is.character(job_id)){
    stop("Specify ID in string.")
  }
  url <- "http://api.arbetsformedlingen.se/af/v0/platsannonser/"
  url <- paste0(url, job_id)
  response <- GET(url = url, add_headers("Accept-Language" = "sv"))
  response <- jsonlite::fromJSON(content(response, "text"),
                     simplifyVector = FALSE)
  return(response)
}