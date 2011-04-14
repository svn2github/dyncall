\name{utils}
\alias{is.nullptr}
\alias{align}
\alias{.addrval}
\alias{is.externalptr}
\alias{offsetPtr}
\alias{floatraw}
\alias{as.floatraw}
\alias{floatraw2numeric}
\alias{as.extptr}
\alias{ptr2str}
\alias{strarrayptr}
\alias{strptr}
\title{Low-level utility functions to work with C pointers.}
\description{Functions for low-level operations on C pointers.}
\usage{
is.nullptr(x)
.addrval(x)
is.externalptr(x)
offsetPtr(x,offset)
floatraw(n)
as.floatraw(x)
floatraw2numeric(x)
as.extptr(x)
ptr2str(x)
strarrayptr(x)
strptr(x)
}
\arguments{
\item{x}{An R object.}
\item{n}{Number of elements to allocate.}
\item{offset}{An integer scalar specifying the offset.}
}
\details{
\code{is.nullptr} can be applied to external pointers and tests if it
is set to a C \code{NULL} pointer. 

\code{.addrval} returns an external pointer to the given R object.

\code{is.externalptr} tests if the object is an external pointer.

\code{offsetPtr} takes an external pointer as input and displaces the pointer
by offset bytes and returns an external pointer holding the displaced address.   

\code{floatraw} creates an array to store \code{n} floats implemented by a raw vector.
\code{as.floatraw} coerces a numeric vector into a single-precision float vector backed by a raw vector.
All values are converted to float and stored in the R raw vector. This is used to 
pass R vectors via a float pointer to C code via \code{.dyncall}.

\code{floatraw2numeric} coerces a C float raw vector to a numeric vector.

\code{ptr2str}, \code{strarrayptr}, \code{strptr} are currently experimental.

}
\keyword{programming}
\keyword{interface}
