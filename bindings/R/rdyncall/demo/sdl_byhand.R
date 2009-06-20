# specify shared library object (os-specific)
libpath <- if ( .Platform$OS == "windows" ) 
      "c:\\dll\\SDL.dll" else "/usr/lib/libSDL.so"
# load library and resolve symbols
sdlLib <- dyn.load(libpath)
addr.SDL_Init <- sdlLib$SDL_Init$address
addr.SDL_SetVideoMode <- sdlLib$SDL_SetVideoMode$address
# define some constants
SDL_INIT_VIDEO=0x00000020
SDL_OPENGL=0x00000002
SDL_DOUBLEBUF=0x40000000
SDL_FULLSCREEN=0x80000000
# call SDL functions using dyncall
library(rdyncall)
SDL_Init <- function(flags) .dyncall.cdecl(addr.SDL_Init, "i)i", flags)
SDL_SetVideoMode <- function(w,h,d,flags) .dyncall.cdecl(addr.SDL_SetVideoMode, "iiii)p", w, h, d, flags)

# use SDL library in R:
SDL_Init(SDL_INIT_VIDEO)
surf <- SDL_SetVideoMode(640,480,32,SDL_OPENGL+SDL_DOUBLEBUF)

# now use C structures

SDL_SetVideoMode2 <- function(w,h,d,flags) .dyncall.cdecl(addr.SDL_SetVideoMode, "iiii)*<SDL_Surface>", w, h, d, flags)
