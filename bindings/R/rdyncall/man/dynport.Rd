\name{dynport}
\alias{dynport}
\alias{dynports}
\alias{loadDynportNamespace}
\title{Dynamic portable interface bindings to shared libraries.}
\description{Dynports aims to provide platform-portable bindings of statically compiled libraries to 
dynamic programming language environments such as R.
The development is in early stage. This is the first prototyp, written in R 
and design for the R environment. Future revisions are planed to incorporate 
other dynamic languages and extend the type system interface.}
\usage{
dynport(portname, portfile=NULL, repo=system.file("dynports",package="rdyncall") )
loadDynportNamespace(name, portfile, do.attach=TRUE)
}
\arguments{
\item{portname}{Symbolic literal or character string specifying a \emph{dynport}.}
\item{portfile}{Character string specifying a script file.}
\item{repo}{Character string specifying a repository of dynport script files.}  
\item{do.attach}{Logical specifying if the loaded dynport namespace should be attached as a package in the search path.}
\item{name}{Character string specifying the name of a namespace.}
}
\details{
The \emph{dynport} project was establish to develop an infrastructure to dynamically bind 
precompiled code with interpreted dynamic programming environments in a portable fashion.
Also it is currently in early stage, it already provides a convenient portable interface 
to \emph{whole shared libraries} on all R platforms without additional glue code in C.   

The following dynports are available and have been tested on multiple platforms:

\tabular{ll}{
\strong{dynport} \tab \strong{Description}        \cr
\code{SDL}       \tab Simple DirectMedia Layer library \cr
\code{SDL_image} \tab SDL Image Library           \cr
\code{SDL_ttf}   \tab SDL True Type Font Rendering \cr
\code{GL}        \tab OpenGL 1.1 API              \cr
\code{GLU}       \tab OpenGL Utility Library      \cr
\code{glew}      \tab OpenGL Extension Wrangler (OpenGL 3.0)  \cr
\code{expat}     \tab Expat XML Parser Library    \cr
\code{ode}       \tab Open Dynamics (physics-) Engine \cr
\code{R}         \tab R shared library            \cr
}

Keep in mind, that you need to pre-install the binaries on your system. The installation 
procedure depends on your Operating System. In general, dynport need to locate the binaries.
See \code{\link{dynfind}} for details on how to find libraries.
  
A dynport is an R script located in \file{R_HOME/library/rdyncall/dynports}.
It is executed in a fresh R namespace context. The script loads shared libraries. 
It binds functions and function pointers, assigns constants and enum, and registers 
C union and structure data types.
A tool suite is in development to extract these informations from C headers automatically.
It was successfully used to generate the available dynports. In case, you are in need to
have a specific binding for R, feel free to contact me. 

}
\references{
  Adler, D., Philipp, T. (2008) \emph{DynCall Library}. \cr 
  \url{http://dyncall.org} \cr
  Clark, J. (1998). expat - XML Parser Toolkit. \cr
  \url{http://expat.sourceforge.net} \cr
  Ikits, M. and Magallon, M. (2002).  The OpenGL Extension Wrangler Library. \cr
  \url{http://glew.sourceforge.net} \cr
  Latinga, S. (1998). The Simple DirectMedia Layer Library. \cr 
  \url{http://www.libsdl.org} \cr
  Segal, M. and Akeley, K. (1992). The OpenGL Graphics System. A Specification, Version 1.0. \cr
  \url{http://www.opengl.org} \cr
  Smith, R. (2001). Open Dynamics Engine. \cr
  \url{http://www.ode.org} \cr
}
\examples{
\donttest{
# Using SDL and OpenGL in R 
dynport(SDL)
dynport(GL)
# Initialize Video Sub-system
SDL_Init(SDL_INIT_VIDEO)
# Initialize Screen with OpenGL Context and Double Buffering
SDL_SetVideoMode(320,256,32,SDL_OPENGL+SDL_DOUBLEBUF)
# Clear Color and Clear Screen
glClearColor(0,0,1,0) # blue
glClear(GL_COLOR_BUFFER_BIT)
# Flip Double-Buffers
SDL_GL_SwapBuffers()
}
}
\keyword{programming}
\keyword{interface}

