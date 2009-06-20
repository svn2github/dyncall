sdlLib <- dynload("SDL")
._SDL_SetVideoMode <- sdlLib$SDL_SetVideoMode

.dyncall.cdecl(._SDL_SetVideoMode)

surf <- SDL_SetVideoMode(640,480,32,SDL_DOUBLEBUF+SDL_OPENGL)
