\name{rdyncall}
\docType{package}
\alias{rdyncall}
\alias{rdyncall-package}
\title{Dynamic Bindings to common C Libraries based on a flexible Foreign Function Interface}
\description{
This package gives direct access to common C Libraries and comes with
a repository of cross-platform bindings to OpenGL, SDL, Expat, OpenCL, CUDA etc..
The approach is radically new and experimental using abstract text-based
type information specification per library and a new Foreign Function Interface.
The FFI is usable stand-alone and offers several advantages that 
A framework of low-level tools for dynamic interoperability with foreign C code and data types.
For application developers, the package offers a dynamic method to bind 
and access the Application Programming Interface (API) of C libraries.
This method works cross-platform using a single compact plain-text
specification per C Library.
A new Foreign Function Interface is the work-horse of this binding approach
and can be used stand-alone as well.
Almost any C function can be called via the new FFI, supports all 
fundamental C types, multiple calling conventions and 
A framework for handling of foreign C fundamental and aggregate data types 
is provided as well as wrapping of R functions into C callback function pointers. 
The package comes with an initial repository of ready-to-use bindings to common libraries such as OpenGL, SDL and Expat and includes
lots of demonstrations how to program with the R language using C libraries via this middleware technology.
Library bindings work across platforms using a compact plain text specification format ; a tool is development that automatically generates these cross-platform binding specifications from C header files.
The package enables developers to write cross-platform system-level software without additional wrapper C code by using C APIs such as OpenGL directly in R.
}
\details{
\pkg{rdyncall} is a toolkit that aims to bind Application Programming Interfaces (API)
of shared C library functions, constants, callbacks and types dynamically at run-time to the R interpreter 
using a portable description format for each library.
This enables developers to use low-level C libraries designed as a service component to be used from within R without
additional compilation of C wrapper code (which is usually the case).
The pure dynamic approach makes R packages much easier to distribute, as no additional compilation code is required.

The package is based on libraries from the DynCall project which are ported across many processor architectures and platforms.

The flexible Foreign Function Interface is an alternative FFI that has no limitations regarding arity, supports multiple calling conventions
and almost all C types as argument and return-type.
In addition, the package supports handling of C \code{struct} and \code{union} data types including managed allocation and symbolic access to field members.
}
\section{Overview}{
\itemize{
\item Flexible FFI with support for most C types, type-safety checks and multiple calling conventions. See \code{\link{.dyncall}}.
\item Searching for Shared Libraries across platforms by short names. See \code{\link{dynfind}}.
\item Loading of shared libraries with automatic garbage-collector controlled unloading. See \code{\link{.dynload}}.
\item Dynamic creation of call wrappers to foreign code. See \code{\link{dynbind}}.
\item Handling of foreign C struct/union data types. See \code{\link{packing}} and \code{\link{struct}}.
\item Dynamic wrapping of R functions as C function pointers to be used in C callbacks. See \code{\link{new.callback}}. 
\item Dynamic binding of C Libraries and APIs (functions, variables, macro constants, enums, struct and union types). See \code{\link{dynport}}. 
}
}
\section{Getting Started}{
Several demos ranging from simple calls to the C standard library up to are available. Some demos require additional software to be installed.
software to be installed on the system such as SDL. Please make sure, you have installed 
the shared libraries.
}
\section{Applications}{
The package can be used to get direct access to system services such as 
OpenGL for 3D Graphics. The SDL library can be used for controlling multimedia 
devices (Video, Audio, User-Input) in a portable way. 
See \command{\link{dynport}} for details.  
}
\section{Portability}{

The package includes a fairly important amount of middleware low-level code,
including Assembly for various processors. 
The following architectures are considered to be stable: X86, X64, PowerPC, ARM, MIPS.
Regarding \link{callback} support, the PowerPC on Darwin is stable, while on ELF platform (using System V), dyncallback support is experimental.

Regarding the \link{dynport} mechanism, several demos that stress-test this mechanism have been tested. 

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


