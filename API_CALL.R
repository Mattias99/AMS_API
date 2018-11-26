# #### PACKAGE ####
# 
# 
# library("httr")
# library("jsonlite")
# 
# 
# #======================================
# # QUERY DEFINITIONS:
# #
# # lan_idid 01 : Stockholm
# # lan_idid 05 : Östergötlan_idd
# # lan_idid 04 : Södermanlan_idd
# #
# # kommun_idid 0483 : Katrineholm
# # kommun_idid 0480 : Nyköping
# # kommun_idid 0181 : Södertälje
# # kommun_idid 0180 : Stockholm 
# #======================================
# 
# 
# norrkoping <- ams_query(lan_id = 05, kommun_id = 0581, text = "statistiker")
# stockholm <- ams_query(lan_id = 01, kommun_id = 0180, text = "statistiker")
# katrineholm <- ams_query(lan_id = 04, kommun_id = 0480, text = "statistiker")
# nykoping <- ams_query(lan_id = 04, kommun_id = 0480, text = "statistiker")