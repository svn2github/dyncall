\name{dynbind}
\alias{dynbind}
\title{Dynamic R bindings to shared library functions.}
\description{Function to create dynamic R bindings to shared library functions via installation
of lightweight R wrapper functions. The wrapper functions delegate calls to precompiled functions and 
function pointer variables using \code{\link{.dyncall}}.}
\usage{
dynbind(libnames, signature, envir=parent.frame(), callmode="cdecl", 
        pat=NULL, replace=NULL, funcptr=FALSE)
}
\arguments{
  \item{libnames}{Vector of character strings specifying short library names of the shared library to be loaded.}
  \item{signature}{Scalar character string specifying the set of function bindings (\link{library signature}).}
  \item{envir}{Environment where R wrapper functions should be installed.}
  \item{callmode}{Scalar character string specifying the calling convention of the target library.}
  \item{pat}{Scalar characgter string specifying a regular expression to be matched against the name part of function signatures and replaced by \code{replace}}
  \item{replace}{Scalar character string specifying the replacement of the regular expression pattern given by \code{pat}.}
  \item{funcptr}{Scalar logical indicating whether symbols are resolved to 
  functions (\code{FALSE}) or to a pointer-to-function variables (\code{TRUE}) - see details below.}
}
\details{
The function dynamically loads a shared library specified by short library names given by \code{libnames} using \code{\link{dynfind}}.
According to the \link{library signature}, a set of front-end R wrapper functions are constructed that delegate calls to 
functions of the shared library via \code{\link{.dyncall}}.

The \link{library signature} comprises a sequence of \link{function signatures} separated by \samp{;} semicolon symbols and optionally white-spaces before and after semicolons.

\tabular{c}{
\emph{symbol} \samp{(} \emph{argumentTypes} \samp{)} \emph{returnType} \samp{;} \ldots \cr 
}

For each \link{function signature}, a corresponding R wrapper is created with the following pattern:

\tabular{c}{
\code{ symbol <- function(...) .dyncall.CALLMODE ( target, signature, ... ) }
}

The suffix \emph{CALLMODE} is replaced by \code{callmode} to match a corresponding FFI calling convention (one of the \code{.dyncall.*} functions), 
see \code{\link{.dyncall}} for details on calling conventions.
If a regular expression \code{pat} and \code{replace} is given, the substitution is applied to the \emph{symbol} before installation in the environment \code{envir}.

The \emph{target} is replaced by the exported pointer that refers to the resolved address of the \emph{symbol}.
The \emph{signature} is replaced by the call signature string ( \emph{argumentTypes} \samp{)} \emph{returnType} ).

As a special case, \code{dynbind} supports binding of pointer-to-function variables via setting \code{funcptr} to \code{TRUE} that changes the \emph{target} part
using \code{.unpack} to dereference the address at run-time:

\tabular{c}{
\code{ symbol <- function(...) .dyncall.CALLMODE ( .unpack(target, "p", 0) , signature, ... ) }
}

}

\value{
List object consisting of the follow fields:
\item{libhandle}{External pointer returned by \code{\link{.dynload}}}
\item{unresolved.symbols}{Character string vector containing the names of unresolved symbols}
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
\code{\link{signature}} for details on signatures, 
\code{\link{dynfind}} for details on short library names, 
\code{\link{.dyncall}} for details on call signatures and calling conventions,
\code{\link{.unpack}} for details on dereferencing of (function) pointer variables. 
}
\keyword{programming}
\keyword{interface}

