\name{rdyncall}
\docType{package}
\alias{rdyncall}
\alias{rdyncall-package}
\title{Dynamic C Library Binding Framework using a flexible Foreign Function Interface}
\description{A framework for flexible interoperability with precompiled code and binding of common C Libraries and APIs to R using dynamic wrappers. 
  The FFI supports all fundamental C types, multiple calling conventions, handling of struct/union C data types and wrapping of R functions into C callback function pointers. 
  The package comes with an initial repository of ready-to-use bindings to common libraries such as OpenGL, SDL, Expat, etc.. . 
  Library bindings work across platform using a compact plain text specification format ; a tool is in development that automatically generates bindings from C header files.
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

mainly based on the \emph{dyncall} C library ; a Foreign Function Interface library with support for multiple calling conventions
with a state machine to prepare argument loading and small generic call kernels written in Assemly (around 64 bytes for x86) to invoke arbitrary code. 
The library has been ported to X86, X64, ARM (including thumb), has been ported all major R platforms.
It is very small in size (the core call kernel for x86 fits into 64 bytes), and provides the flexibility to call arbitrary functions with support for the full range of C types and multiple calling conventions.
C Callbacks are wrapped via the \emph{dyncallback} C library.
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


