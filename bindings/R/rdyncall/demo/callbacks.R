# TODO: Add comment
# 
# Author: dadler
###############################################################################


f <- function(x,y) x+y

cb <- new.callback("ii)i", f)
r <- .dyncall(cb, "ii)i", 20, 3, callmode="cdecl")
r == 23

f <- function(x,y,f,i) 
{
  if (i > 1) .dyncall(f, "iipi)i", x,y,f,i-1, callmode="cdecl")
  x+y
}

cb <- new.callback("iipi)i", f)

r <- .dyncall(cb, "iipi)i", 1,1,cb,700, callmode="cdecl" )
