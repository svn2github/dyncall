\name{dynbind}
\alias{dynbind}
\title{Binding C library functions via call wrappers}
\description{Function to bind several foreign functions of a C library via thin R call wrappers.}
\usage{
dynbind(libnames, signature, 
        envir=parent.frame(), callmode="default", 
        pat=NULL, replace=NULL, funcptr=FALSE)
}
\arguments{
  \item{libnames}{vector of character strings giving short library names of the shared library to be load and used resolve symbols. See \code{\link{dynfind}} for details.}
  \item{signature}{character string specifying the \emph{library signature} that determines the set of foreign function names and types. See details.}
  \item{envir}{the environment to use for installation of call wrappers.}
  \item{callmode}{character string specifying the calling convention, see details.}
  \item{pat}{NULL or regular expression character string applied to symbolic names.}
  \item{replace}{NULL or replacement character string.}
  \item{funcptr}{logical ; indicates that symbols refer to functions (\code{FALSE}, default) or function poiner variables (\code{TRUE} rarely needed).}
}
\details{
\code{dynbind} makes a set of C functions available to R through thin call wrappers.
The set of functions, including the symbolic name and function type, is specified by \code{signature} ; a character string that encodes a
library signature:

The \strong{library signature} is a compact plain-text format to specify a set of function bindings.
It consists of function names and corresponding \link[=call signature]{call signatures}. Function bindings are separated 
by \sQuote{;} (semicolon) ; white spaces (including tab and new line) are allowed before and after semicolon.

\tabular{c}{
\sQuote{function-name} \samp{(} \sQuote{call-signature} \samp{;} \ldots \cr
}

Here is an example that specifies three function bindings from the OpenGL library:
\preformatted{"glAccum(If)v ; glClear(I)v ; glClearColor(ffff)v ;"}

Symbolic names are resolved using the library specified by \code{libnames} using \code{\link{dynfind}} for loading.
For each function, a thin call wrapper function is created using the following template: 

\preformatted{ function(...) .dyncall.<MODE> ( <TARGET>, <SIGNATURE>, ... ) }

\code{<MODE>} is replaced by \code{callmode} argument, see \code{\link{.dyncall}} for details on calling conventions.
\code{<TARGET>} is replaced by the external pointer, resolved by the \sQuote{function-name}.
\code{<SIGNATURE>} is replaced by the call signature string contained in \code{signature}.

The call wrapper is installed in the environment given by \code{envir}.
The assignment name is obtained from the function signature.
If \code{pat} and \code{replace} is given, a text replacement is applied to the name before assignment, useful for basic C name space mangling such as exchanging the prefix.

As a special case, \code{dynbind} supports binding of pointer-to-function variables via setting \code{funcptr} to \code{TRUE} that substitutes \code{<TARGET>} 
with the expression \code{.unpack(target,"p",0)} to dereference the pointer-to-function variable at call-time.
}

\value{
The function returns a list with two fields:
\item{libhandle}{External pointer returned by \code{\link{.dynload}}.}
\item{unresolved.symbols}{vector of character strings, the names of unresolved symbols.}

As a side effect, \code{dynbind} assigns call wrapper functions in the environment given by \code{envir}.

If no shared library is found, an error is reported.
}
\examples{
\donttest{
# Install two wrappers to functions of the R shared C library.
info <- dynbind("R","
R_ShowMessage(Z)v;
R_rsort(pi)v;
")
R_ShowMessage("hello")
}
}
\seealso{
\code{\link{.dyncall}} for details on call signatures and calling conventions,
\code{\link{dynfind}} for details on short library names, 
\code{\link{.unpack}} for details on dereferencing of (function) pointer variables. 
}
\keyword{programming}
\keyword{interface}

