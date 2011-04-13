\name{rdyncall}
\docType{package}
\alias{rdyncall}
\alias{rdyncall-package}
\title{Dynamic C Library Binding Framework with a flexible Foreign Function Interface (FFI) (includes cross-platform bindings to OpenGL)}
\description{
The FFI supports all fundamental C types, multiple calling conventions, handling of struct/union C data types and wrapping of R functions as C callback function pointers. 
The Binding Framework offers to bind C Libraries to R via dynamically created name spaces comprising thin wrappers to the C Interface using a portable binding specification format.
The package comes with an initial repository of portable bindings to libraries such as OpenGL, glew, OpenCL and SDL. 
Users are enabled to develop system-level software with R using APIs such as OpenGL directly in R, portable across platforms.
}
\details{
\pkg{rdyncall} is a toolkit that aims to bind Application Programming Interfaces (API)
of shared C library functions, constants, callbacks and types with the R language in a portable way.

The flexible Foreign Function Interface is mainly based on the \emph{dyncall} C library which has been ported all major R platforms.
It is very small in size, and provides the flexibility to call arbitrary functions with support for the full range of C types and multiple calling conventions.
C Callbacks are wrapped via the \emph{dyncallback} C library.
}
\section{Overview}{
\itemize{
\item Calling of precompiled code with support for wide range of C types, flexible mapping type mappings and multiple calling conventions. See \code{\link{.dyncall}}.
\item Searching of shared libraries portably across operating-systems by short names. See \code{\link{dynfind}}.
\item Loading of shared libraries with managed unloading. See \code{\link{.dynload}}.
\item Installation of wrapper functions to shared library code. See \code{\link{dynbind}}.
\item Working with C low-level and aggregate types (structs and unions). See \code{\link{packing}} and \code{\link{struct}}.
\item Wrapping R functions as C function pointers to be used in C callbacks. See \code{\link{new.callback}}. 
\item Dynamic binding of complete shared library functions and interfaces (constants, enums, struct and union types). See \code{\link{dynport}}. 
}
}
\section{Getting Started}{
Several demos are available. Some demos require additional
software to be installed on the system such as SDL. Please make sure, you have installed 
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


