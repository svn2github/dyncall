# File: rdc/demo/sqrt.R
# Description: call sqrt

dyn.load("/windows/system32/msvcrt")
sym.sqrt <- getNativeSymbolInfo("sqrt")

x <- 144.0
rdcCall( sym.sqrt$address, "d)d", x)
