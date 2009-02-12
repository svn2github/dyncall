\name{dynport}
\alias{dynport}
\alias{dynports}
\title{Dynamic ports to shared libraries}
\description{Dynamic ports to shared libraries.}
\usage{
dynport(name)
detach("dynport:name")
}
\arguments{
\item{name}{The name of a \emph{dynport} package, given as a name or literal character string, or a character string.}
}
\details{
The \code{dynport} function dynamically links and binds code to the R run-time process and
binds as an environment with thin R wrapper functions and constants. 
Here's a list of currently available packages:
\tabular{lll}{
\strong{DynPort} \tab \strong{Description}        \tab \strong{Platforms} \cr
\code{gl}        \tab OpenGL 1.1 API              \tab multi-platform \cr
\code{glu}       \tab OpenGL Utility Library      \tab multi-platform \cr
\code{sdl}       \tab Simple Direct Layer library \tab multi-platform \cr
\code{rmalloc}   \tab R Memory Allocation         \tab R platforms \cr 
}
}
\examples{

\donttest{
# Appetizer: SDL and OpenGL

dynport(sdl)
dynport(gl)

SDL_Init(SDL_INIT_VIDEO)
SDL_SetVideoMode(320,256,32,SDL_OPENGL+SDL_DOUBLEBUF)
glClearColor(0,0,1,0) # blue
glClear(GL_COLOR_BUFFER_BIT)
SDL_GL_SwapBuffers()
}
}

\section{The Dynports Project}{
\emph{dynport} is a new project to design a repository network of meta-informations for 
multi-platform binary shared library components. It is currently in incubation phase. 
Binding a library for scripting languages can be tedious. The dynamic binding concept of 
the dyncall library enables us to bind shared library code at run-time without any additional C glue code
per library.
When adding dyncall (and dynload) to a scripting language binding, the dynamic calling of
functions is made available to the scripting language.
 
Under the rdyncall package directory installed in R_HOME/library/rdyncall is a sub-directory
named \code{dynports} which contain meta-information to link a shared library component.
}
\keyword{interface}
\keyword{programming::interface}

