\name{rdyncall}
\alias{rdyncall}
\alias{rdyncall-package}
\title{R bindings for DynCall.}
\description{  
This package provides an R interface to call C/C++ and Fortran functions from shared libraries.

The foreign function interface in \R (functions such as .C and .Call) is limited in several ways.
You can not establish function calls to \emph{typical} C functions available on the net today.
This package claims to allow a much broader integration with  
   
In \R, one can call foreign functions through .C, .Call, .Call.Graphics and .ExternalCalling a foreign function in is available using .C, .Call, .External 
The abilities of R to call precompiled code are limited to R designed languages.

In further provides several utilities to easy the integration with compiled code to shrink the amount
of glue code required to connect R with code from C/C++, Fortran etc.

The package is based on dyncall, a C library, that provides a foreign function call interface and has
been ported to a large number of platforms. See \url{http://dyncall.org} for a list of platforms included.

Function overview of rdyncall:

\itemize{
\item Load shared libraries. See \code{\link{dynload}}.
\item Resolving symbolic names to function pointers. See \code{\link{dynload}}.
\item Call foreign functions with support for multiple calling conventions. See \code{\link{dyncall}}.
\item Dynamic binding of shared library functions through text-based type signatures.  See \code{\link{dyncall}} and \code{\link{dynbind}} signatures}.
\item Integration of shared libraries using dynamic binding informations. See \code{\link{dynport}}.
}

}


