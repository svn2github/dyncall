# File: rdyncall/demo/R_ShowMessage.R
# Description: 

lib <- .dynload("R")
sym <- .dynfind(lib,"R_ShowMessage")
R_ShowMessage <- function(...)
  .dyncall.cdecl(sym, "S)v", ...)
R_ShowMessage("hello")
R_ShowMessage(23)
