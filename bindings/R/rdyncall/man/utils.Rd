\name{utils}
\alias{align}
\alias{.addrval}
\alias{is.externalptr}
\alias{is.nullptr}
\alias{offsetPtr}
\title{Low-level utility functions to work with C pointers.}
\description{Functions for low-level operations on C pointers.}
\usage{
.addrval(x)
is.externalptr(x)
is.nullptr(x)
offsetPtr(x,offset)
floatraw(n)
as.floatraw(x)
floatraw2numeric(x)
as.extptr(x)
}
\arguments{
\item{x}{An R object.}
\item{n}{Number of elements to allocate.}
\item{offset}{An integer scalar specifying the offset.}
}
\details{
\code{.addrval} returns an external pointer to the given R object.

\code{is.nullptr} can be applied to external pointers and tests if it
is set to a C \code{NULL} pointer. 

\code{is.externalptr} tests if the object is an external pointer.

\code{offsetPtr} takes an external pointer as input and displaces the pointer
by offset bytes and returns an external pointer holding the displaced address.   

\code{floatraw} creates a array to store floats backed by a raw vector.
\code{as.floatraw} coerces a numeric vector into a single-precision float vector backed by a raw vector.
All values are converted to float and stored in the R raw vector. This is used to 
pass R vectors via a float pointer in to C code via \code{.dyncall}.

\code{floatraw2numeric} 

}
\keyword{programming}
\keyword{interface}
