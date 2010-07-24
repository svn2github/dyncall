require"dynport"
cocoautil = dynport("cocoautil")
cocoautil.CocoaInit()
SDL = dynport("SDL")
SDL.SDL_Init(SDL.SDL_INIT_VIDEO)
SDL.SDL_SetVideoMode(640,480,32,SDL.SDL_OPENGL)
GL = dynport("GL")
quit = false

while not quit do
  GL.glClearColor(0,0,1,1)
  GL.glClear(GL.GL_COLOR_BUFFER_BIT)
  SDL.SDL_GL_SwapBuffers()
end

