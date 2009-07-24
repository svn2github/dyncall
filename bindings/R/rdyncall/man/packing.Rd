\name{packing}
\alias{.pack}
\alias{.unpack}
\title{(Un)-packing of C data types.}
\description{Functions to manipulate C-level arrays and structures from within R.}
\usage{
.pack(x, offset, typesignature, value)
.unpack(x, offset, typesignature)
}
\arguments{
\item{x}{Atomic vector (logical, raw, integer or numeric) or external pointer.}
\item{offset}{Scalar integer specifying offset starting at 0.} 
\item{typesignature}{Scalar character string specifying the C data type by a \code{\link{signature}} string.}
\item{value}{Atomic logical} 
}
\details{
The function \code{.pack} converts an R value into a C data type and writes it at the position specified
by \code{offset} in the object represented by \code{x}.

The function \code{.unpack} extracts a C data type at position specified by \code{offset} in the object
represented by \code{x} and converts the value to an R value according to the conversion specified on
the manual page for \code{\link{signature}}.  
}
\value{
\code{.unpack} returns an R value according to the signature specified.
}
\seealso{
Details on the text string encoding for \code{\link{signature}}.
}
