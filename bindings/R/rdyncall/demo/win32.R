dynport(win32)

# register window class

x <- new.struct(WNDCLASSEXA)

# test: should fail 

classatom <- RegisterClassExA(x)
classatom == 0

# WNDCLASSEXA structure initialization

x$cbSize        <- sizeof(WNDCLASSEXA)
x$lpszClassName <- "MyWindow" 
x$style 				<- CS_OWNDC
x$hbrBackground <- as.externalptr(COLOR_BACKGROUND + 1)

x$lpfnWndProc   <- as.externalptr(DefWindowProcA)

# R window handler:
#
windowhandler <- function(hwnd, msg, wparam, lparam)
{
  cat("msg\n")
  #if (msg == WM_CREATE) return(0)
  DefWindowProcA(hwnd,msg,wparam,lparam)
}
mycallback <- new.callback("_spppp)p", windowhandler)
x$lpfnWndProc   <- mycallback

# register class

classatom <- RegisterClassExA(x)
stopifnot(classatom != 0)

# create window

exstyle    <- WS_EX_APPWINDOW
classname  <- as.externalptr(classatom)
windowname <- "rdyncall/win32 demo"
style      <- WS_OVERLAPPEDWINDOW + WS_VISIBLE
x          <- 0
y          <- 0
nwidth     <- 640
nheight    <- 480
hparent    <- NULL
hmenu      <- NULL
hinstance  <- NULL
pparam     <- NULL
hwindow    <- CreateWindowExA(exstyle, classname, windowname, style, x, y, nwidth, nheight, hparent, hmenu, hinstance, pparam )


