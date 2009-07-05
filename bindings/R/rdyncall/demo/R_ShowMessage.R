# File: rdyncall/demo/R_ShowMessage.R
# Description: 

dynbind("R","R_ShowMessage(Z)v;")
R_ShowMessage("hello")
R_ShowMessage(as.character(23))

