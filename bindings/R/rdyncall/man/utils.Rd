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
}
\arguments{
\item{x}{An R object.}
\item{offset}{An integer scalar specifying the offset.}
}
\details{
\code{.addrval} returns an external pointer to the given R object.

\code{is.nullptr} can be applied to external pointers and tests if it
is set to a C \code{NULL} pointer. 

\code{is.externalptr} tests if the object is an external pointer.

\code{offsetPtr} takes an external pointer as input and displaces the pointer
by offset bytes and returns an external pointer holding the displaced address.   

}
\keyword{programming}
\keyword{interface}
