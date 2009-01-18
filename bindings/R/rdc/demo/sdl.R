library(rdc)
# ----------------------------------------------------------------------------
# C memory allocation
dyn.load("/windows/system32/msvcrt")
.malloc <- getNativeSymbolInfo("malloc")$address
.free   <- getNativeSymbolInfo("free")$free
malloc <- function(size) rdcCall(.malloc, "i)p", as.integer(size) )
free   <- function(ptr) rdcCall(.free, "p)v", ptr)
# ----------------------------------------------------------------------------
# SDL library
dyn.load("/dll/sdl")
.SDL_Init <- getNativeSymbolInfo("SDL_Init")$address
.SDL_Quit <- getNativeSymbolInfo("SDL_Quit")$address
.SDL_SetVideoMode <- getNativeSymbolInfo("SDL_SetVideoMode")$address
.SDL_WM_SetCaption <- getNativeSymbolInfo("SDL_WM_SetCaption")$address
.SDL_GL_SwapBuffers <- getNativeSymbolInfo("SDL_GL_SwapBuffers")$address
.SDL_PollEvent <- getNativeSymbolInfo("SDL_PollEvent")$address
.SDL_GetTicks <- getNativeSymbolInfo("SDL_GetTicks")$address
# init flags:
SDL_INIT_TIMER		= 0x00000001L
SDL_INIT_AUDIO		= 0x00000010L
SDL_INIT_VIDEO		= 0x00000020L
SDL_INIT_CDROM		= 0x00000100L
SDL_INIT_JOYSTICK	= 0x00000200L
SDL_INIT_NOPARACHUTE =	0x00100000L
SDL_INIT_EVENTTHREAD =	0x01000000L
SDL_INIT_EVERYTHING	= 0x0000FFFFL
# SDL_Init(flags):
SDL_Init <- function(flags) rdcCall(.SDL_Init, "i)i", as.integer(flags) )
# SDL_Quit():
SDL_Quit <- function() rdcCall(.SDL_Quit, ")v" )
# video flags:
SDL_SWSURFACE	= 0x00000000L
SDL_HWSURFACE	= 0x00000001L
SDL_ASYNCBLIT	= 0x00000004L
SDL_ANYFORMAT	= 0x10000000L
SDL_HWPALETTE	= 0x20000000L
SDL_DOUBLEBUF	= 0x40000000L
SDL_FULLSCREEN	= 0x80000000
SDL_OPENGL      = 0x00000002L
SDL_OPENGLBLIT	= 0x0000000AL
SDL_RESIZABLE	= 0x00000010L
SDL_NOFRAME	= 0x00000020L
SDL_HWACCEL	= 0x00000100L
SDL_SRCCOLORKEY	= 0x00001000L	
SDL_RLEACCELOK	= 0x00002000L
SDL_RLEACCEL	= 0x00004000L
SDL_SRCALPHA	= 0x00010000L
SDL_PREALLOC	= 0x01000000L
# SDL_SetVideoMode():
SDL_SetVideoMode <- function(width,height,bpp,flags) rdcCall(.SDL_SetVideoMode,"iiii)p",width,height,bpp,flags)
SDL_WM_SetCaption <- function(title, icon) rdcCall(.SDL_WM_SetCaption,"SS)v",as.character(title), as.character(icon))
SDL_PollEvent <- function(eventptr) rdcCall(.SDL_PollEvent,"p)i", eventptr)
SDL_GL_SwapBuffers <- function() rdcCall(.SDL_GL_SwapBuffers,")v")
SDL_GetTicks <- function() rdcCall(.SDL_GetTicks,")i")


SDL_NOEVENT = 0
SDL_ACTIVEEVENT = 1
SDL_KEYDOWN = 2
SDL_KEYUP = 3
SDL_MOUSEMOTION = 4 
SDL_MOUSEBUTTONDOWN = 5
SDL_MOUSEBUTTONUP = 6
SDL_JOYAXISMOTION = 7
SDL_JOYBALLMOTION = 8
SDL_JOYHATMOTION = 9
SDL_JOYBUTTONDOWN = 10
SDL_JOYBUTTONUP = 11
SDL_QUIT = 12
SDL_SYSWMEVENT = 13
SDL_EVENT_RESERVEDA = 14
SDL_EVENT_RESERVEDB = 15
SDL_VIDEORESIZE = 16
SDL_VIDEOEXPOSE = 17
SDL_EVENT_RESERVED2 = 18
SDL_EVENT_RESERVED3 = 19
SDL_EVENT_RESERVED4 = 20
SDL_EVENT_RESERVED5 = 21
SDL_EVENT_RESERVED6 = 22
SDL_EVENT_RESERVED7 = 23
SDL_USEREVENT = 24
SDL_NUMEVENTS = 32


SDL_EventType <- function(event) offset(event, 0, "integer", 1)



# ----------------------------------------------------------------------------
# OpenGL bindings
dyn.load("/windows/system32/OPENGL32")
.glClearColor <- getNativeSymbolInfo("glClearColor")$address
.glClear <- getNativeSymbolInfo("glClear")$address
glClearColor <- function(red,green,blue,alpha) rdcCall(.glClearColor, "ffff)v",red,green,blue,alpha)
glClear <- function(flags) rdcCall(.glClear, "i)v", flags)
GL_COLOR_BUFFER_BIT = 0x00004000L

# ----------------------------------------------------------------------------
# demo
init <- function()
{
  err <- SDL_Init(SDL_INIT_VIDEO)
  if (err != 0) error("SDL_Init failed")  
  surface <- SDL_SetVideoMode(640,480,24,SDL_HWSURFACE+SDL_DOUBLEBUF+SDL_OPENGL)
}

mainloop <- function()
{
  eventobj <- malloc(256)
  blink <- 0
  tbase <- SDL_GetTicks()
  quit <- FALSE
  while(!quit)
  {
    tnow <- SDL_GetTicks()
    tdemo <- ( tnow - tbase ) / 1000
    glClearColor(0,0,blink,0)
    glClear(GL_COLOR_BUFFER_BIT)
    SDL_GL_SwapBuffers()  
    
    SDL_WM_SetCaption(paste("time:", tdemo),0)    
    blink <- blink + 0.01
    while (blink > 1) blink <- blink - 1
    while( SDL_PollEvent(eventobj) != 0 )
    {
      eventType <- rdcUnpack1(eventobj, 0L, "c")       
      if (eventType == SDL_QUIT)
        quit <- TRUE
      else if (eventType == SDL_MOUSEBUTTONDOWN)
      {
        button <- rdcUnpack1(eventobj, 1L, "c")
        cat("button down: ",button,"\n")
      }
    }
  }
  # free(eventobj)
}

cleanup <- function()
{
  SDL_Quit()
}

demo <- function()
{
  init()
  mainloop()
}
