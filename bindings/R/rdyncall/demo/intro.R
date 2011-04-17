# Package: rdyncall
# File: demo/intro.R
# Description: Texture-mapped scroll-text, playing music 'Hybrid Song' composed in jan. -96 by Quazar of Sanxion 

s <- NULL
texId <- NULL
music <- NULL

checkGL <- function()
{
  glerror <- glGetError()
  if (glerror != 0)
  {
    cat("GL Error", glerror, "\n")
  }
  return(glerror == 0)
}

init <- function()
{
  dynport(SDL)
  SDL_Init(SDL_INIT_VIDEO+SDL_INIT_AUDIO)
  dynport(GL)
  dynport(SDL_image)
  s <<- SDL_SetVideoMode(640,480,32,SDL_OPENGL+SDL_DOUBLEBUF)
  stopifnot( IMG_Init(IMG_INIT_PNG) == IMG_INIT_PNG )
  texId <<- loadTexture("nuskool_krome_64x64.png")
  dynport(SDL_mixer)
  # stopifnot( Mix_Init(MIX_INIT_MOD) == MIX_INIT_MOD )
  Mix_OpenAudio(MIX_DEFAULT_FREQUENCY, MIX_DEFAULT_FORMAT, 2, 4096)
  music <<- Mix_LoadMUS(rsrc("external.xm"))
}
  
rsrc <- function(name) system.file(paste("demo-files",name,sep=.Platform$file.sep), package="rdyncall")

loadTexture <- function(name)
{
  checkGL()
  glEnable(GL_TEXTURE_2D)
  x <- rsrc(name)
  img <- IMG_Load(x)
#  glPixelStorei(GL_UNPACK_ALIGNMENT,4)
  texid <- integer(1)
  glGenTextures(1, texid)
  glBindTexture(GL_TEXTURE_2D, texid)
  SDL_LockSurface(img)
  maxS <- integer(1)
  glGetIntegerv(GL_MAX_TEXTURE_SIZE, maxS)
  stopifnot( (img$w <= maxS) && (img$h <= maxS) )
  glTexImage2D(GL_TEXTURE_2D, 0, 4, img$w, img$h, 0, GL_BGRA, GL_UNSIGNED_BYTE, img$pixels)
  SDL_UnlockSurface(img)
  SDL_FreeSurface(img) 
#  gluBuild2DMipmaps(GL_TEXTURE_2D, 4, img$w, img$h)
  return(texid)
}

drawScroller <- function(text,time)
{
  glClearColor(1,0,0,0)
  glClear(GL_COLOR_BUFFER_BIT)
  glBindTexture(GL_TEXTURE_2D, texId)
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR)
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR)
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT)
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT)
  t <- 72-32
  glEnable(GL_BLEND)
  glBlendFunc( GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)
  glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_REPLACE)


  x <- 1-time*0.1
  y <- 0
  w <- 0.2
  h <- 0.2
  for (i in 1:length(codes)) {
    t <- codes[i]
    glBegin(GL_QUADS)
    glTexCoord2f(t/64,1)
    glVertex3f(x,y,0)
    glTexCoord2f((t+1)/64,1)
    glVertex3f(x+w,y,0)
    glTexCoord2f((t+1)/64,0)
    glVertex3f(x+w,y+h,0)
    glTexCoord2f(t/64,0)
    glVertex3f(x,y+h,0)
    glEnd()
    x <- x + w
  } 
  SDL_GL_SwapBuffers()
}
  
codes <- utf8ToInt("HELLO DUDEZ") - 32

mainloop <- function()
{
  Mix_PlayMusic(music, 1)
  quit <- FALSE
  blink <- 0
  tbase <- SDL_GetTicks()
  evt <- new.struct(SDL_Event)
  while(!quit)
  {
    tnow <- SDL_GetTicks()
    glClearColor(0,0,blink,0)
    glClear(GL_COLOR_BUFFER_BIT+GL_DEPTH_BUFFER_BIT)
    blink <- blink + 0.01
    tdemo <- ( tnow - tbase ) / 1000
    drawScroller(codes,tdemo)
    while( SDL_PollEvent(evt) != 0 )
    {
      if ( evt$type == SDL_QUIT ) quit <- TRUE
      else if (evt$type == SDL_MOUSEBUTTONDOWN )
      {
        button <- evt$button
        cat("button ",button$button," at ",button$x,",",button$y,"\n") 
      }
    }
    SDL_Delay(30)
  }
}

cleanup <- function()
{
  Mix_CloseAudio()
#  Mix_Quit()
  IMG_Quit()
  SDL_Quit()
}

run <- function()
{
  init()
  mainloop()
  cleanup()
}

run()

