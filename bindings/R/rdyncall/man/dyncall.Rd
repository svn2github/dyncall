\name{dyncall}
\alias{dyncall}
\alias{.dyncall}
\alias{.dyncall.default}
\alias{.dyncall.cdecl}
\alias{.dyncall.stdcall}
\alias{.dyncall.thiscall}
\alias{.dyncall.thiscall.msvc}
\alias{.dyncall.thiscall.gcc}
\alias{.dyncall.fastcall.msvc}
\alias{.dyncall.fastcall.gcc}
\title{Flexible Foreign Function Interface (FFI) with support for all C types and multiple calling conventions.}
\description{  
Functions to make calls to precompiled code with support for multiple calling conventions without the need for
additional C wrapper code.
}
\usage{
.dyncall( address, signature, ... , callmode = "cdecl" )
.dyncall.default      ( address, signature, ... )
.dyncall.cdecl        ( address, signature, ... )
.dyncall.stdcall      ( address, signature, ... )
.dyncall.thiscall     ( address, signature, ... )
.dyncall.thiscall.msvc( address, signature, ... )
.dyncall.thiscall.gcc ( address, signature, ... )
.dyncall.fastcall.msvc( address, signature, ... )
.dyncall.fastcall.gcc ( address, signature, ... )
}
\arguments{
  \item{address}{external pointer to a foreign function, such as that returned by \code{\link{.dynsym}} or \code{\link{getNativeSymbolInfo}}.}
  \item{signature}{character string, specifying the \sQuote{\link{call signature}}.}
  \item{callmode}{character string specifying the calling convention.}
  \item{...}{arguments to be passed to the foreign code, according to the signature specified in \code{signature}.}
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

All platforms support a \code{"default"} C calling convention which works fine with most precompiled code.

On Microsoft Windows/X86 Platform  several calling conventions are available at run-time:

\describe{
\item{\code{"cdecl"}}{Dummy alias to \emph{default}}
\item{\code{"stdcall"}}{C functions with \emph{stdcall} calling convention. Useful for all Microsoft Windows System Libraries (e.g. KERNEL32.DLL, USER32.DLL, OPENGL32.DLL ...). Third-party libraries usually prefer the default C \emph{cdecl} calling convention. }
\item{\code{"fastcall.msvc"}}{C functions with \emph{fastcall} calling convention compiled with Microsoft Visual C++ Compiler. Very rare usage.}
\item{\code{"fastcall.gcc"}}{C functions with \emph{fastcall} calling convention compiled with GNU C Compiler. Very rare usage.}
\item{\code{"thiscall.gcc"}}{ C++ member functions compiled with GNU C Compiler.}
\item{\code{"thiscall.msvc"}}{C++ member functions compiled with Microsoft Visual C++ Compiler.}
}

In case,  one of the above calling conventions are specified when running
on a non-windows 32-bit Operating-System, the callmode falls back to 
\code{"default"}. 

}
\section{Portability}{

The implementation is based on the \emph{dyncall} library which has been ported
to the following Processor Architectures: X86, X64, ARM, PowerPC 32-bit, MIPS 32-bit and MIPS 64-bit
with support for several Operating-Systems such as Linux, Mac OS X, Windows, (Open,Free,Net,DragonFly)BSD, Haiku, Open Solaris
as well as embedded platforms such as Nintendo DS (ARM) and Sony Playstation Portable (MIPS 32-bit).
}
\note{
The address, calling convention and call signature \strong{MUST} match the foreign function type, otherwise the invocation can lead to a \strong{fatal R process crash}.
}
\examples{
mathlib <- dynfind(c("msvcrt","m","c"))
x <- .dynsym(mathlib,"sqrt")
.dyncall(x, "d)d", 144L)
}
\references{
  Adler, D., Philipp, T. (2008) \emph{DynCall Library}. 
  \url{http://dyncall.org}
}
\seealso{
\code{\link{signature}} for call signatures.
\code{\link{dynbind}} for automatic binding of multiple functions from shared libraries.
\code{\link[base]{getNativeSymbolInfo}} and \code{\link{.dynsym}}. 
\code{\link[base]{.C}},\code{\link[base]{.Call}},\code{\link[base]{.External}}
}
\keyword{programming}
\keyword{interface}
