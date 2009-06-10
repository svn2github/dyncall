# Dynport: sdl
# Description: Simple Directmedia Layer library
# Dynport-Maintainer: dadler@uni-goettingen.de
# -----------------------------------------------------------------------------


# -----------------------------------------------------------------------------
# constants:

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

# -----------------------------------------------------------------------------
# bindings:

types <- c(
Uint32 = 'i',
int = 'i',
Uint16 = 'S',
"pointer" = 'p'
)
    
SDL_Surface <- structinfo("
  Uint32 flags;
  pointer format;
  int w;
  int h;
  Uint16 pitch;
  pointer pixels;
",types)

dynbind("SDL","
SDL_Init(i)i;
SDL_Quit()v;
SDL_SetVideoMode(iiii)p;
SDL_WM_SetCaption(ZZ)v;
SDL_GL_SwapBuffers()v;
SDL_PollEvent(p)i;
SDL_GetTicks()i;
SDL_Delay(i)v;
")

# -----------------------------------------------------------------------------
# C structure helpers:

.typemap <- c(
    UINT='I',
    WNDPROC='p',
    int='i',
    HINSTANCE='p',
    HICON='p',
    HCURSOR='p',
    HBRUSH='p',
    LPCTSTR='Z',
    LPCTSTR='Z',
    void='v'
)

SDL_Event.type   <- function(event) .unpack1(event, 0, "c")
SDL_Event.button <- function(event) .unpack1(event, 1, "c")
SDL_Event.gain   <- function(event) .unpack1(event, 1, "c")
SDL_Event.state  <- function(event) .unpack1(event, 2, "c")
SDL_Event.key    <- function(event) .unpack1(event, 3, "i") # need to be tested!

# SDL_ActiveEvent <- .cstruct( type="uint8",gain="uint8",state="uint8")
# SDL_KeyboardEvent <- .cstruct( type="uint8", state="uint8", keysym="SDL_keysym")

new.SDL_event <- function() malloc(sizeof.SDL_Event)

commented <- function() {

structinfo("SDL_ActiveEvent","
  Uint8 type;
  Uint8 gain;
  Uint8 state;
")
structinfo("SDL_KeyboardEvent","
  Uint8 type;
  Uint8 which;
  Uint8 state;
  SDL_keysym keysym;
")
structinfo("SDL_MouseMotionEvent","
  Uint8 type;
  Uint8 which;
  Uint8 state;
  Uint16 x, y;
  Sint16 xrel;
  Sint16 yrel;
")
structinfo("SDL_MouseButtonEvent","
  Uint8 type;
  Uint8 which;
  Uint8 button;
  Uint8 state;
  Uint16 x, y;
")
structinfo("SDL_JoyAxisEvent","
  Uint8 type;
  Uint8 which;
  Uint8 axis;
  Sint16 value;
")
structinfo("SDL_JoyBallEvent","
  Uint8 type;
  Uint8 which;
  Uint8 ball;
  Sint16 xrel;
  Sint16 yrel;
")
structinfo("SDL_JoyHatEvent","
  Uint8 type;
  Uint8 which;
  Uint8 hat;
  Uint8 value;
")
structinfo("SDL_JoyButtonEvent","
  Uint8 type;
  Uint8 which;
  Uint8 button;
  Uint8 state;
")
structinfo("SDL_ResizeEvent","
  Uint8 type;
  int w;
  int h;
")
structinfo("SDL_ExposeEvent","
  Uint8 type;
")
structinfo("SDL_QuitEvent","
  Uint8 type;
")
structinfo("SDL_UserEvent","
  Uint8 type;
  int code;
  void *data1;
  void *data2;
")

unioninfo("SDL_Event","
        Uint8 type;
        SDL_ActiveEvent active;
        SDL_KeyboardEvent key;
        SDL_MouseMotionEvent motion;
        SDL_MouseButtonEvent button;
        SDL_JoyAxisEvent jaxis;
        SDL_JoyBallEvent jball;
        SDL_JoyHatEvent jhat;
        SDL_JoyButtonEvent jbutton;
        SDL_ResizeEvent resize;
        SDL_ExposeEvent expose;
        SDL_QuitEvent quit;
        SDL_UserEvent user;
        SDL_SysWMEvent syswm;
        ")


# struct SDL_SysWMmsg;
# typedef struct SDL_SysWMmsg SDL_SysWMmsg;
structinfo("SDL_SysWMEvent","
  Uint8 type;
  SDL_SysWMmsg *msg;
")



}
