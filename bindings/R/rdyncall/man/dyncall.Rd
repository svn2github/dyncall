\name{dyncall}
\alias{dyncall}
\alias{rdyncall-package}
\alias{.dyncall}
\alias{.dyncall.cdecl}
\alias{.dyncall.stdcall}
\title{Foreign Function Interface to compiled code with support for multiple C calling conventions.}
\description{  
Functions to make calls to compiled code with support for multiple C calling conventions.
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
  \item{address}{An external pointer to a foreign function.}
  \item{signature}{A character string specifying the argument and return type of a function call, see Details below for more information.}
  \item{callmode}{A character string specifying the calling convention.}
  \item{...}{Any arguments to be passed via dyncall according to the argument types specified in \code{signature}.}
}
\value{
The return value of the foreign function call converted to an \R type according to the return type character
given by \code{signature}.
}
\details{
A valid \code{address} to a foreign function can be obtained from functions such as \code{\link{.dynfind}} and \code{\link{getNativeSymbolInfo}}. 

The \code{signature} is a character string that encodes the 
arity (number of arguments) and formal argument- and return-types using a character-based
type code.

The calling convention is specified explicitly by the \code{callmode} argument using \code{.dyncall} or 
implicitly by using \code{.dyncall.*} functions. 

The arguments given with \code{...} are passed and possibly converted according to the given signature.


}
\section{Signature}{

The general form of a dyncall signature string is

\tabular{rcl}{
\emph{Argument types} \tab \code{)} \tab \emph{Return type}\cr
}

A type is specified using a single positional character. The optional argument type characters are specified 
in left-to-right order of the corresponding C function prototype. 
A closing bracket character (")") marks the end of input argument types. Finally, one return type character terminates
the signature string.

\tabular{clll}{
\strong{Type code} \tab \strong{C type}  \tab \strong{R argument type}           \tab \strong{R return type}\cr
\code{B}           \tab bool             \tab raw,logical,integer,double         \tab logical\cr
\code{c}           \tab char             \tab raw,logical,integer,double         \tab integer\cr
\code{s}           \tab short            \tab raw,logical,integer,double         \tab integer\cr
\code{i}           \tab int              \tab raw,logical,integer,double         \tab integer\cr
\code{l}           \tab long             \tab raw,logical,integer,double         \tab integer\cr
\code{f}           \tab float            \tab raw,logical,integer,double         \tab double \cr
\code{d}           \tab double           \tab raw,logical,integer,double         \tab double \cr
\code{L}           \tab long long        \tab raw,logical,integer,double         \tab double \cr
\code{p}           \tab \emph{any}* (pointer)           \tab \emph{any vector},externalptr,NULL \tab externalptr,NULL\cr
\code{S}           \tab char*            \tab character,NULL                     \tab character,NULL\cr
\code{x}           \tab SEXP             \tab \emph{any}                         \tab \emph{any}\cr
\code{v}           \tab void             \tab \emph{invalid}                     \tab NULL\cr
}

Some examples of C function prototypes and corresponding function type signatures:

\tabular{ll}{
\code{double sqrt(double);}                    \tab \code{"d)d"}    \cr
\code{double dnorm(double,double,double,int);} \tab \code{"dddi)d"} \cr
\code{void   R_isort(int*,int);}               \tab \code{"pi)v"}   \cr
\code{void   revsort(double*,int*,int);}       \tab \code{"ppi)v"}  \cr
\code{char   foo(int,double,float,bool);}      \tab \code{"idfB)c"} \cr
}

}
\section{Calling conventions}{
Most often, the callmode is \code{"cdecl"}. Exceptions to this include:

\itemize{
  \item Microsoft Windows 32-bit Application Programming Interfaces are \code{"stdcall"} such as USER32.DLL and OPENGL32.DLL.
}

The calling convention is defined during compilation of shared libraries. 
One specifies the calling convention using function prototype attributes such as 
\code{__attribute__((stdcall))} or \code{__stdcall} for short.

The fast and thiscall (C++) calling convention differ among compilers. When using
functions that have been compiled using \code{__fastcall} calling convention, it is
crucial to know which compiler was used to generate the code. Microsoft Visual C++ compilers
use a different calling convention than GCC compilers.

\emph{return-type} \emph{attributes} \emph{function-name} ( \emph{argument-types} ); 

A selective calling convention comes into play on Intel X86 platforms and in particular on Microsoft Windows, where
several System libraries are precompiled using C \code{__stdcall} calling convention instead of \code{__cdecl}.
}
\note{
When invoking a foreign function calls, the address, calling convention and 
type information for arguments and return values \strong{MUST} match with 
the compiled function. 
Otherwise the invocation can lead to a \strong{fatal system crash}.

Calling functions via dyncall is 100\% UNSAFE. Dyncall does not perform any
call, if you missed the arity of the function given with the signature and
probably fails on several type-incompatibilities. But in general, there
is no safe way to test if the pointer given, is a valid function pointer.
Thus, this package can cause unexpected behaviour if the user is
not aware of what she is doing. USE ON YOUR OWN RISK.
}

\examples{
# load 'R' dynport
libR <- .dynload("R")
reg.finalizer(libR, .dynunload)
.dynfind(.libR, "") 
# load platform-specific standard C DLL
 
clibname <- "libc"
if (.Platform$OS.type == "windows") clibname <- "msvcrt"
if (.Platform$OS.type == "darwin") clibname <- "libc.dylib"
if (.Platform$OS.type == "linux") clibname <- "libc.so.6"

dyn.load(clibname)
sqrt.ptr <- getNativeSymbolInfo("sqrt")
mysqrt <- function(x) .dyncall.cdecl(sqrt.ptr, "d)d", x)

aDouble <- 144
anInteger <- 144L

mysqrt(aDouble)
mysqrt(anInteger)

clib <- rdcLoad(clibname)

# call sqrt function

sqrt.fp <- rdcFind(clib,"sqrt")
print( rdcCall(sqrt.fp, "d)d", 144) )

}
\references{
  Adler, D., Philipp, T. (2008) \emph{DynCall Library}. 
  \url{http://dyncall.org}
}
\author {
  Daniel Adler \email{dadler@uni-goettingen.de}
}
\keyword{programming::interface}
\seealso{
\code{\link{getNativeSymbolInfo}} and \code{\link{.dynfind}}. 
\code{\link{.C}},\code{\link{.Call}},,\code{\link{.External}}
}
