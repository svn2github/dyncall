\name{callback}
\alias{callback}
\alias{new.callback}
\alias{dyncallback}
\title{Dynamic wrapping of R functions into C callbacks.}
\description{  
Dynamic wrapping of R functions into C callbacks.
}
\usage{
new.callback( signature, fun, envir )
}
\arguments{
  \item{signature}{Character string specifying the expected \link[=signature]{call signature} of the C callback.}
  \item{fun}{R function to be wrapped into a C function pointer.}
  \item{envir}{Environment to be used for evaluating the function when called from within C context.}
}
\value{
An external pointer to be used as a C function pointer in the context of a C callback registration.
}
\details{
C callbacks are function pointers that are registered and executed from within a C context. 
The function \code{new.callback} enables dynamic wrapping of R functions into a C function object that
can be registered later as a C callback.

returns an external pointer that can be registered later as a plain C callback. 
It is important to know the expected C function type in order to specify the 
arguments and return types using a \link{signature}, analogous to the 
foreign function interface of \code{\link{.dyncall}}. 
}
\note{
The implementation is based on the \emph{dyncallback} library (part of the DynCall project).
The library has been ported to X86, X64, PowerPC 32-bit and ARM Processor Architectures and
has been successfully tested on Linux, Windows, Mac OS X, BSD derivates and iPhone.
The PowerPC 32-bit port is considered unstable. For MIPS a port is in development.
}
\references{
  Adler, D., Philipp, T. (2008) \emph{DynCall Library}. 
  \url{http://dyncall.org}
}
\seealso{
See \code{\link{signature}} for details on call signatures.
}
\keyword{programming}
\keyword{interface}
