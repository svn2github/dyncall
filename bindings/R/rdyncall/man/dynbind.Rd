\name{dynbind}
\alias{dynbind}
\title{Dynamic bindings to shared libraries.}
\description{Function to create dynamic bindings to shared libraries.}
\usage{
dynbind(libname, libsignature, envir=parent.frame(), callmode="cdecl", pat=NULL, replace=NULL, funcptr=FALSE)
}
\arguments{
  \item{libname}{A character string specifying the short library name or path.}
  \item{libsignature}{A character string specifying function symbol names and type signatures.}
  \item{envir}{An environment where the binding functions are installed.}
  \item{callmode}{A character string specifying the calling convention of the target library.}
  \item{pat}{NULL or a regular expression character string that will match and which will be replaced by \code{pat}}
  \item{replace}{NULL or a regular expression character string to replace \code{pat}}
  \item{funcptr}{A logical specifying if symbols represent function pointer variables instead of functions.}
}
\details{

The function loads the library specified by \code{libname} and resolves compiled code  
specified by \code{libsignature}. For each successfully resolved function, a R wrapper
function will be created and installed in the environment \code{envir}.

The location of the library can be specified by a absolut system file-path or using
a short name.

When using a short name, the library is looked up using the \code{PATH} environment variable.
from a shared library to the R process at run-time.

The \code{libname} character string specifies the location of the library. 

The library is specified by \code{libname} given as a character string either in short or 
long form (absolute file path).

If \code{libname} specifies only a short form - where only the library name itself is given.

The \code{libname} specified by \code{libsignature} to 
the R process. For each C function
and binds C functions specified by the \code{lib.signature}.

In the short form, the function tries to locate the library at well known places.
  does not contain a full path or platform-specific prefix and suffixes.
\code{dynbind} will look for the library in certain places using the \code{PATH} system environment variable 
on Windows and Posix.

The \code{lib.signature} character string contains a list of full-qualified function symbol and signature separated by \code{';'} (semicolon) character.
White spaces, tabs and new-line characters are ignored.
Each function binding consists of

\tabular{c}{
\emph{function-name} \code{'('} \emph{argument-types} \code{')'} \emph{return-type} \code{';'} \cr
}

The following example binds four C functions from the R run-time to R. Note that 
this binding is not possible with .C binding.  

# Dynamic bindings in R using dynbind:

dynbind("R", "R_isort(pi)v; R_rsort(pi)v; R_csort(pi)v; rsort_with_index(ppi)v;")

# Now, R_isort, R_rsort, R_csort, rsort_with_index are ready to use:

x <- as.integer( rnorm(100)*100 )
R_isort(x,length(x))

}
\author {
  Daniel Adler \email{dadler@uni-goettingen.de}
}
\seealso{
\code{\link{.dyncall}}.
}
\keyword{interface}
\keyword{programming::interface}
