\name{dynbind}
\alias{dynbind}
\title{Dynamic bindings to shared libraries.}
\description{Function to create dynamic bindings to shared libraries.}
\usage{
dynbind(libname, lib.signature, envir=parent.frame(), callmode="cdecl")
}
\arguments{
  \item{libname}{A character string specifying the short library name or path.}
  \item{lib.signature}{A character string specifying function symbol names and type signatures.}
  \item{envir}{An environment where the binding functions are installed.}
  \item{callmode}{A character string specifying the calling convention.}
}
\details{
The \code{lib.signature} character string contains a list of full-qualified function symbol and signature separated by \code{';'} (semicolon) character.
White spaces, tabs and new-line characters are ignored.
Each function binding consists of

\tabular{c}{
\emph{function-name} \code{'('} \emph{argument-types} \code{')'} \emph{return-type} \code{';'} \cr
}

The following example binds four C functions from the R run-time to R. Note that 
this binding is not possible with .C binding.  

\preformatted{
dynbind("R", "R_isort(pi)v; R_rsort(pi)v; R_csort(pi)v; rsort_with_index(ppi)v;")
}

\emph{function-name} \code{'('} \emph{call-signature} \code{';'} \cr

}
\author {
  Daniel Adler \email{dadler@uni-goettingen.de}
}
\keyword{programming::interface}
\seealso{
\code{\link{.dyncall}}.
}
