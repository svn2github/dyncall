\name{rdyncall}
\docType{package}
\alias{rdyncall}
\alias{dyncall}
\alias{rdyncall-package}
\title{Dynamic foreign library interface framework}
\description{  
Improved foreign function interface and framework for portable
dynamic binding of shared libraries including type information.
}
\details{
\pkg{rdyncall} provides a framework to make lightweight interfaces
between R and shared libraries work in a portable way.

R interfaces to C libraries such as OpenGL, libSDL and expat are 
available out-of-the-box. See \command{\link{dynport}} for details.

allow to interface with the functions, constants, structures and 
unions in R.

In addition, utility functions are available to work with C low-level types.

At the core, it provides a flexible foreign function interface based on
the \emph{dyncall C library}. 
}
\section{Getting Started}{
Several demos are available. And two vignettes acompany this release.
Please make sure, you have installed the shared libraries.
}
\section{Applications}{
The applications are manifold. One can use this package to get access 
to OpenGL for 3D Graphics and SDL for controlling multimedia devices 
(Video, Audio, User-Input). See \command{\link{dynport}} for details.  
}
\section{Overview}{
\itemize{
\item Dynamic ports to open-standard libraries such as libSDL and OpenGL. union types. See details at \code{\link{dynport}}.
\item Flexible Foreign function interface for R with support for 
     a wide range of C types and multiple calling conventions. See \code{\link{.dyncall}}.
\item Managed unloading of shared library. See \code{\link{.dynload}}.
\item Locating shared libraries. See \code{\link{dynfind}}.
\item Dynamic binding of shared library functions and function pointers in R. See \code{\link{dynbind}}.
\item Working with C low-level and aggregate types (structs and unions). See \code{\link{packing}} and \code{\link{cstructs}}.
\item Wrapping R functions as C function pointers to be used in C callbacks. See \code{\link{new.callback}}. 
}
}
\section{Platform portability notes}{

Windows:\cr
Tested on 32-bit R on Windows XP. In principle would run on X64. Supports Microsoft Visual C++ dynamic bindings as well.

\cr
Mac OS X:\cr
Tested on 32-bit R on OS X 10.4 and 10.5. Runs on PPC32 and X86 architectures. 
Has not been tested on 64-bit Mac OS X R Version. Should work in principle.
Has not been tested on PPC 64-bit and probably won't work there.

When using libSDL, make sure you are in the Cocoa Environment of R for Mac OS X.

\cr
Linux:\cr

Tested on Ubuntu and Gentoo. Runs on PPC32, X86 and X64 architectures. 

\cr
FreeBSD:\cr

Tested on FreeBSD 5.0 and 7.0 on X86. Should run on X64 and PPC32 as well.

\cr
Solaris:\cr

Not tested yet. In theory should work on X86, X64 and PPC32.

\cr
Game consoles:\cr

R has not been ported yet. The dyncall C library has been ported to
Playstation Portable (MIPS) and Nintendo DS (ARM).

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


