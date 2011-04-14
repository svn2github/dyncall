\name{dynport}
\alias{dynport}
\alias{dynports}
\alias{loadDynportNamespace}
\title{Dynamic binding of C APIs and shared libraries.}
\description{Function to dynamically bind C APIs and shared libraries via dynamically
created wrappers for foreign function calls, symbolic constants and data types.
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
A \emph{Dynport} is a binding specification for a particular C Libraries that serves as the description for 
creating dynamic wrapper interfaces.

When loading a \emph{Dynport} via function \code{dynport}, a virtual R name space is installed and populated with lightweight R wrappers of C entities 
(functions, object-like macro defines, constants...).

An initial repository of \emph{Dynports} for a selection of common C libraries such as Expat, SDL and OpenGL is pre-installed with the package.
The following dynports are available and have been tested on multiple platforms:

\tabular{ll}{
\strong{dynport} \tab \strong{Description}                    \cr
\code{SDL}       \tab Simple DirectMedia Layer library        \cr
\code{SDL_image} \tab Loading of image files (png,jpeg..)     \cr
\code{SDL_mixer} \tab Loading/Playing of ogg/mp3/mod music files.\cr
\code{SDL_ttf}   \tab Loading/Rendering of True Type Fonts.   \cr
\code{GL}        \tab OpenGL 1.1 API                          \cr
\code{GLU}       \tab OpenGL Utility Library                  \cr
\code{glew}      \tab OpenGL Extension Wrangler (OpenGL 3.0)  \cr
\code{expat}     \tab Expat XML Parser Library                \cr
\code{R}         \tab R shared library                        \cr
\code{ode}       \tab Open Dynamics (Physics-) Engine         \cr
\code{cuda}      \tab NVIDIA Cuda                             \cr
\code{opencl}    \tab OpenCL                                  \cr
\code{stdio}     \tab C Standard Library I/O Functions        \cr
}

Dynports rely on pre-installed shared libraries on the host system. The installation 
procedure for installation of shared libraries depends on the Operating System.
In general, \code{dynport} needs to locate the binaries which is carried out by \code{\link{dynfind}}.

Many portable C libraries can be regarded as reusable software components ; applicable in universal contexts providing
a generic service such as 3D graphics rendering, sound processing, abstraction to hardware and the like.
A C compiler and R binding C code is usually needed to make use of such a library within the R interpreter.
\code{dynport} attempts to wrap the granular functionality provided by a C API using a dynamic binding approach that
works across multiple platforms:
To offer the services of a C library dynamically at run-time without compilation, it is not enought to load the shared library and
resolve symbols. In order to work with a C API from within dynamic interpreters such as R, 
additional meta-information is needed to create type-safe foreign function call wrappers, handle aggregate data types 
and use symbolic constant values ; this is usually defined in C header files.

\emph{Dynport} files contain a compressed text-based and portable representation of such information.
This dynamic installation procedure is driven by R scripts located in \file{R_HOME/library/rdyncall/dynports}.

At the current stage of development of the framework, the \emph{dynport} files are R scripts where a large portion consists of 
\code{\link{signature}} information. 

  
A tool suite is in development to extract these informations from C headers automatically.
It was used to generate the initial repository of dynports. 
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

