# Package: rdyncall 
# File: demo/R_ShowMessage.R
# Description: Show R Dialog Message (dynbind demo)
# Author: Daniel Adler

dynbind("R","R_ShowMessage(Z)v;")
R_ShowMessage("hello")
R_ShowMessage(as.character(23))

