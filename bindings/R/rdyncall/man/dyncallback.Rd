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
  \item{signature}{Character string specifying the expected \link[=signature]{call signature} of the C callback.}
  \item{fun}{R function to be wrapped into a C function pointer.}
  \item{envir}{Environment to be used for evaluating the function when called from within C context.}
}
\details{
C callbacks are function pointers that are registered and executed from within a C context. 
The function \code{new.callback} enables dynamic wrapping of R functions into a C function object that
can be registered later as a C callback.
The callback \code{signature} should match the type of the C function callback 
which is later used for registration.
}
\value{
An external pointer to be used as a C function pointer in the context of a C callback registration.
}
\note{
The implementation is based on the \emph{dyncallback} library (part of the DynCall project).
The library has been ported to X86, X64, PowerPC 32-bit and ARM Processor Architectures and
has been successfully tested on Linux, Windows, Mac OS X, BSD derivates and iPhone.
On PowerPC, the Mac OS X / Darwin port works fine, while the System V ABI (Linux/BSD) is
currently unstable. For MIPS a port is in development.
}
\references{
  Adler, D., Philipp, T. (2008) \emph{DynCall Library}. 
  \url{http://dyncall.org}
}
\seealso{
See \code{\link{signature}} for details on call signatures.
}
\examples{
# Sort vectors directly via 'qsort' C library function:

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
