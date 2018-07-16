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

# /platsannonser/matchning?lanid={M}&kommunid={M}&yrkesid={M}&
# nyckelord ={M}&sida={V}&antalrader={V}

AMS_QUERY <- function(lan, kommun, text){
  response <- AMS_API(path = 'af/v0/platsannonser/matchning',
                      q = list(lanid=lan,
                               kommunid = kommun,
                               nyckelord = text))
  
  #response <- do.call(rbind.data.frame, response$matchningslista$matchningdata)
  
  return(response)
}