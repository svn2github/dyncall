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
}
\arguments{
\item{portname}{the name of a dynport, given as a literal or character string.}
\item{portfile}{\code{NULL} or character string giving a script file to parse ; \code{portname} and \code{repo} are .}
\item{repo}{character string giving the path to the root of the \emph{dynport} repository.}  
}
\details{
\code{dynport} offers a convenient method for binding entire C libraries to R.
This mechanism runs cross-platform and uses dynamic linkage. This means,
the run-time library of a choosen binding need to be installed in the system.
Depending on the OS, some libraries, supported by \code{dynport}, are 
already installed, but others might need manual intervention. 
See \link{rdyncall-demos} for OS-specific installation notes.

The binding method is data-driven using platform-portable specifications, named \emph{DynPort} files.
\emph{DynPort} files are stored in a repository that is delivered and installed as part of the package installation.
When \code{dynport} processes a \emph{DynPort} file given by \code{portname}, 
an R name space object is created and populated with R wrapper and helper objects
that implement the interface between R and C. 

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
\code{glew}        \tab OpenGL Extension Wrangler (includes OpenGL 3.0) \cr
\code{gl3}         \tab strict OpenGL 3 (untested)                  \cr
\code{R}           \tab R shared library                            \cr
\code{ode}         \tab Open Dynamics (Physics-) Engine (untested)  \cr
\code{cuda}        \tab NVIDIA Cuda (untested)                      \cr
\code{opencl}      \tab OpenCL (untested)                           \cr
\code{stdio}       \tab C Standard Library I/O Functions            \cr
}

As of the current implement, \emph{DynPort} files are actually R scripts
that perform basically three things:

\itemize{
\item Functions (and pointer-to-function variables) are mapped via \code{\link{dynbind}} and a description of the C library using a \emph{library signatures}.
\item Symbolic names are assigned to its values for object-like macro defines and C enum types.
\item Run-time type-information objects for aggregate C data types (struct and union) are registered via \code{\link{parseStructInfos}} and \code{\link{parseUnionInfos}}.
}

The file path to the \emph{DynPort} file is derived from
\code{portname} per default. This would refer to \code{"<repo>/<portname>.R"} 
where  \code{repo} usually refers to the initial \emph{DynPort} repository
located at the sub-folder \code{"dynports/"} of the package.
If \code{portfile} is given, then this value is taken as file path (usually
for testing purpose).

A tool suite, comprising boost wave, GCC-XML, and XSLT, was used to generate the available \emph{DynPort} files automatically
by extracting type information from C library header files. 

In a future release, the DynPort format will be changed to
a language-neutral document. For the interested reader: 
A first prototyp is currently available in an FFI extension to the Lua 
programming language (see \code{luadyncall} subversion sub-tree).
A third revision (including function types in call signatures, bitfields, arrays, etc..)
is currently in development.
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

