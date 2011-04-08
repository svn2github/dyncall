\name{dynport}
\alias{dynport}
\alias{dynports}
\alias{loadDynportNamespace}
\title{Dynamic bindings to C APIs and shared libraries.}
\description{Dynports provide the ability to bind popuplar C Libraries 'as-is' to R across platforms.
}
\usage{
dynport(portname, portfile=NULL, repo=system.file("dynports",package="rdyncall") )
loadDynportNamespace(name, portfile, do.attach=TRUE)
}
\arguments{
\item{portname}{the name of a dynport, given as a literal or character string.}
\item{portfile}{character string giving the path to a script file for debugging/development purpose.}
\item{repo}{character string giving the path to the dynport script repository.}  
\item{do.attach}{Logical, if \code{TRUE} the created R namespace should be attached as a package in the search path.}
\item{name}{character string specifying the name of a namespace.}
}
\details{
\code{dynport} offers to binding \emph{entire} C APIs and libraries dynamically to the R interpreter in a portable
manner. 
A repository of \emph{Dynports} to popular C libraries such as Expat, SDL and OpenGL is pre-installed with the package.

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

When loading a \emph{Dynport}, a virtual R name space is installed and populated with lightweight R wrappers to C entities of the corresponding C API.
This dynamic installation procedure is driven by R scripts located in \file{R_HOME/library/rdyncall/dynports}.
Bindings are specified once per library in a portable text format called a \emph{Dynport}.

At the current stage of development of the framework, the \emph{dynport} files are R scripts where a large portion simple consists of 
\code{\link{signature}} information.

\emph{Dynport}s are driven by R scripts located in 
Keep in mind: Dynports need pre-installed binaries on your system. The installation 
procedure depends on your Operating System. In general, dynport need to locate the binaries which is carried out by \code{\link{dynfind}}.
  
It is executed in a fresh R namespace context. The script loads shared libraries. 
It binds functions and function pointers, assigns constants and enum, and registers 
C union and structure data types.

A tool suite is in development to extract these informations from C headers automatically.
It was successfully used to generate the available dynports. In case, you are in need to
have a specific binding for R, feel free to contact the package author. 

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

