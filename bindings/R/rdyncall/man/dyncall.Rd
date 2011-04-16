\name{dyncall}
\alias{.dyncall}
\alias{dyncall}
\alias{.dyncall.default}
\alias{.dyncall.cdecl}
\alias{.dyncall.stdcall}
\alias{.dyncall.thiscall}
\alias{.dyncall.thiscall.msvc}
\alias{.dyncall.thiscall.gcc}
\alias{.dyncall.fastcall.msvc}
\alias{.dyncall.fastcall.gcc}
\title{Flexible Foreign Function Interface with support for most C types}
\description{  
Functions to call pre-compiled code with support for most C argument and return types. 
}
\usage{
.dyncall( address, signature, ... , callmode = "default" )
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
  \item{address}{external pointer to foreign function, e.g. resolved via \code{\link{.dynsym}} or \code{\link{getNativeSymbolInfo}}.}
  \item{signature}{character string specifying the foreign function type, see \sQuote{\link{call signature}} for details.}
  \item{callmode}{character string specifying the calling convention. This argument has no effect on most platforms, but on Microsoft's Windows 32-Bit OSs. See section \sQuote{Calling Convention} below for discussion.}
  \item{...}{arguments to be passed to the foreign function. Arguments are converted from R to C values according to the \link{call signature} specified in \code{signature}.}
}
\details{
The foreign function to be called is specified by \code{address}.
This is an external pointer which can be obtained from interface
functions to the dynamic linker of the OS, 
such as \code{\link{.dynsym}} or \code{\link{getNativeSymbolInfo}}. 

The \code{signature} is a character string that specifies the formal argument-and-return types of the 
foreign function using a signature string. 
It is important, that this string
matches the functional type of the foreign function. See \link{call signature} for details.

The calling convention is specified \emph{explicitly} via function \code{.dyncall}
using the \code{callmode} argument or \emph{implicitly} by using \code{.dyncall.*} 
functions. See details below.

Arguments passed via \code{...} are converted to C according to \code{signature} as described in the manual page on \link{type signature}s. 

Several basic argument type-safety checks are done during preparation of the
foreign function call: The arity of formals and actual arguments must match and they 
must be compatible as well.
Otherwise, the foreign function call is aborted with an error before risking a fatal system crash.

}
\value{  
The \code{.dyncall} and \code{.dyncall.}\emph{*} functions 
The functions return the received C return value wrapped into an R value according to the \sQuote{return type signature} specified by \code{\link{signature}}.
}
\section{Calling convention}{
Calling Conventions specify \sQuote{how} sub-routine calls are performed
on machine-level. They differ significantly among families of CPU Architectures 
as well as OS and Compiler implementations.

On most platforms, a single \code{"default"} C Calling Convention is used.
As an exception, the Windows 32-Bit Platform defines multiple standard calling
conventions. Most of the C libraries still use a \code{"default"} C ( also known as \code{"cdecl"} )
calling convention, but when working with Libraries that are considered Microsoft System APIs and DLLs, the \code{"stdcall"}
calling convention must be choosen. 


For practical reasons, the \code{callmode} argument does not have an effect on allmost
platforms,  except that it tells to use a specific calling convention when running
on a Windows 32-Bit platform. For example, when loading OpenGL across platforms, \code{"stdcall"} should be used instead of \code{"default"}, 
because on Windows, it is a System DLL. This is very exceptional, as in most othercases, \code{"cdecl"} should be used.

It follows a description of supported Win32 Calling Conventions:

\describe{
\item{\code{"cdecl"}}{Dummy alias to \emph{default}}
\item{\code{"stdcall"}}{C functions with \emph{stdcall} calling convention. Useful for all Microsoft Windows System Libraries (e.g. KERNEL32.DLL, USER32.DLL, OPENGL32.DLL ...). Third-party libraries usually prefer the default C \emph{cdecl} calling convention. }
\item{\code{"fastcall.msvc"}}{C functions with \emph{fastcall} calling convention compiled with Microsoft Visual C++ Compiler. Very rare usage.}
\item{\code{"fastcall.gcc"}}{C functions with \emph{fastcall} calling convention compiled with GNU C Compiler. Very rare usage.}
\item{\code{"thiscall"}}{C++ member functions.}
\item{\code{"thiscall.gcc"}}{C++ member functions compiled with GNU C Compiler.}
\item{\code{"thiscall.msvc"}}{C++ member functions compiled with Microsoft Visual C++ Compiler.}
}

At this stage of development, support for C++ calls should be considered experimental.
Support for Fortran is planed but not yet implemented in dyncall.
}
\section{Portability}{
The implementation is based on the \emph{dyncall} library (part of the DynCall project).
It has support for the following processor architectures: X86, X64, ARM (including THUMB support), PowerPC 32-bit, MIPS 32-bit and MIPS 64-bit.
The library has been ported to the following OSs: Linux, Mac OS X (no ppc64 support yet), Windows 32/64-bit, (Open-,Free-,Net-,DragonFly-) BSD, Haiku, Nexenta/Open Solaris, Minix, Plan9
as well as embedded platforms such as Linux/ARM (OpenMoko, Beagleboard, Gumstix), Nintendo DS (ARM), Sony Playstation Portable (MIPS 32-bit/eabi) and iOS (ARM - armv6 mode ok, armv7 unstable).
}
\note{
The target address, calling convention and call signature \strong{MUST} match foreign function type, otherwise the invocation could lead to a \strong{fatal R process crash}.

}
\examples{
mathlib <- dynfind(c("msvcrt","m","c"))
x <- .dynsym(mathlib,"sqrt")
.dyncall(x, "d)d", 144L)
}
\references{
  Adler, D., Philipp, T. (2008) \emph{DynCall Project}. 
  \url{http://dyncall.org}
}
\seealso{
\code{\link{signature}} for call signatures.
\code{\link{dynbind}} for automatic binding of multiple functions from shared libraries.
\code{\link[base]{getNativeSymbolInfo}} and \code{\link{.dynsym}}. 
\code{\link[base]{.C}} for the base FFI of R.
}
\keyword{programming}
\keyword{interface}
