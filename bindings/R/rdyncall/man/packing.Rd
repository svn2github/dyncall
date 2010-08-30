\name{packing}
\alias{packing}
\alias{.pack}
\alias{.unpack}
\title{(Un)-packing of C data types.}
\description{Functions to manipulate C-level arrays and structures from within R.}
\usage{
.pack(x, offset, sigchar, value)
.unpack(x, offset, sigchar)
}
\arguments{
\item{x}{Atomic vector (logical, raw, integer or double) or external pointer.}
\item{offset}{Scalar integer specifying \emph{byte offset} starting at 0.} 
\item{sigchar}{Scalar character string specifying the C data type by a \code{\link{signature}} string.}
\item{value}{Atomic logical} 
}
\details{
The function \code{.pack} converts an R value into a C data type and writes it at the byte position specified
by byte \code{offset} in the object's data area represented by \code{x}.

The function \code{.unpack} extracts a C data type at position specified by byte \code{offset} in the object's data area
represented by \code{x} and converts the value to an R value according to the conversion specified on
the manual page for \code{\link{signature}}.  

Byte \code{offset} calculations begin at byte offset 0 relative to the first byte in a vectors data area (at R item index 1).
}
\value{
\code{.unpack} returns an R value according to the signature specified.
}
\seealso{
Details on the text string encoding for \code{\link{signature}}.
}
