\name{dynfind}
\alias{dynfind}
\alias{pathsFromEnv}
\title{Find system libraries in common places.}
\description{Searches in common places in the file-system to locate a library by a common name.}
\usage{
dynfind(libnames, auto.unload=TRUE)
}
\arguments{
  \item{libnames}{A vector of character strings specifying fragments of the shared library name. See below for details.}
  \item{auto.unload}{A logical specify to register a finalizer that unloads the library when no reference is dangling. See \code{\link{.dynload}} for details.}
}
\details{
Shared libraries often contain similar function symbols across multiple 
platforms, but locating those libraries in a generic and portable way 
is difficult.
The naming conventions and locations depend on the operating-system and other 
factors such as software distribution that make the task of loading a shared 
library in a portable way very tedious.

The function \code{dynfind} attempts to locate and load a shared library 
by a fragment name of the full qualified library name. Multiple of these
fragments can be given, such that \code{dynfind} tries all of them until
it finds a first matching dynamic linkable library.

The search strategies are quite different among the platforms.
In general, several file-system match attempts are made using different 
prefixes, suffixes and locations to search for. 

All fragment will be tried as-is and with a '\code{lib}' prefix.

The file extension is either taken to be '\code{.dll}' (Windows), '\code{.dylib}' (Mac OS X), '\code{.so}' (ELF-based - Linux, FreeBSD, NetBSD, OpenBSD, Solaris).
On Mac OS X, in addition no file extension is tried for frameworks (see below).

Several locations are tried which come from environment variables such as 
'\code{PATH}' on Windows. On the other platforms locations from the
'\code{LD_LIBRARY_PATH}' environment variable are tried together with
some hardcoded locations (this might change in a future release):
\file{/opt/local/lib}, \file{/usr/local/lib}, \file{/usr/lib} and \file{/lib}.

On Mac OS X, frameworks are also searched for by a fragment name and this 
happens before the normal shared library search procedure is started. 
A framework has a different naming convention, such that a '\code{FooBar}' fragment 
would try for a match at '\code{/System/Library/Frameworks/FooBar.framework/FooBar}' and '\code{/Library/Frameworks/FooBar.framework/FooBar}'.

Loading of the library is done by \code{\link{.dynload}}.
}
\seealso{\code{\link{.dynload}}}
\keyword{programming}
\keyword{interface}

