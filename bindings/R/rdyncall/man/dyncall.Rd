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
  \item{address}{External pointer to a foreign function, such as that returned by \code{\link{.dynsym}} or \code{\link{getNativeSymbolInfo}}.}
  \item{signature}{Scalar character \sQuote{\link{call signature}} string specifying the argument and return types of the target function.}
  \item{callmode}{Scalar character string specifying the calling convention.}
  \item{...}{Arguments to be passed according to the signature specified in \code{signature}.}
}
\details{
The foreign function to be called is given by \code{address} and is typically obtained from 
functions such as \code{\link{.dynsym}} or \code{\link{getNativeSymbolInfo}}. 

The \code{signature} specifies the formal argument-and-return types of the 
target function in the context of the C language encoded via as
described in the \link{call signature} text format. 

The calling convention is specified \emph{explicitly} by the \code{callmode} argument 
using \code{.dyncall}, or \emph{implicitly} by using \code{.dyncall.*} functions. 

Arguments passed via \code{...} are converted according to the given 
\link{call signature} and selected \code{callmode}. If the arity of actual 
arguments does not match the formal arguments expressed via \code{signature},
or incompatible type mismatches are detected during preparation phase,
the call is aborted before risking a fatal system crash.
}
\value{  
The converted return value of the foreign function call according to the return \link{type signature}
given by \code{signature}. 
}
\section{Signature}{
For details on call-and-type signature encoding and argument-and-return 
type-mapping between R and C, see \link{signature}.
}
\section{Calling conventions}{
Calling conventions specify how a function call is invoked at the machine-level.
Conventions differ significantly among families of CPU Architectures as well as
OS and compiler implementations.

While on many processor architectures there is only one \code{"default"} C calling convention - 
there are multiple calling conventions available on the Intel 32-bit X86 
processor architecture and in particular when working on Microsoft Windows with
the Microsoft System Libraries such as \code{KERNEL32.DLL} or \code{OPENGL32.DLL} which uses (\code{callmode=}) \code{"stdcall"}.

On all platforms, there is always on \code{"default"} (or \code{"cdecl"} - an alias) C calling convention of the host platform.

On X86 Platforms (with the exception of Plan9) several calling conventions are available at run-time:

\describe{
\item{\code{"stdcall"}}{C functions with \emph{stdcall} calling convention. Useful for all Microsoft Windows System Libraries (e.g. KERNEL32.DLL, USER32.DLL, OPENGL32.DLL ...). Third-party libraries usually prefer the default C \emph{cdecl} calling convention. }
\item{\code{"fastcall.msvc"}}{C functions with \emph{fastcall} calling convention compiled with Microsoft Visual C++ Compiler. Very rare usage.}
\item{\code{"fastcall.gcc"}}{C functions with \emph{fastcall} calling convention compiled with GNU C Compiler. Very rare usage.}
\item{\code{"thiscall.gcc"}}{ C++ member functions compiled with GNU C Compiler.}
\item{\code{"thiscall.msvc"}}{C++ member functions compiled with Microsoft Visual C++ Compiler.}
}

In case, the user specifies one of the calling conventions and is on a non-x86 system, the callmode falls back to \code{"default"}.

\code{"cdecl"} is usually the best choice. Exceptions to this include the x86 architecture and in particular
Microsoft Windows System Libraries.
}
\section{Portability}{

The implementation is based on the \emph{dyncall} library which has been ported
to the following Processor Architectures: X86, X64, ARM, PowerPC 32-bit, MIPS 32-bit and MIPS 64-bit
with support for several Operating-Systems such as Linux, Mac OS X, Windows, (Open,Free,Net,DragonFly)BSD, Haiku, Open Solaris
as well as embedded platforms such as Nintendo DS (ARM) and Sony Playstation Portable (MIPS 32-bit).
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
\seealso{
\code{\link{signature}} for call signatures.
\code{\link{dynbind}} for automatic binding of multiple functions from shared libraries.
\code{\link{getNativeSymbolInfo}} and \code{\link{.dynsym}}. 
\code{\link{.C}},\code{\link{.Call}},\code{\link{.External}}
}
\keyword{programming}
\keyword{interface}
