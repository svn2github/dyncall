\name{dynport}
\alias{dynport}
\alias{loadDynportNamespace}
\title{Bindings of standard and common C libraries for R}
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
The \code{dynport} function dynamically creates and attaches R interface packages populated with
thin wrappers to C functions, object-like macros, enums and data types.

The \code{dynport} function dynamically creates and attaches an R interface package.
The interface package is populated with wrapper R objects to entities of the C API (functions, type information,...).
The aim is to have a familiar look and feel of the C API within R.

Dynports rely on pre-installed shared libraries on the host system. The installation 
procedure for installation of shared libraries depends on the Operating System - for
details on this see \link{rdyncall-demos}.

An initial repository of \emph{DynPorts} to the following C libraries is installed together with the package:

\tabular{ll}{
\strong{C Library} \tab \strong{Description}                    \cr
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

\emph{Dynport} files contain a compressed text-based and portable representation of such information.
This dynamic installation procedure is driven by R scripts located in \file{R_HOME/library/rdyncall/dynports}.


% An initial repository of \emph{Dynports} for a selection of common C libraries such as Expat, SDL and OpenGL is pre-installed with the package.
% \emph{DynPort} specifications, which consist of \link{signature} represent platform-portable type and data information about C APIs

%  provides direct access to a selection of standard and common C APIs using a purely dynamic
% binding approach. For each C API offered by so called \emph{Dynport} files stored in a repository that comes with the package,
% \code{dynport} dynamically loads the particular C library and installs a virtual R interface package populated with
% wrappers to the C library.

%  Background: Many common and portable C libraries can be regarded as reusable software components ; applicable in universal contexts providing
% a generic service such as 3D graphics rendering, sound playing, abstraction to hardware and the like.
% C libraries are not accessible from within scripting languages out-of-the-box, and R bindings often require additional compiled code to
% map a C interface into the R language completely.

% Here kicks in the \emph{DynPort}: Imagine a portable type information format, that specifies the C API on a purely abstract level once,
% and making the API available in several languages a like. This R function is the first prototyp of the idea. A second prototype written
 %for lua is available on the net. Work is on the way for a third-revision of this format, so that almost all elements (including function types, bit-fields, enums etc..) will be available.

At the current stage of development of the framework, the \emph{dynport} files are R scripts where a large portion consists of 
\code{\link{signature}} information. A new revision (available for the Lua language), a language-neutral format has been defined
and will be adopted to within the next release when things got stable.
 
A tool suite (mainly boost wave, GCC-XML, and XSLT) is in development to extract these informations from C headers automatically.
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

%To offer the services of a C library dynamically at run-time without compilation, it is not enought to load the shared library and
%resolve symbols ; additional meta-information is needed to create type-safe foreign function call wrappers, handle aggregate data types 
%and use symbolic constant values. This is usually defined in C header files, but carrying a complete C parser is often too heavy for a
%small and lean middleware solution. In this framework, text-based portable type information signatures are used (see \link{dyntype} for details).
%
%When loading a \emph{Dynport} via function \code{dynport}, a virtual R name space is installed and populated with lightweight R wrappers of C entities 
%(functions, object-like macro defines, constants...).
%
