\name{dynport}
\alias{dynport}
\alias{dynports}
\alias{loadDynportNamespace}
\title{Dynamic binding of binary components on multiple platforms}
\description{Dynports aims to provide cross-platform portable bindings from dynamic environments to statically compiled binary components. The development is in early stage.}
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
\emph{dynport} is a new project to design a repository network of meta-
informations for multi-platform binary shared library components. It is 
currently in incubation phase. 

The front-end function \code{dynport} runs a script file in a newly created
namespace. Typically the script instructs rdyncall to dynamically link 
against shared libraries and binds pre-compiled functions to the R run-time 
process.

Here's a list of currently available packages:

\tabular{ll}{
\strong{DynPort} \tab \strong{Description}        \cr
\code{SDL}       \tab Simple Direct Layer library \cr
\code{SDL_image} \tab SDL Image Library           \cr
\code{GL}        \tab OpenGL 1.1 API              \cr
\code{GLU}       \tab OpenGL Utility Library      \cr
\code{glew}      \tab OpenGL Extension Wrangler   \cr
\code{expat}     \tab Expat XML Parser Library    \cr
\code{ode}       \tab Open Dynamics (physics-) Engine \cr
\code{R}         \tab R shared library            \cr
}

Under the rdyncall package directory installed in R_HOME/library/rdyncall is a sub-directory
named \code{dynports} which contain dynport files for several shared libraries.
If something does not work, keep in mind, this feature is still
alpha - we are happy for feedback and bug reports.
}
\examples{

\donttest{
# Appetizer: SDL and OpenGL

dynport(SDL)
dynport(GL)

SDL_Init(SDL_INIT_VIDEO)
SDL_SetVideoMode(320,256,32,SDL_OPENGL+SDL_DOUBLEBUF)
glClearColor(0,0,1,0) # blue
glClear(GL_COLOR_BUFFER_BIT)
SDL_GL_SwapBuffers()
}
}
\keyword{programming}
\keyword{interface}

