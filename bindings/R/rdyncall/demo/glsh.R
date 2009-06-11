checkGL <- function()
{
  gl_error <- glGetError()
  if ( gl_error != GL_NO_ERROR ) { 
    stop(gl_error)
  }
}
quit <- logical(1)
vertexdata <- function(..., size=4)
{
  matrix(data=c(...),nrow=size)
}
buffers <- integer(1)
vertexarrays <- integer(1)
vs <- NULL
vssrc <- "
void main()
{
  gl_Position = ftransform();
}
"
fs <- NULL
fssrc <- "
void main()
{
  gl_FragColor = vec4(0.0,0.0,1.0,1.0);
}
"
sizeof.double <- 8
prg <- NULL

allocGL <- function()
{
  glGenBuffers( length(buffers), buffers )
  glGenVertexArrays( length(vertexarrays), vertexarrays )
  vs <<- glCreateShader(GL_VERTEX_SHADER)
  fs <<- glCreateShader(GL_FRAGMENT_SHADER)  
  checkGL()
}
compileGL <- function()
{
  glShaderSource(vs, length(vssrc), vssrc, NULL) 
  glCompileShader(vs)
  status <- integer(1)
  glGetObjectParameteriv(vs, GL_OBJECT_COMPILE_STATUS, status)
  if (status != TRUE) stop("vertex shader failed")
  glShaderSource(fs, length(fssrc), fssrc, NULL)
  glCompileShader(fs)
  glGetObjectParameteriv(fs, GL_OBJECT_COMPILE_STATUS, status)
  if (status != TRUE) stop("vertex shader failed")  
  prg <<- glCreateProgram()
  glAttachShader(prg, vs)
  glAttachShader(prg, fs)
  glLinkProgram(prg)
  checkGL()
}
initGLData <- function()
{  
  data <- vertexdata(size=2, 0,0,  1,0,  0,1,  1,1 )
  glEnableVertexAttribArray(0)    
  glBindBuffer( GL_ARRAY_BUFFER, buffers[[1]] )
  glBufferData(GL_ARRAY_BUFFER, length(data)*sizeof.double, data, GL_STATIC_DRAW) 
  glBindVertexArray( vertexarrays[[1]] )
  glVertexAttribPointer(0, 4, GL_DOUBLE, GL_FALSE, 0, 0)
  checkGL()  
}
deleteGLData <- function()
{
  glDeleteBuffers( length(buffers), buffers )
  glDeleteVertexArrays( length(vertexarrays), vertexarrays )  
  glDeleteProgram(prg)
  # glDeleteShader(vs)
  # glDeleteShader(fs)
}
updateGL <- function()
{
  glClear(GL_COLOR_BUFFER_BIT)
  glUseProgram(prg)
  glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
  glUseProgram(0)
}

initGL <- function()
{
  require(rdyncall)
  dynport(sdl)
  dynport(gl)
  SDL_Init(SDL_INIT_VIDEO)
  SDL_SetVideoMode(640,480,32,SDL_OPENGL)
  dynport(glew)
  glewInit()
  checkGL()
  glClearColor(0,0,0,0)
  checkGL()
  allocGL()
  compileGL()
  initGLData()
  checkGL()
}
initialized <- FALSE
init <- function()
{
  if (!initialized) { 
	initialized <<- TRUE;
	initGL() 
	e <- malloc(SDL_Event.sizeof)  
  }
}
main <- function()
{
  init()
  quit <- FALSE
  while(!quit) 
  {
    updateGL()
    SDL_GL_SwapBuffers()
	eventsSDL()
	while( SDL_PollEvent(eventobj) != 0 )
	{
		eventType <- SDL_Event.type(eventobj)
		if (eventType == SDL_MOUSEBUTTONDOWN) quit <- TRUE
	}
  }
}
