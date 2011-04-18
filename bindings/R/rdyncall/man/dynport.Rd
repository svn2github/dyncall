\name{dynport}
\alias{dynport}
\alias{loadDynportNamespace}
\title{Dynamic R Bindings to standard and common C libraries}
\description{Function to bind APIs of standard and common C libraries to R via dynamically created interface packages
comprising R wrappers for C functions, object-like macros, enums and data types.
}
\usage{
dynport(portname, portfile=NULL,
 repo=system.file("dynports",package="rdyncall") )
loadDynportNamespace(name, portfile, do.attach=TRUE)
}
\arguments{
\item{portname}{the name of a dynport, given as a literal or character string.}
\item{portfile}{character string giving the path to a script file.}
\item{repo}{character string giving the path to the root of the \emph{dynport} repository.}  
\item{do.attach}{logical, if \code{TRUE} the created R name space should be attached as a package in the search path.}
\item{name}{character string specifying the name of a name space.}
}
\details{
\code{dynport} offers a dynamic method for binding common and standard C libraries to R.
The method is data-driven using platform-portable specifications, named \emph{DynPort} files.
In order to use C bindings via \code{dynport}, the pre-compiled shared C library need to be installed in the system.
See \link{rdyncall-demos} for installation notes for several OSs.
 
\emph{DynPort} files are stored in a repository that is delivered and installed as part of the package installation.
The following gives a list of currently available \emph{DynPorts}:
\tabular{ll}{
\strong{DynPort name/C Library} \tab \strong{Description}                        \cr
\code{expat}       \tab Expat XML Parser Library                    \cr
\code{GL}          \tab OpenGL 1.1 API                              \cr
\code{GLU}         \tab OpenGL Utility Library                      \cr
\code{SDL}         \tab Simple DirectMedia Layer library            \cr
\code{SDL_image}   \tab Loading of image files (png,jpeg..)         \cr
\code{SDL_mixer}   \tab Loading/Playing of ogg/mp3/mod music files. \cr
\code{SDL_ttf}     \tab Loading/Rendering of True Type Fonts.       \cr
\code{glew}        \tab OpenGL Extension Wrangler (OpenGL 3.0)      \cr
\code{R}           \tab R shared library                            \cr
\code{ode}         \tab Open Dynamics (Physics-) Engine             \cr
\code{cuda}        \tab NVIDIA Cuda                                 \cr
\code{opencl}      \tab OpenCL                                      \cr
\code{stdio}       \tab C Standard Library I/O Functions            \cr
}

When processing a \emph{DynPort} file given by \code{portname}, an R name space object is created 
and populated with R wrapper and helper objects. 
When \code{do.attach} is \code{TRUE} (default behaviour), the name space is attached to the search path
and the C API becomes accessible.

In the current implementation, \emph{DynPort} files are R scripts with a large
amount of \link{signature} text data.
Up to three different operations are usually performed here:

\itemize{
\item Functions are mapped via \code{dynbind} and a description of the C library using a \emph{library signatures}.
\item Symbolic constants are mapped via R \code{assign} expressions.
\item Aggregate Data Types are registred via via \code{parseStructInfos} and \code{parseUnionInfos}.
}

A tool suite, comprising of boost wave, GCC-XML, and XSLT, was used to generate the \emph{DynPort} files automatically
by extracting type information from original C header files. 
}
\references{
  Adler, D., Philipp, T. (2008) \emph{DynCall Project}. \cr 
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
# Flip Double-Buffer
SDL_GL_SwapBuffers()
}
}
\keyword{programming}
\keyword{interface}

