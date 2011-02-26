\name{dynfind}
\alias{dynfind}
\alias{pathsFromEnv}
\title{Portable sarching and loading of shared libraries.}
\description{Searches for a shared library in standard locations by short name.}
\usage{
dynfind(libnames, auto.unload=TRUE)
}
\arguments{
  \item{libnames}{A vector of character strings specifying fragments of the shared library name. See below for details.}
  \item{auto.unload}{A logical specify to register a finalizer that unloads the library when no reference is dangling. See \code{\link{.dynload}} for details.}
}
\details{

The function \code{dynfind} provides a platform-portable interface for searching of shared libraries by short fragement name hints.
A common abstract layout of a shared library filename is given below:

\tabular{c}{
\emph{location} \emph{prefix} \emph{fragment} \emph{suffix}
}

When \code{dynfind} searches for a library, a list of possible filenames are tried until the OS run-time dynamic linker successfully opens a shared library.
The list is generated from  permutations of the components. Here is an example of permutation values for each component:

\itemize{
  \item locations: '/usr/local/lib/', '/Windows/System32/'.
  \item prefixes: 'lib' (for Unix-flavour), '' (for Windows-flavour).
  \item suffixes: '.dll' (Windows), '.dylib' (Mac OS X/iOS), '.so' (ELF) and '' (for Mac OS X Frameworks).
  \item fragments: 'c', 'msvcrt'.
}

While the \emph{fragment} permutation is controlled by the vector \code{libnames}, the other components are hardcoded in an OS-specific manner, described below.

The search algorithm of \code{dynfind} builds permutations of a possible filename from the components.
If the dynamic linker successfully opens a shared library, the function returns immmediately passing the opened shared library resource.

The vector of locations is initialized by environment variables such as '\code{PATH}' on Windows and 
\code{LD_LIBRARY_PATH} on Unix-flavour systems in additional to some hardcoded locations:
\file{/opt/local/lib}, \file{/usr/local/lib}, \file{/usr/lib} and \file{/lib}.
(The set of hardcoded locations might change within the next minor releases).

Some libraries such as the Standard C Library are not always standardized by name. In that case, one can give several short names.
For example, to load the Standard C Library across Windows and Unix-flavour systems, one can say dynfind(c("msvcrt","c")) which
will locate \code{MSVCRT.dll} on Windows and \code{libc.so.6} on Unix.

The function \code{dynfind} attempts to locate and load a shared library 
from a fragment of the full library name. Multiple of these fragments can be given such that if a shared library is named
differently on different platforms (e.g. the standard C library on Microsoft using Microsoft Visual C++ contains the fragment \code{"msvcrt"}, on unix the fragment is \code{"c"}.)

The file extension is either taken to be '\code{.dll}' (Windows), '\code{.dylib}' (Mac OS X), '\code{.so}' (ELF-based - Linux, FreeBSD, NetBSD, OpenBSD, Solaris).
On Mac OS X, in addition no file extension is tried for frameworks (see below).

On Mac OS X, frameworks are also searched for by a fragment name and this 
happens before the normal shared library search procedure is started with a slightly different pattern:

\tabular{c}{
\emph{frameworksLocation} \code{Frameworks/} \emph{fragmentName} \code{.framework/} \emph{fragmentName}
}

The \emph{frameworksLocation} is a vector of locations such as \code{/System/Library/} and \code{/Library/}.

Loading of the library is done by \code{\link{.dynload}}.
}
\seealso{\code{\link{.dynload}}}
\keyword{programming}
\keyword{interface}

