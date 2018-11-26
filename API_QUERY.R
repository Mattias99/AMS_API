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