# Statetris - a statistics tetris-game
#

checkGL <- function()
{
  gl_error <- glGetError()
  if ( gl_error != GL_NO_ERROR ) { 
    stop(gl_error)
  }
}

initGL <- function()
{
  glClearColor(0,0,0,0)
}

event <- NULL
initEvents <- function()
{
  #event <<- asType( malloc( sizeof( getType("SDL_Event") ) ), getType("SDL_Event") )
  event <<- malloc(sizeof.SDL_Event)
  # TODO: structs
  event <<- malloc( sizeof("SDL_Event") )
}

init <- function()
{
  require(rdyncall)
  dynport(rmalloc)  
  dynport(sdl)
  dynport(gl)
  SDL_Init(SDL_INIT_VIDEO)
  SDL_SetVideoMode(640,480,32,SDL_OPENGL)
  dynport(glew)
  glewInit()
  checkGL()
  #allocGL()
  #compileGL()
  #initGLData()
  #checkGL()
  
}

cleanup <- function()
{
  SDL_Quit()
  unloadNamespace("sdl")
  unloadNamespace("glew")
}

main <- function()
{
  init()
  initEvents()
  initGL()
  checkGL()
  mainloop()
}

mainloop <- function()
{  
  quit <- FALSE
  while(!quit) 
  {
    updateGL()
    SDL_GL_SwapBuffers()
    while( SDL_PollEvent(eventobj) != 0 )
    {
      eventType <- SDL_Event.type(eventobj)
      if (eventType == SDL_MOUSEBUTTONDOWN) quit <- TRUE
    }    
  }
}
