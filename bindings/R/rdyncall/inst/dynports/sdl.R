
# init flags:

SDL_INIT_TIMER		   = 0x00000001
SDL_INIT_AUDIO		   = 0x00000010
SDL_INIT_VIDEO		   = 0x00000020
SDL_INIT_CDROM		   = 0x00000100
SDL_INIT_JOYSTICK	   = 0x00000200
SDL_INIT_NOPARACHUTE = 0x00100000
SDL_INIT_EVENTTHREAD = 0x01000000
SDL_INIT_EVERYTHING	 = 0x0000FFFF

# video flags:

SDL_SWSURFACE	  = 0x00000000
SDL_HWSURFACE	  = 0x00000001
SDL_ASYNCBLIT	  = 0x00000004
SDL_ANYFORMAT	  = 0x10000000
SDL_HWPALETTE	  = 0x20000000
SDL_DOUBLEBUF	  = 0x40000000
SDL_FULLSCREEN	= 0x80000000
SDL_OPENGL      = 0x00000002
SDL_OPENGLBLIT	= 0x0000000A
SDL_RESIZABLE	  = 0x00000010
SDL_NOFRAME	    = 0x00000020
SDL_HWACCEL	    = 0x00000100
SDL_SRCCOLORKEY	= 0x00001000
SDL_RLEACCELOK	= 0x00002000
SDL_RLEACCEL	  = 0x00004000
SDL_SRCALPHA	  = 0x00010000
SDL_PREALLOC	  = 0x01000000

# event ids:

SDL_NOEVENT         = 0
SDL_ACTIVEEVENT     = 1
SDL_KEYDOWN         = 2
SDL_KEYUP           = 3
SDL_MOUSEMOTION     = 4 
SDL_MOUSEBUTTONDOWN = 5
SDL_MOUSEBUTTONUP   = 6
SDL_JOYAXISMOTION   = 7
SDL_JOYBALLMOTION   = 8
SDL_JOYHATMOTION    = 9
SDL_JOYBUTTONDOWN   = 10
SDL_JOYBUTTONUP     = 11
SDL_QUIT            = 12
SDL_SYSWMEVENT      = 13
SDL_EVENT_RESERVEDA = 14
SDL_EVENT_RESERVEDB = 15
SDL_VIDEORESIZE     = 16
SDL_VIDEOEXPOSE     = 17
SDL_EVENT_RESERVED2 = 18
SDL_EVENT_RESERVED3 = 19
SDL_EVENT_RESERVED4 = 20
SDL_EVENT_RESERVED5 = 21
SDL_EVENT_RESERVED6 = 22
SDL_EVENT_RESERVED7 = 23
SDL_USEREVENT       = 24
SDL_NUMEVENTS       = 32

sizeof.SDL_Event    = 64

# bindings:

dynbind("SDL","
SDL_Init(i)i;
SDL_Quit()v;
SDL_SetVideoMode(iiii)p;
SDL_WM_SetCaption(SS)v;
SDL_GL_SwapBuffers()v;
SDL_PollEvent(p)i;
SDL_GetTicks()i;
SDL_Delay(i)v;
")

# R utility:

SDL_Event.type   <- function(event) .unpack1(event, 0, "c")
SDL_Event.button <- function(event) .unpack1(event, 1, "c")
SDL_Event.gain   <- function(event) .unpack1(event, 1, "c")
SDL_Event.state  <- function(event) .unpack1(event, 2, "c")

# SDL_ActiveEvent <- .cstruct( type="uint8",gain="uint8",state="uint8")
# SDL_KeyboardEvent <- .cstruct( type="uint8", state="uint8", keysym="SDL_keysym")

new.SDL_event <- function() malloc(sizeof.SDL_Event)
