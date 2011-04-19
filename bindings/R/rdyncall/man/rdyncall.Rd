\name{rdyncall}
\docType{package}
\alias{rdyncall}
\alias{rdyncall-package}
\title{Improved Foreign Function Interface (FFI) and Dynamic Bindings to C Libraries (e.g. OpenGL) }
\description{The package provides a platform-portable framework for dynamic binding of 
  C libraries using a flexible Foreign Function Interface (FFI).
  The FFI supports almost all fundamental C types, multiple calling conventions, 
  symbolic access to foreign C struct/union data types and wrapping of R functions 
  as C callback function pointers. 
  Dynamic bindings to shared C libraries are data-driven by cross-platform binding specification 
  using a compact plain text format ; an initial repository of bindings to a couple of 
  common C libraries (OpenGL,SDL,Expat,CUDA,OpenCL,ODE,R) comes with the package.
  Detailed instructions for installation of third-party shared libraries for various OSs 
  and several demos are included.
}
\section{Overview}{
\itemize{
\item Flexible FFI with support for most C types, type-safety checks and multiple calling conventions. See \code{\link{.dyncall}}.
\item Searching for Shared Libraries across platforms by short names. See \code{\link{dynfind}}.
\item Loading of shared libraries with automatic garbage-collector controlled unloading. See \code{\link{.dynload}}.
\item Dynamic creation of call wrappers to foreign code. See \code{\link{dynbind}}.
\item Handling of foreign C struct/union data types. See \code{\link{packing}} and \code{\link{struct}}.
\item Dynamic wrapping of R functions as C function pointers to be used in C callbacks. See \code{\link{new.callback}}. 
\item Dynamic bindings to C Libraries and APIs (functions, variables, macro constants, enums, struct and union types). See \code{\link{dynport}}. 
}
}
\section{Getting Started}{
Several demos ranging from simple FFI calls to the C standard math library up to more complex 3D OpenGL/SDL Applications are available. 
See \code{demos(package="rdyncall")} for an overview.
Some demos require shared C libraries to be installed in the system. Please read \link{rdyncall-demos} for details.
}
\section{Portability}{
The package is based on libraries from the \emph{DynCall} project.
The following architectures are considered to be stable: X86, X64, PowerPC, ARM, MIPS.
Regarding \link{callback} support, the PowerPC on Darwin is stable, while on ELF platform (using System V), dyncallback support is experimental.

Regarding the \link{dynport} mechanism, several demos that stress-test this mechanism have been tested. 

The following Platforms have been reported to work using the demos for basic testing.
Besides that, all platforms passed the \emph{DynCall} test suites within the C source tree. Please see the details on Portability for \link{dyncall}, 
\link{dyncallback} and \link{dynload}.

\itemize{
  \item FreeBSD 8.2/x86: ok.
  \item Linux Distributions:
    \itemize{
      \item Debian {5,6}/x86: ok.
      \item Fedora 14/x86: ok.
    }
  \item Mac OS X 10.4/ppc R-2.10.0: ok.
  \item Mac OS X 10.6/{i386,x64} R-2.12.2: ok.
  \item NetBSD 5.0/x86, 5.1/x64: ok. 
  \item OpenBSD 4.8/x64: SDL demos failed due to pthread (linked in SDL, but not in R in ports tree).
  \item Windows XP/x86: R-2.12.2: ok.
  \item Windows 7/{x86,x64}: ok (64-bit SDL demos: look for the right DLL)
}
}

\references{
  Adler, D., Philipp, T. (2008) \emph{DynCall Project}. 
  \url{http://dyncall.org}
}
\examples{
\donttest{
# multimedia example
# load dynports for OpenGL, Simple DirectMedia library
# globals:
surface <- NULL
# init SDL and OpenGL
init <- function()
{
  dynport(SDL)
  dynport(GL)
  if ( SDL_Init(SDL_INIT_VIDEO) != 0 ) stop("SDL_Init failed")
  surface <<- SDL_SetVideoMode(320,240,32,SDL_DOUBLEBUF+SDL_OPENGL)
  cat("surface dimension:", surface$w, "x",surface$h,sep="")
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

