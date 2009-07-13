\name{dyncall}
\alias{.dyncall}
\alias{.dyncall.cdecl}
\alias{.dyncall.stdcall}
\title{Foreign Function Interface to binary code with support for multiple calling conventions.}
\description{  
Functions to make calls to precompiled code with support for multiple calling conventions.
}
\usage{
.dyncall( address, signature, ... , callmode = c("cdecl","stdcall") )
.dyncall.cdecl        ( address, signature, ... )
.dyncall.stdcall      ( address, signature, ... )
.dyncall.fastcall.msvc( address, signature, ... )
.dyncall.fastcall.gcc ( address, signature, ... )
.dyncall.thiscall.msvc( address, signature, ... )
.dyncall.thiscall.gcc ( address, signature, ... )
}
\arguments{
  \item{address}{An external pointer to a foreign function such as returned by .dynsym or getNativeSymbolInfo.}
  \item{signature}{A character string specifying the argument and return type of a function call.}
  \item{callmode}{A character string specifying the calling convention.}
  \item{...}{Any arguments to be passed via dyncall according to the argument types specified in \code{signature}.}
}
\value{
The return value of the foreign function call converted to an \R type according to the return type character
given by \code{signature}.
}
\details{

A valid \code{address} to a foreign function can be obtained from functions such as \code{\link{.dynsym}} and \code{\link{getNativeSymbolInfo}}. 
}
\section{test}{
The \code{signature} is a character string that encodes the arity (number of arguments) 
and formal argument- and return-types using a character-based type code.

The calling convention is specified explicitly by the \code{callmode} argument 
using \code{.dyncall} or implicitly by using \code{.dyncall.*} functions. 

The arguments given with \code{...} are passed and possibly converted according to 
the given signature.
}
\section{Signature}{

The general form of a dyncall signature string is

\tabular{rcl}{
\emph{Argument types}.. \tab '\code{)}' \tab \emph{Return type}\cr
}

A type is specified using a one-character type code. The argument type characters are specified 
in \emph{left-to-right} order of the corresponding C function prototype. 
A closing bracket character \code{')'} marks the end of input argument types. Finally, a return type character is given
to specify the return value. 
The following table lists valid type character codes, corresponding C types, acceptable R argument types and returned R types.

\tabular{clll}{
\strong{Type code} \tab \strong{C type}        \tab \strong{R argument type}           \tab \strong{R return type}\cr
\code{B}           \tab bool                   \tab raw,logical,integer,double         \tab logical\cr
\code{c}           \tab char                   \tab raw,logical,integer,double         \tab integer\cr
\code{C}           \tab unsigned char          \tab raw,logical,integer,double         \tab integer\cr
\code{s}           \tab short                  \tab raw,logical,integer,double         \tab integer\cr
\code{S}           \tab unsigned short         \tab raw,logical,integer,double         \tab integer\cr
\code{i}           \tab int                    \tab raw,logical,integer,double         \tab integer\cr
\code{I}           \tab unsigned int           \tab raw,logical,integer,double         \tab double\cr
\code{j}           \tab long                   \tab raw,logical,integer,double         \tab double\cr
\code{J}           \tab unsigned long          \tab raw,logical,integer,double         \tab double\cr
\code{l}           \tab long long              \tab raw,logical,integer,double         \tab double\cr
\code{L}           \tab unsigned long long     \tab raw,logical,integer,double         \tab double\cr
\code{f}           \tab float                  \tab raw,logical,integer,double         \tab double\cr
\code{d}           \tab double                 \tab raw,logical,integer,double         \tab double\cr
\code{p}           \tab \emph{C type}* (pointer) \tab \emph{any vector},externalptr,NULL \tab externalptr,NULL\cr
\code{S}           \tab char*                  \tab character,NULL                     \tab character,NULL\cr
\code{x}           \tab SEXP                   \tab \emph{any}                         \tab \emph{any}\cr
\code{v}           \tab void                   \tab \emph{invalid}                     \tab NULL\cr
}

As input one can use logical, integer, double and raw for C/C++ boolean, integer and floating point types, where
the first item of the R vector is casted to the C type and then gets loaded as argument.
Pointers (type char '\code{p}') are handled such that the data pointer of R atomic vectors are loaded as arguments with
the exception of R character vectors, where the first R character string gets loaded. NULL is interpreted as a C NULL pointer.

A more high-level framework is set up on top the one-character type encodings to include support for
C structure and union types.

A pointer type mapping can also be expressed using one or more '\code{*}' prefix signature codes.
C structures and unions can be used such as using '\code{<}' \emph{type-name} '\code{>}'.

If used as a return type, the returned external pointer has the \code{struct} attribute set to that name,
so that the structure/union type information works.

Some examples of C function prototypes and corresponding function type signatures:

\tabular{ll}{
\code{double sqrt(double);}                    \tab \code{"d)d"}    \cr
\code{double dnorm(double,double,double,int);} \tab \code{"dddi)d"} \cr
\code{void   R_isort(int*,int);}               \tab \code{"pi)v"}   \cr
\code{char   foo(int,double,float,bool);}      \tab \code{"idfB)c"} \cr
\code{void   revsort(double*,int*,int);}       \tab \code{"ppi)v"}  \cr
}
}
\section{Calling conventions}{
Calling conventions specify on the machine-level how a function call is invoked.

The conventions differ heavily from CPU type to CPU type. Some conventions 
are related to OS and Compiler issues.
While on many processor architectures, there is only one general calling 
convention - there are multiple calling conventions available on the x86 
processor architecture and in particular when working with Microsoft Windows 
system libraries.

In general, many prebuilt binaries available online will work fine with \code{"default"}.
Windows System DLLs require \code{"stdcall"} instead. 

\describe{
\item{\code{"default"} or \code{"cdecl"}}{ Default C calling convention. }
\item{\code{"stdcall"}}{ Available on the X86 architecture, otherwise falls back to "cdecl". Use when linking Microsoft Windows System Libraries (e.g. KERNEL32.DLL, USER32.DLL, OPENGL32.DLL ...). }
\item{\code{"thiscall.gcc"}}{ Available on the X86 architecture, otherwise falls back to "cdecl". Use when calling C++ member functions that are linking x86 C++ shared libraries compiled with GCC using \code{__thiscall}.}
\item{\code{"thiscall.msvc"}}{ Available on the X86 architecture, otherwise falls back to "cdecl". Use when linking x86 shared libraries compiled with Visual C++ using \code{__thiscall}. }
\item{\code{"fastcall.msvc"}}{ Available on the X86 architecture, otherwise falls back to "cdecl". }
\item{\code{"fastcall.gcc"}}{ Available on the X86 architecture, otherwise falls back to "cdecl". }
}

In principle OS foreign function calls are possible with the dyncall library,
but we have not yet implemented support on that (x64 needs an update to choose among both (sysv and win64) at run-time).
In a later release you can expect to have more choice such as:

\describe{
\item{\code{"ppc.osx"}}{Mac OS X Code on PowerPC 32-bit}
\item{\code{"ppc.sysv"}}{ELF-based code on PowerPC 32-bit}
\item{\code{"x64.win64"}}{Windows 64-bit code (on X64 Architecture)}
\item{\code{"x64.sysv"}}{ELF-based code on X64 Architecture}
}

In many cases, \code{"cdecl"} is the best choice. Exceptions to this include, X86 architectures and in particular
Microsoft Windows platforms. 

The calling convention is defined during compilation of shared libraries. 
One specifies the calling convention using function prototype attributes such as 
\code{__attribute__((stdcall))} or \code{__stdcall} for short.

On X86 Architectures, the \emph{fastcall} and \emph{thiscall} (C++) calling convention differ 
regarding Microsoft Visual C++ and the GCC compilers. 
\code{"fastcall.msvc"} and \code{"thiscall.msvc"} are used for the Microsoft Visual C++ compiled code, while
\code{"fastcall.gcc"} and \code{"fastcall.gcc"} use GCC compiled code. 

}
\note{
When invoking a foreign function calls, the address, calling convention and 
type information for arguments and return values \strong{MUST} match with 
the compiled function. 
Otherwise the invocation can lead to a \strong{fatal system crash}.

Calling functions via dyncall is very TYPE UNSAFE. Some safety is achieved.
Dyncall does not perform any call, if you missed the arity of the function given with the signature and
probably fails on several type-incompatibilities. But in general, there
is no safe way to test if the pointer given, is a valid function pointer.
Thus, this package can cause unexpected behaviour if the user is
not aware of what she is doing. USE ON YOUR OWN RISK.
}

\examples{
rlib <- dynfind("R")
x <- .dynsym(rlib,"sqrt")
.dyncall(x, "d)d", 144L)
}
\references{
  Adler, D., Philipp, T. (2008) \emph{DynCall Library}. 
  \url{http://dyncall.org}
}
\author {
  Daniel Adler \email{dadler@uni-goettingen.de}
}
\seealso{
\code{\link{dynbind}} for automatic binding of multiple functions from shared
libraries.
\code{\link{getNativeSymbolInfo}} and \code{\link{dyn.lad}}. 
\code{\link{.C}},\code{\link{.Call}},,\code{\link{.External}}
}
\keyword{interface}
\keyword{programming::interface}
