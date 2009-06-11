# TODO: Add comment
# 
# Author: dadler
###############################################################################

library(rdyncall)
dynport(SDL_image)

loadSurface <- function(name)
{
  x <- IMG_Load(name)
  if (!is.nullptr(x)) 
    as.structptr(SDL_Surface, x)
  else
    NULL
}

