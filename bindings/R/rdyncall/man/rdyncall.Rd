\name{rdyncall}
\alias{rdyncall}
\alias{dyncall}
\alias{rdyncall-package}
\title{R bindings for DynCall.}
\description{  
This package provides an improved foreign function interface for R to invoke
precompiled binary code without writing additional C code for binding.
Designed as a toolkit, the package provides helpful tools for binding 
binary functionality in a cross-platform portable way.

The native foreign function interface (FFI) in \code{\link{.C}} is limited in 
several ways such as no support for scalar C types and return types. 
This package provides a much more flexible FFI. The function 
\code{\link{.dyncall}} and its family of specializations (\code{.dyncall.*})
allows to make calls to broad list of C function types and supports for
binary calling convention standards. It allows to call
functions with all C scalar (return-) types except Aggregates (C struct 
arguments). 
A more generic and portable to the process of loading and resolving library
symbols is provided, see \code{\link{dynbind}} for details. 

The implementation is based on dyncall, a shared C library which is ported
to x86, x64 and ppc 32-bit R platforms. There is still no sparc port, so
if you are using such a System, please do not use this package.
All others should work fine. We have successfully tested this package on
Windows XP, Mac OS 10.4 (ppc) and 10.5 (x86), Linux (x86, ppc and x64) 
and FreeBSD. The C Library has been tested on a much broader range of 
Operating-Systems and Hardware Platforms (e.g. PSP and Nintendo DS). See
\link{http://dyncall.org} for more information.

In addition to a flexible FFI, the Package consists of a whole Framework
of tools to make binding binary functionality with R more convienient and
to manage prebuilt binaries and its portable interface to R. 
See \code{\link{dynport}} for details. 

Powerful manipulation options are available to work with C struct and union
types. See \code{\link{as.struct}} for details.

The applications are manifold. One can use this package to access low-level 
system services or even portable technologies such as OpenGL
and SDL (see \link{dynport} for details).  

Functional overview of the rdyncall R Package:

\itemize{
\item Foreign function interface. See \code{\link{dyncall}}.
\item Locating/loading of shared libraries and resolving of symbols. See \code{\link{dynload}}.
\item Automatic R wrapper and binding to shared library functions. See \code{\link{dynbind}}.
\item Handling of C structures and unions. See \code{\link{as.struct}} and \code{\link{.pack1}}.
\item Wrapping R functions into C callbacks. See \code{\link{callback}}. 
\item Dynamic R packages as managed interfaces to precompiled shared libraries. See \code{\link{dynport}}.
}

}


