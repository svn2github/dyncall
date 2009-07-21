\name{dyncallback}
\alias{new.callback}
\title{R functions as C function callbacks.}
\description{  
Function to wrap an R function into a C function pointer to be used as a C callback function pointer.
}
\usage{
new.callback( signature, fun, envir )
}
\arguments{
  \item{signature}{A character string specifying the argument and return type of a C callback.}
  \item{fun}{A function closure to be wrapped.}
  \item{envir}{An environment to be used for execution of the function.}
}
\value{
An external pointer to be used as a opaque C function pointer in the context of a C callback.
}
\details{
C callbacks are function pointers that are registered and executed from a C context. This function
allows to wrap an R closure function into a C callback and reveals an opaque external pointer to 
be registered as a C callback.
One needs to know the C callback function type to specify the arguments and return types. A callback
function signature specifies the expected arguments.
}
\note{
Note: This feature is currently unstable. It is ported to x86 (tested on Windows, Mac OS X, Linux) and AMD64 (tested on Linux) platforms.
A port to PowerPC is currently in development. 
}

\section{Signature}{

The general form of a dyncallback signature string is

\tabular{rcl}{
\emph{Argument types} \tab \code{)} \tab \emph{Return type}\cr
}

A type is specified using a one-character type code. The argument type characters are specified 
in left-to-right order of the corresponding C function prototype. 
A closing bracket character \code{')'} marks the end of input argument types. Finally, a return type character is given
to specify the return value. 
The following table lists valid type character codes, corresponding C types, acceptable R argument types and returned R types.

\tabular{clll}{
\strong{Type code} \tab \strong{C type}        \tab \strong{R argument type}           \tab \strong{R return type}\cr
\code{B}           \tab bool                   \tab raw,logical,integer,double         \tab logical\cr
\code{c}           \tab char                   \tab raw,logical,integer,double         \tab integer\cr
\code{C}           \tab unsigned char          \tab raw,logical,integer,double         \tab integer\cr
\code{s}           \tab short                  \tab raw,logical,integer,double         \tab integer\cr
\code{S}           \tab unsigned short         \tab raw,logical,integer,double         \tab integer\cr
\code{i}           \tab int                    \tab raw,logical,integer,double         \tab integer\cr
\code{I}           \tab unsigned int           \tab raw,logical,integer,double         \tab double\cr
\code{j}           \tab long                   \tab raw,logical,integer,double         \tab double\cr
\code{J}           \tab unsigned long          \tab raw,logical,integer,double         \tab double\cr
\code{l}           \tab long long              \tab raw,logical,integer,double         \tab double\cr
\code{L}           \tab unsigned long long     \tab raw,logical,integer,double         \tab double\cr
\code{f}           \tab float                  \tab raw,logical,integer,double         \tab double\cr
\code{d}           \tab double                 \tab raw,logical,integer,double         \tab double\cr
\code{p}           \tab \emph{type}* (pointer) \tab \emph{any vector},externalptr,NULL \tab externalptr,NULL\cr
\code{S}           \tab char*                  \tab character,NULL                     \tab character,NULL\cr
\code{x}           \tab SEXP                   \tab \emph{any}                         \tab \emph{any}\cr
\code{v}           \tab void                   \tab \emph{invalid}                     \tab NULL\cr
}
}

\references{
  Adler, D., Philipp, T. (2008) \emph{DynCall Library}. 
  \url{http://dyncall.org}
}
\author {
  Daniel Adler \email{dadler@uni-goettingen.de}
}
\seealso{
\code{\link{getNativeSymbolInfo}} and \code{\link{.dynfind}}. 
\code{\link{.C}},\code{\link{.Call}},,\code{\link{.External}}
}
\keyword{interface}
\keyword{programming::interface}
