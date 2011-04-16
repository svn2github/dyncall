\name{callback}
\alias{new.callback}
\alias{callback}
\alias{dyncallback}
\title{Dynamic wrapping of R functions into C callbacks}
\description{  
Dynamic wrapping of R functions as C callback function pointers.
}
\usage{
new.callback( signature, fun, envir = new.env() )
}
\arguments{
  \item{signature}{character string specifying the \link[=signature]{call signature} of the C function callback type.}
  \item{fun}{R function to be wrapped as a C function pointer.}
  \item{envir}{the environment for evaluating \emph{foreign callback} calls to \code{fun}. }
}
\details{
Callbacks are user-defined functions that are registered in a foreign library and that are executed at a later time from within that library.
Examples include user-interface event handlers that are registered in GUI toolkits, and, comparision functions passed to generic sort algorithm when sorting a vector of a custom data type.

The function \code{new.callback} wraps an R function \code{fun} as a C function pointer with a function type \link{call signature} given by \code{signature}.

When the C function pointer is called, a callback handler is executed that dynamically creates a call expression to \code{fun}
using the arguments passed from C and converted to R according to the argument types signature within the \link{call signature} specified.
Finally, the handler evaluates the call expression within the environment given by \code{envir} and converts back any return values from R to C according to the return tyope specified in the \link{call signature}.
If an error occurs during the evaluation, the callback will be disabled for further invocations (a behaviour that might change in future releases).

}
\value{
\code{new.callback} returns an external pointer to a synthetically generated C function that can be registered as a C callback.
}

\section{Portability}{
The implementation is based on the \emph{dyncallback} library (part of the DynCall project).
Currently, the library has support for the following processor architectures: X86, X64, PowerPC 32-bit and ARM; 
It has been ported to the following OSs: Linux, Windows, Mac OS X and BSD derivates.
The port to Linux/BSD on PowerPC is currently unstable. (MacOS X/Darwin on PowerPC 32-bit works fine!)
}
\note{
The call signature \strong{MUST} match the foreign C callback function type, otherwise an activated callback call from C can lead to a \strong{fatal R process crash}.

A small amount of memory is allocated with each wrapper. A finalizer that cleans up the memory is registered with every external pointer returned by \code{new.callback}.
If the external callback function pointer is registered in a C library, a reference should also be held in R as long as the callback might get activated from C, otherwise the garbage collector might call the
finalizer and the next invocation of the callback could lead to a \strong{fatal R process crash} as well.
}

\references{
  Adler, D., Philipp, T. (2008) \emph{DynCall Project}. 
  \url{http://dyncall.org}
}
\seealso{
See \code{\link{signature}} for details on call signatures.
}
\examples{

# Create a function, wrap it to a callback and call it via .dyncall:
f <- function(x,y) x+y
cb <- new.callback("ii)i", f)
r <- .dyncall(cb, "ii)i", 20, 3)

# Sort vectors directly via 'qsort' C library function using an R callback:
dynbind(c("c","msvcrt"), "qsort(piip)v;")
cb <- new.callback("pp)i",function(px,py){  
  x <- .unpack(px, 0, "d")
  y <- .unpack(py, 0, "d")
  if (x >  y) return(1) else if (x == y) return(0) else return(-1)
})
x <- rnorm(100)
qsort(x,length(x),8,cb)

}
\keyword{programming}
\keyword{interface}
