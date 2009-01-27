dynport(Rmalloc)
dynport(sdl)
dynport(gl)

init <- function()
{
  SDL_Init(SDL_INIT_VIDEO)
  SDL_SetVideoMode(640,480,32,SDL_OPENGL)
  blink <<- 0
}


update <- function()
{
  glClearColor(0,0,blink,0)
  glClear(GL_COLOR_BUFFER_BIT)
  blink <<- ( blink + 0.01 ) %% 1
}

input <- function()
{
  return(TRUE)
}

mainloop <- function()
{
  sdlevent <- malloc( sizeof.SDL_Event )
  quit <- FALSE
  while(!quit)
  {
    update()
    SDL_GL_SwapBuffers()
    while( SDL_PollEvent(sdlevent) )
    {
      type <- SDL_Event.type(sdlevent)
      if (type == SDL_QUIT ) {
        quit <- TRUE
      } else if (type == SDL_MOUSEBUTTONDOWN) {
        cat("button ", SDL_Event.button(sdlevent) ,"\n")
      }
    }
  }
}

init()
mainloop()
