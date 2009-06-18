# TODO: Add comment
# 
# Author: dadler
###############################################################################


.types <- list()

setStruct <- function(name, ...)
{
  x <- list(...)
  class(x) <- c("struct","type")
  .types[[name]] <<- x
}

setUnion <- function(name, ...)
{
  x <- list(...)
  class(x) <- c("union","type")
  .types[[name]] <<- x
}

getType <- function(name)
{
  .types[[name]]
}


setStruct("SDL_keysym", scancode="C", sym="i", mod="i", unicode="S" )
setStruct("SDL_KeyboardEvent", type="C", which="C", state="C", keysym="{SDL_keysym}")

parseTypeSignature("SDL_Event|C<SDL_ActiveEvent><SDL_KeyboardEvent><SDL_MouseMotionEvent><SDL_MouseButtonEvent><SDL_JoyAxisEvent><SDL_JoyBallEvent><SDL_JoyHatEvent><SDL_JoyButtonEvent><SDL_ResizeEvent><SDL_ExposeEvent><SDL_QuitEvent><SDL_UserEvent><SDL_SysWMEvent>|type active key motion button jaxis jball jhat jbutton resize expose quit user syswm ;")

setUnion("SDL_Event", 
    type="uchar", 
    action="SDL_ActiveEvent", 
    key="SDL_KeyboardEvent", 
    motion="SDL_MouseMotionEvent", 
    button="SDL_MouseButtonEvent", 
    jaxis="SDL_JoyAxisEvent", 
    jball="SDL_JoyBallEvent", 
    jbutton="SDL_JoyButtonEvent", 
    resize="SDL_ResizeEvent", 
    expose="SDL_ExposeEvent", 
    quit="SDL_QuitEvent", 
    user="SDL_UserEvent", 
    syswm="SDL_SysWMEvent")

.sizeof <- c(
    B=.Machine$sizeof.long,
    c=1L,
    C=1L,
    s=2L,
    S=2L,
    i=.Machine$sizeof.long,
    I=.Machine$sizeof.long,
    j=.Machine$sizeof.long,
    J=.Machine$sizeof.long,
    l=.Machine$sizeof.longlong,
    L=.Machine$sizeof.longlong,
    f=4L,
    d=8L,
    "*"=.Machine$sizeof.pointer,
    p=.Machine$sizeof.pointer,
    x=.Machine$sizeof.pointer,
    Z=.Machine$sizeof.pointer,
    v=0L    
)

align <- function(start, type)
{
  start %% sizeof(x)
}

sizeof <- function(x) 
{
  first <- substr(x,1,1)
  if (first == "<") {
    if ( substr(x, nchar(x), nchar(x) ) != ">" ) stop("invalid signature")
    typeName <- substr(x,2,nchar(x)-2)
    sizeof(getType(typeName))
  } else {
    .sizeof[[substr(x, 1,1)]]
  }
}

sizeof.struct <- function(x)
{
  total <- 0L
  for(i in x)
  {
    size  <- sizeof(i)
    total <- total + total %% size + size
  }
  return(total)
}


sizeof(struct("iii"))
sizeof(union("iii"))

