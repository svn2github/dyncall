\name{pack}
\alias{pack}
\alias{.pack1}
\alias{.unpack1}
\title{Pack and unpacking of low-level structured data.}
\description{Functions to read/write low-level structure data held as pointer or in a raw vector.}
\usage{
.pack1(x, offset, sigchar, value)
value <- .unpack1(x, offset, sigchar)
}
\arguments{
	\item{x}{An atomic vector or external pointer.}
	\item{offset}{Positive integer specifying the offset from within the beginning (item 0) given in bytes.}
	\item{sigchar}{Data type specifying the low-level representation of \code{value}}
	\item{value}{Value}	
}
\details{
These functions can be used for manipulating C-level structure data.
Atomic vectors are first adjusted to start at the first element (offset 0). 
}
\author{
  Daniel Adler \email{dadler@uni-goettingen.de}
}
\keyword{programming}
\keyword{interface}
