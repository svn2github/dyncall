\name{rdyncall}
\docType{package}
\alias{rdyncall}
\alias{rdyncall-package}
\title{Dynamic foreign library interface framework}
\description{  
Flexible foreign function interface with support for C callbacks, pointer and 
aggregate struct/union types. 
An experimental framework for portable dynamic binding of 'whole' shared C 
libraries is included with initial support for libraries such as OpenGL (up to 3.0), 
libSDL, expat and the R shared library itself.
}
\details{
\pkg{rdyncall} is a toolkit that aims to bind Application Programming Interfaces(API)
of shared C library functions, constants, callbacks and types with the R language in a portable way.

At the core a flexible foreign function interface based on the 
\emph{dyncall} C library is used for passing arguments, invoking function calls
and returning values between R and C with support for multiple calling conventions.

The function calls are effectively executed by small call kernels written in
assembly.

 and the library has been ported to various architectures such as
x86, x64, arm, mips32/64 and ppc32.
A string-based type signature description for function calls, callbacks, pointers
and aggregate structures controls the desired behaviour.
In addition, R helper functions are available to work with pointer and 
aggregate C types as well as with C float and string arrays.
With the experimental dynport framework, R interfaces to popular APIs and
shared libraries are availabe such as OpenGL, SDL (including image, mixer, ttf),
expat and the R API itself. 
The specification is extracted using gcc-xml, boost wave and 
specificalized xslt. See \command{\link{dynport}} for details.
The package allows to interface with functions, constants, structures and 
unions of C shared libraries specified in C header files.
}
\section{Overview}{
\itemize{
\item Calling of precompiled code with support for wide range of C types, flexible mapping type mappings and calling conventions. See \code{\link{.dyncall}}.
\item Locating of shared libraries by short names in a portable way. See \code{\link{dynfind}}.
\item Loading of shared libraries with managed unloading. See \code{\link{.dynload}}.
\item Installation of wrapper functions to shared library code. See \code{\link{dynbind}}.
\item Working with C low-level and aggregate types (structs and unions). See \code{\link{packing}} and \code{\link{struct}}.
\item Wrapping R functions as C function pointers to be used in C callbacks. See \code{\link{new.callback}}. 
\item Dynamic binding of complete shared library functions and interfaces (constants, enums, struct and union types). See \code{\link{dynport}}. 
}
}
\section{Getting Started}{
Several demos and two vignettes are available. Some demos require additional
software to be installed on the system. Please make sure, you have installed 
the shared libraries.
}
\section{Applications}{
The package can be used to get direct access to system services such as 
OpenGL for 3D Graphics. The SDL library can be used for controlling multimedia 
devices (Video, Audio, User-Input) in a portable way. 
See \command{\link{dynport}} for details.  
}
\references{
  Adler, D., Philipp, T. (2008) \emph{DynCall Library}. 
  \url{http://dyncall.org}
}
\examples{
\donttest{
# multimedia example
# load dynports for OpenGL, Simple DirectMedia library
# globals:
surface <- NULL
# init (up to) OpenGL 3.0 API:
init <- function()
{
  dynport(SDL)
  dynport(GL)
  if ( SDL_Init(SDL_INIT_VIDEO) != 0 ) stop("SDL_Init failed")
  surface <<- SDL_SetVideoMode(640,480,32,SDL_DOUBLEBUF+SDL_OPENGL)
  cat("surface dimension:", surface$w, "x",surface$h,sep="")
  # Access OpenGL 3.0 API
  dynport(glew)
}
# draw blue screen
updateSurface <- function(t)
{
  glClearColor(0,0,t \%\% 1,0)
  glClear(GL_COLOR_BUFFER_BIT+GL_DEPTH_BUFFER_BIT)
  SDL_GL_SwapBuffers()
}
# wait till close
mainloop <- function()
{
  quit <- FALSE
  evt <- new.struct(SDL_Event)
  base <- SDL_GetTicks() / 1000
  t <- 0
  while(!quit) {
    updateSurface(t)
    while(SDL_PollEvent(evt)) {
      if ( evt$type == SDL_QUIT ) quit <- TRUE
    }
    now <- SDL_GetTicks() / 1000
    t <- now - base
  }
}
init()
mainloop()
}
}
\keyword{programming}
\keyword{interface}


