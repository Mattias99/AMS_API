#### PACKAGE ####

library("googleway")


# Resource:
#   https://cran.r-project.org/web/packages/googleway/googleway.pdf
#   https://cran.r-project.org/web/packages/googleway/vignettes/googleway-vignette.html
#

set_key(key = gc_key)

google_places("Vilbergsgatan 71")

google_places(job_all$address[1])


job_dist <- google_distance(
  origin      = "Vilbergsgatan 71",
  destination = job_all$address[2],
  mode        = "transit",
  simplify    = TRUE
)

# google_direction cannot handle å, ä or ö.
# Solution to this problem is the iconv function
# Which convert characters between Encodings.

ams_dir <- function(job_adr, mode){
  if (Encoding(job_adr) == "UTF-8"){
    dest <- iconv(job_adr, "UTF-8", "ASCII//TRANSLIT")
  } else if(Encoding(job_adr) == "latin1") {
    dest <- iconv(job_adr, "latin1", "ASCII//TRANSLIT")
  } else {
    stop("Cannot identify Encoding")
  }
  job_dir <- google_directions(
    origin      = "Vilbergsgatan 71",
    destination = dest,
    mode        = mode,
    simplify    = TRUE
  )
  return(job_dir)
}

test <- ams_dir(job_adr = job_all$address[1], mode = "transit")
