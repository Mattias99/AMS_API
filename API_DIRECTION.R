#### RESOURCE ####


#   https://cran.r-project.org/web/packages/googleway/googleway.pdf
#   https://cran.r-project.org/web/packages/googleway/vignettes/googleway-vignette.html


#### GOOGLE MAP ####
set_key(key = gc_key)


job_dist <- google_distance(
  origin      = set_origin,
  destination = job_all$address[i],
  mode        = "transit",
  simplify    = TRUE
)


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
  } else if (Encoding(job_adr) == "unknown") {
    dest <- job_adr
  } else {
    stop("Cannot identify Encoding")
  }
  print(dest)
  job_dir <- google_directions(
    origin      = set_origin,
    destination = unname(dest),
    mode        = mode,
    simplify    = TRUE
  )
  return(job_dir)
}

test <- ams_dir(job_adr = job_all$address[i], mode = "transit")
test_dir <- direction_polyline(test)
test_pl <- decode_pl(test_dir)

test_df <- data.frame("polyline" = test_dir)

google_map() %>%
  add_polylines(data = test_df, polyline = "polyline", stroke_weight = 9)

test_map <- google_map() %>%
  add_polylines(data = test_df, polyline = "polyline", stroke_weight = 9)
