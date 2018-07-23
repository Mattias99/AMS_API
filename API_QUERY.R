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
  response <- ams_api(path = "af/v0/platsannonser/",
                      q = list(annonsid = id))
  return(response)
}
