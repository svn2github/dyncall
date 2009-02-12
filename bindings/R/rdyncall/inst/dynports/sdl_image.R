# TODO: Add comment
# 
# Author: dadler
###############################################################################

dynport(SDL)
dynbind("SDL_image","
IMG_Load(S)p;
")
