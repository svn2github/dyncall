\name{utils}
\alias{is.nullptr}
\alias{as.extptr}
\alias{is.externalptr}
\alias{floatraw}
\alias{as.floatraw}
\alias{floatraw2numeric}
\alias{ptr2str}
\alias{strarrayptr}
\alias{strptr}
\title{Low-level utility functions to work with C pointer and data types.}
\description{Functions for low-level operations on C pointers as well as
helper functions and object for working with C \code{float} arrays and strings.}
\usage{
is.nullptr(x)
as.extptr(x)
is.externalptr(x)
floatraw(n)
as.floatraw(x)
floatraw2numeric(x)
ptr2str(x)
strarrayptr(x)
strptr(x)
}
\arguments{
\item{x}{an R object.}
\item{n}{number of elements to allocate.}
}
\details{

\code{is.nullptr} tests if external pointers represent C \code{NULL} pointers.

\code{as.extptr} returns an external pointer to the data area of atomic
vector given by \code{x}. The external pointer holds an additional reference 
to the \code{x} R object to prevent it from garbage collection.

\code{is.externalptr} tests if the object given by \code{x} is an external pointer.

\code{floatraw} creates an array with a capacity to store \code{n} single-precision C \code{float} values.
The array is implemented via a \code{\link[base]{raw}} vector.

\code{as.floatraw} coerces a numeric vector into a single-precision C \code{float} vector.
Values given by \code{x} are converted to float and stored in the R raw vector via \code{.pack}. 
This function is useful to pass R vectors via a C \code{float} pointer to C code via \code{.dyncall}.

\code{floatraw2numeric} coerces a C \code{float} (raw) vector to a numeric vector.

\code{ptr2str}, \code{strarrayptr}, \code{strptr} are currently experimental.

}
\value{
A logical value is returned by \code{is.nullptr} and \code{is.externalptr}.
\code{as.extptr} returns an external pointer value.
\code{floatraw} and \code{as.floatraw} return an atomic vector of type \code{raw}
tagged with class \code{'floatraw'}.
\code{floatraw2numeric} returns a \code{numeric} atomic vector.
}
\keyword{programming}
\keyword{interface}
