\name{callback}
\alias{callback}
\alias{new.callback}
\title{Wrap R functions info C callback function pointers.}
\description{  
Wraps R functions into C callback function pointers.
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
An external pointer to be used as a opaque C function pointer in the context of a C callback.
}
\details{
C callbacks are function pointers that are registered and executed from within a C context. 
This function allows to wrap an R function into a C callback and reveals an 
opaque external pointer which can be registered later as a C callback.
It is crucial to know the C callback function type to specify the arguments and return types
using a signature, analogue to the foreign function interface. A callback function signature 
specifies the expected arguments.
}
\note{
This feature is ported to x86, x64 and arm architectures.
A port to PowerPC 32-bit is currently in development. 
}
\references{
  Adler, D., Philipp, T. (2008) \emph{DynCall Library}. 
  \url{http://dyncall.org}
}
\author{
  Daniel Adler \email{dadler@uni-goettingen.de}
}
\seealso{
See \code{\link{signature}} for details on call signatures.
\code{\link{getNativeSymbolInfo}} and \code{\link{dynfind}}. 
\code{\link{.C}},\code{\link{.Call}},,\code{\link{.External}}
}
\keyword{programming}
\keyword{interface}
