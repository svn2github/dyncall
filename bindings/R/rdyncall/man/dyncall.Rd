\name{dyncall}
\alias{dyncall}
\alias{.dyncall}
\alias{.dyncall.cdecl}
\alias{.dyncall.stdcall}
\alias{.dyncall.thiscall}
\alias{.dyncall.thiscall.msvc}
\alias{.dyncall.thiscall.gcc}
\alias{.dyncall.fastcall.msvc}
\alias{.dyncall.fastcall.gcc}
\title{Dynamic and Flexible Foreign Function Interface (FFI) to precompiled function code with support for multiple calling conventions.}
\description{  
Functions to make calls to precompiled code with support for multiple calling conventions without the need for
additional C wrapper code.
}
\usage{
.dyncall( address, signature, ... , callmode = "cdecl" )
.dyncall.cdecl        ( address, signature, ... )
.dyncall.stdcall      ( address, signature, ... )
.dyncall.thiscall     ( address, signature, ... )
.dyncall.thiscall.msvc( address, signature, ... )
.dyncall.thiscall.gcc ( address, signature, ... )
.dyncall.fastcall.msvc( address, signature, ... )
.dyncall.fastcall.gcc ( address, signature, ... )
}
\arguments{
  \item{address}{External pointer to a foreign function, such as returned by \code{\link{.dynsym}} or \code{\link{getNativeSymbolInfo}}.}
  \item{signature}{Scalar character string specifying the argument and return types as a \sQuote{\link{call signature}}.}
  \item{callmode}{Scalar character string specifying the calling convention.}
  \item{...}{Arguments to be passed according to the signature specified in \code{signature}.}
}
\details{
The foreign function to be called is given by \code{address} which is typically obtained from 
functions such as \code{\link{.dynsym}} or \code{\link{getNativeSymbolInfo}}. 

The \code{signature} specifies the formal argument-and-return types of the target function in the context of the C language
encoded via a \link{call signature}. 

The calling convention is specified \emph{explicitly} by the \code{callmode} argument 
using \code{.dyncall}, or \emph{implicitly} by using \code{.dyncall.*} functions. 

Arguments passed via \code{...} are converted according to the given \link{call signature} 
and selected \code{callmode}. If the arity of actual and formal arguments does not match or 
incompatible type mismatches are detected, the call is aborted before risking a fatal system crash.

}
\value{  
The converted return value of the foreign function call according to the return \link{type signature}
given by \code{signature}. 
}
\section{Signature}{
For details on call-and-type signature encoding and argument-and-return type-mapping between R and C, see \link{signature}.
}
\section{Calling conventions}{
Calling conventions specify how a function call is invoked at the machine-level.
Conventions differ significantly among families of CPU Architectures as well as
OS and compiler implementations.

While on many processor architectures there is only one (\code{callmode=}) \code{"default"} C calling convention - 
there are multiple calling conventions available on the Intel 32-bit X86 
processor architecture and in particular when working on Microsoft Windows with
the Microsoft System Libraries such as \code{KERNEL32.DLL} or \code{OPENGL32.DLL} which uses (\code{callmode=}) \code{"stdcall"}.

The implementation is based on the \emph{dyncall} library which has support for multiple calling conventions.
Currently \emph{dyncall} has support for the following processor architectures:

\itemize{
  \item X86: Intel 32-bit with support for stdcall, and thiscall and fastcall (GCC and Microsoft). Tested on Linux, Mac OS X, Windows, Net/Free/Open/Dragonfly-BSD, Solaris, Haiku, Plan9.
  \item X64: AMD 64-bit with support for System-V (ELF) and Win64. Tested on Linux, Mac OS X, Windows, FreeBSD. 
  \item ARM: ARM 32-bit with support for Thumb ABI. Tested on Darwin (iPhone OS, armv6 with bugs in armv7 mode) and Nintendo DS.
  \item PPC32: PowerPC 32-bit with support for Darwin (Mac OS X) and System-V (Linux/BSD).
  \item MIPS32: MIPS 32-bit with support for o32 (Linux) and eabi (Playstation Portable).
  \item MIPS64: MIPS 64-bit with support for n64 ABI . Tested on OpenBSD.
}

On all platforms, there is always on \code{"default"} (or \code{"cdecl"} - an alias) C calling convention of the host platform.

On X86 Platforms (with the exception of Plan9) several calling conventions are available at run-time:

\describe{
\item{\code{"stdcall"}}{C functions with emph{stdcall} calling convention. Useful for all Microsoft Windows System Libraries (e.g. KERNEL32.DLL, USER32.DLL, OPENGL32.DLL ...). Third-party libraries usually prefer the default C \emph{cdecl} calling convention. }
\item{\code{"fastcall.msvc"}}{C functions with \emph{fastcall} calling convention compiled with Microsoft Visual C++ Compiler.}
\item{\code{"fastcall.gcc"}}{C functions with \emph{fastcall} calling convention compiled with GNU C Compiler.}
\item{\code{"thiscall.gcc"}}{ C++ member functions compiled with GNU C Compiler.}
\item{\code{"thiscall.msvc"}}{C++ member functions compiled with Microsoft Visual C++ Compiler.}
}

In case, the user specifies one of the calling conventions and is on a non-x86 system, the callmode falls back to \code{"default"}.

\code{"cdecl"} is usually the best choice. Exceptions to this include the x86 architecture and in particular
Microsoft Windows System Libraries.
}
\note{
The address, calling convention and type information for arguments and return values \strong{MUST} match with 
the compiled function, otherwise the invocation can lead to a \strong{fatal R process crash}.
}
\examples{
\donttest{
rlib <- dynfind("R")
x <- .dynsym(rlib,"sqrt")
.dyncall(x, "d)d", 144L)
}
}
\references{
  Adler, D., Philipp, T. (2008) \emph{DynCall Library}. 
  \url{http://dyncall.org}
}
\author{
  Daniel Adler \email{dadler@uni-goettingen.de}
}
\seealso{
\code{\link{signature}} for call signatures.
\code{\link{dynbind}} for automatic binding of multiple functions from shared libraries.
\code{\link{getNativeSymbolInfo}} and \code{\link{.dynsym}}. 
\code{\link{.C}},\code{\link{.Call}},\code{\link{.External}}
}
\keyword{programming}
\keyword{interface}
