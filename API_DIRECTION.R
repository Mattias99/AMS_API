#### PACKAGE ####

library("googleway")


# Resource:
#   https://cran.r-project.org/web/packages/googleway/googleway.pdf
#   https://cran.r-project.org/web/packages/googleway/vignettes/googleway-vignette.html
#

set_key(key = gc_key)


job_dist <- google_distance(
  origin      = set_origin,
  destination = job_all$address[2],
  mode        = "transit",
  simplify    = TRUE
)

# google_direction cannot handle å, ä or ö.
# Solution to this problem is the iconv function
# which convert characters between Encodings.

ams_dir <- function(job_adr, mode){
  # Connection to Google Direction API
  # without Encoding problems, i.e. Å-Ä-Ö
  #
  # Args:
  #   path: Supply Job address as a string
  #   query: Specify type of transportation
  #
  # Returns:
  #   Return same object as from google_directions()
  if (Encoding(job_adr) == "UTF-8"){
    dest <- iconv(job_adr, "UTF-8", "ASCII//TRANSLIT")
  } else if (Encoding(job_adr) == "latin1") {
    dest <- iconv(job_adr, "latin1", "ASCII//TRANSLIT")
  } else {
    stop("Cannot identify Encoding")
  }
  print(dest)
  job_dir <- google_directions(
    origin      = set_origin,
    destination = dest,
    mode        = mode,
    simplify    = TRUE
  )
  return(job_dir)
}
