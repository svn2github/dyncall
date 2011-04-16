\name{dynfind}
\alias{dynfind}
\title{Portable searching and loading of shared libraries}
\description{Function to load shared libraries using a platform-portable interface.}
\usage{
dynfind(libnames, auto.unload=TRUE)
}
\arguments{
  \item{libnames}{vector of character strings specifying multiple \sQuote{short library names} (See below for details). For example, \code{c("msvcrt","c")} would load the Standard C shared library (likewise on Windows, Mac OS X and many Unix-flavour platforms).}
  \item{auto.unload}{logical: if \code{TRUE} then a finalizer is registered that closes the library on garbage collection. See \code{\link{.dynload}} for details.}
}
\details{
The naming scheme and standard locations of shared libraries are OS-specific.
When loading a standard library dynamically at run-time across platforms via standard interfaces such as \code{\link{.dynload}} or \code{\link{dyn.load}}, 
a platform-test is usually needed to specify the library file path.

\code{dynfind} offers a plaform-portable interface for loading a particular shared library across multiple platforms.
This library name problem is encountered mainly by breaking up the library file path into several abstract components:
\tabular{c}{
\sQuote{location} \sQuote{prefix} \sQuote{libname} \sQuote{suffix} \cr
}
\code{dynfind} loads a library by trying several locations that are generated via permutation of the four componts.

From the users perspective, a library is specified via \code{libname}; a vector of possible candidates for the \sQuote{short library name}.
The search stops immediately when a library can be opened.

Here is a sample list of values for the three other components (not controlled by the user):

\itemize{
  \item \sQuote{location}: \dQuote{/usr/local/lib/}, \dQuote{/Windows/System32/}.
  \item \sQuote{prefix}: \dQuote{lib} (common),  \dQuote{} (empty - common on Windows).
  \item \sQuote{suffix}: \dQuote{.dll} (Windows), \dQuote{.so} (ELF), \dQuote{.dylib} (Mac OS X) and \dQuote{} (empty - useful for all platforms).
}

The vector of \sQuote{locations} is initialized by environment variables such as '\code{PATH}' on Windows and 
\code{LD_LIBRARY_PATH} on Unix-flavour systems in additional to some hardcoded locations:
\file{/opt/local/lib}, 
\file{/usr/local/lib}, 
\file{/usr/lib} and 
\file{/lib}.
(The set of hardcoded locations might expand and change within the next minor releases).

Some libraries such as the Standard C Library do also have multiple \sQuote{short library name} depending on the OS. Hence, one can give a vector of short names.
For example, to load the Standard C Library across major R platforms, the function call \code{dynfind(c("msvcrt","c"))} 
would load \code{MSVCRT.dll} on Windows, \code{libc.dylib} on Mac OS X and \code{libc.so} on ELF platforms.

The file extension depends on the OS: '\code{.dll}' (Windows), '\code{.dylib}' (Mac OS X), '\code{.so}' (all others).

On Mac OS X, \sQuote{frameworks} are also taken into account. This happens before the normal library search procedure and uses a slightly different naming pattern
in a separate search phase:

\tabular{c}{
\sQuote{frameworksLocation} \dQuote{Frameworks/} \sQuote{libname} \dQuote{.framework/} \sQuote{libname}
}

The \sQuote{frameworksLocation} is a vector of locations such as \code{/System/Library/} and \code{/Library/}.

\code{dynfind} loads a library via \code{\link{.dynload}} passing over the parameter \code{auto.unload}.

}
\value{
\code{dynfind} returns an external pointer (library handle), if search was successful.
Otherwise, if no library is located, a \code{NULL} is returned.
}
\seealso{
See \code{\link{.dynload}} for details on the loader interface to the OS-specific dynamic linker.
}
\keyword{programming}
\keyword{interface}

