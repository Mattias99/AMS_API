#### PACKAGE ####


library("httr")
library("jsonlite")


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


#======================================
# AD-HOC RESPONSE
# AMS_API
#======================================


respsok <- AMS_API(path = "af/v0/platsannonser/soklista/kommuner",
                   q = list(lanid = 10))

jsonlite::fromJSON(jsonlite::content(respsok, "text"), simplifyVector = TRUE)
http_type(respsok)

respmatch <- AMS_API(path = "af/v0/platsannonser/22503390", q = NULL)

# This works
# Previous Error: Bad header parameter, add language to 'sv'


response <-
  GET(
    "http://api.arbetsformedlingen.se/af/v0/platsannonser/22503390",
    add_headers("Accept-Language" = "sv")
  )

resp <- ams_query_text(testid)
respdf <- do.call(rbind.data.frame, resp$platsannons$annons) %>%
  as.tibble()



respun <- unlist(resp)
df <- data.frame(matrix(unlist(respun), byrow=T))

status_code(response)
text_content(response)
parsed <- jsonlite::fromJSON(content(response, "text"), simplifyVector = FALSE)


#======================================
# AD-HOC RESPONSE
# AMS_QUERY
#======================================

norrkoping <- AMS_QUERY(lan = 05, kommun = 0581, text = "statistik")

test <- do.call(rbind.data.frame, norrkoping$matchningslista$matchningdata)

norrkoping