\name{callback}
\alias{callback}
\alias{new.callback}
\alias{dyncallback}
\title{Dynamic wrapping of R functions into C callbacks.}
\description{  
Dynamic wrapping of R functions into C callbacks.
}
\usage{
new.callback( signature, fun, envir = new.env() )
}
\arguments{
  \item{signature}{a character string specifying the \link[=signature]{call signature} of the C function callback type.}
  \item{fun}{the function to be wrapped into a C function pointer.}
  \item{envir}{the environment in which \code{fun} is to be evaluated (when it gets called from within C context).}
}
\details{
C callbacks are function pointers that are registered and executed from within a C context. 
The function \code{new.callback} wraps an R functions given by \code{fun} into a C function object 
specified by \link{callback signature} \code{signature}. The returned external pointer
can be registered as a C callback.
}
\value{
An external pointer to be used as a C function pointer in the context of a C callback registration.
}

\section{Portability}{
The implementation is based on the \emph{dyncallback} library (part of the DynCall project).
Currently, the library has support for the following processor architectures: X86, X64, PowerPC 32-bit and ARM; 
It has been ported to the following OSs: Linux, Windows, Mac OS X and BSD derivates.
The port to Linux/BSD on PowerPC is currently unstable. (MacOS X/Darwin on PowerPC 32-bit works fine!)
}
\note{

The callback signature \strong{MUST} match the foreign C callback function type, otherwise an activated callback call from C can lead to a \strong{fatal R process crash}.

If the number of arguments given with the R function does not match with the callback type information, 
R will signal a non-fatal error (similar to what happens when calling an R function with a wrong number of arguments or dynamic type mismatches).

}

\references{
  Adler, D., Philipp, T. (2008) \emph{DynCall Library}. 
  \url{http://dyncall.org}
}
\seealso{
See \code{\link{signature}} for details on call signatures.
}
\examples{
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
