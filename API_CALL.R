#### PACKAGE ####


library(jsonlite)


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
# AMS_QUERY
#======================================

norrkoping <- ams_query(lan = 05, kommun = 0581, text = "statistik")

test <- do.call(rbind.data.frame, norrkoping$matchningslista$matchningdata)