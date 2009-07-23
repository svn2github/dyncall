\name{dynbind}
\alias{dynbind}
\title{Dynamic bindings to shared libraries.}
\description{Dynamic bindings to shared library functions in a batch.}
\usage{
dynbind(libname, lib.signature, envir=parent.frame(), callmode="cdecl", pat=NULL, replace=NULL, funcptr=FALSE)
}
\arguments{
  \item{libname}{Character string scalar specifying a (short) library name.}
  \item{lib.signature}{Character string scalar specifying a batch of function symbol names and type signatures.}
  \item{envir}{Environment where wrapper R functions should be installed.}
  \item{callmode}{Character string scalar specifying the calling convention of the target library.}
  \item{pat}{Character string scalar containing a regular expression that will match and which will be replaced by \code{pat}}
  \item{replace}{Character string scalar specifying the replacement of the pattern given by \code{pat}.}
  \item{funcptr}{Logical scalar specifying if symbols represent function pointer variables instead of functions.}
}
\details{
The function loads a shared library specified by \code{libname} using \code{\link{dynfind}} and 
creates wrapper R functions for functions and function variables specified by the library
signature \code{lib.signature}. On successful resolving of symbolic names, the corresponding 
R wrapper functions will installed in \code{envir}.
}
\section{Library Signature}{
The library signature is a text-based representation for a group of function bindings.
It consists of function names and corresponding call signatures. Function bindings are separated 
by ';' and whitespaces around.

\tabular{c}{
\emph{function-name} \samp{(} \emph{argument-types} \samp{)} \emph{return-type} \samp{;} \ldots \cr
}
}
\value{
The result of the batch operations are reported as list object consisting of the follow fields:
\item{libhandle}{External pointer returned by \code{\link{.dynload}}}
\item{unresolved.symbols}{Character string vector containing the names of unresolved symbols}
}
\author{
  Daniel Adler \email{dadler@uni-goettingen.de}
}
\examples{
\donttest{
info <- dynbind("R","
R_ShowMessage(Z)v;
R_rsort(pi)v;
")
R_ShowMessage("hello")
}
}
\seealso{
\code{\link{dynfind}} for details on short library names and \code{\link{.dyncall}} for details on call signatures and calling conventions.
}
\keyword{programming}
\keyword{interface}

