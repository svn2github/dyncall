\name{dyncall}
\alias{.dyncall}
\alias{.dyncall.cdecl}
\alias{.dyncall.stdcall}
\title{Foreign Function Interface to compiled code with support for multiple C/C++ calling conventions.}
\description{  
Functions to make calls to compiled code with support for multiple C/C++ calling conventions.
}
\usage{
.dyncall( address, signature, ... , callmode = c("cdecl","stdcall") )
.dyncall.cdecl( address, signature, ... )
.dyncall.stdcall( address, signature, ... )
}

\arguments{
  \item{address}{an external pointer to foreign function e.g. resolved by a symbol.}
  \item{signature}{a character string specifying the argument and return type of a function call, see Details below for more information.}
  \item{callmode}{a character string specifying the calling convention.}
}

\details{
\section{Calling Conventions}{
On Intel X86 Machines, a wide range of calling conventions exists and it is not uncommon
that multiple calling conventions can co-exist at run-time. Thus, dyncall provides means
to allow calling multiple standards in one session.
}
\section{Garbage Collector Effects}{
 
}
\section{Calling Microsoft Windows System Libraries}{
Calling Microsoft Windows system libraries from the Win32 API such as USER32.DLL and 
OPENGL32.DLL, the default calling convention is stdcall, while most C precompiled code
uses cdecl.
}
\section{Brief introduction}{
The correct function call signature and calling convention specifies a full qualified
foreign function call for the dyncall library.
}   
\section{Dyncall Signature}{
When calling foreign functions, dyncall needs to know exact type information for
argument and return types.

A \code{signature} is a character string that encodes the 
arity (number of arguments) and formal argument- and return-types using a character-based
type code.

The general form of a dyncall signature string is:
    
\deqn{sigchar_{arg_0} sigchar_{arg_1} \ldots ')' sigchar_{return}}{<sigchar-arg0> <sigchar-arg1> \ldots ')' <sigchar-return>}

Each low-level function call argument and return type is encoded with a character code. 
A closing bracket character (")") separates the argument with the return type.
}
\section{Table of dyncall signature characters}{

\tabular{clll}{
Signature char \tab C type           \tab Accepted types       \tab Return types \cr
\sQuote{B}     \tab \code{bool}      \tab \code{RLIDxxxx}      \tab logical \cr
\sQuote{c}     \tab \code{char}      \tab \code{RLIDxxxx}      \tab integer \cr
\sQuote{s}     \tab \code{short}     \tab \code{RLIDxxxx}      \tab integer \cr
\sQuote{i}     \tab \code{int}       \tab \code{RLIDxxxx}      \tab integer \cr
\sQuote{l}     \tab \code{long}      \tab \code{RLIDxxxx}      \tab integer \cr
\sQuote{f}     \tab \code{float}     \tab \code{RLIDxxxx}      \tab double  \cr
\sQuote{d}     \tab \code{double}    \tab \code{RLIDxxxx}      \tab double  \cr
\sQuote{L}     \tab \code{long long} \tab \code{RLIDxxxx}      \tab double  \cr
\sQuote{p}     \tab \code{void*}     \tab \code{RLIDCSPN}      \tab externalptr or NULL \cr
\sQuote{S}     \tab \code{char*}     \tab \code{xxxxxSPN)      \tab string or NULL  \cr
\sQuote{v}     \tab \code{void}      \tab \strong{not allowed} \tab NULL    \cr
\sQuote{x}     \tab \code{SEXP}      \tab \strong{any}         \tab any     \cr
}

\code{RLIDCSPN}:
\tabular{cl}{
\code{R} \tab raw \cr
\code{L} \tab logical\cr
\code{I} \tab integer\cr
\code{D} \tab double\cr
\code{C} \tab complex\cr
\code{S} \tab character\cr
\code{P} \tab external pointer \cr
\code{N} \tab NULL\cr
}

}

\section{Argument type passing from R to dyncall}{
Signature char \tab C type           \tab accepted R data types        \cr
\sQuote{B}     \tab \code{bool}      \tab raw, logical, integer, double\cr
\sQuote{c}     \tab \code{char}      \tab raw, logical, integer, double\cr
\sQuote{s}     \tab \code{short}     \tab raw, logical, integer, double\cr
\sQuote{i}     \tab \code{int}       \tab raw, logical, integer, double\cr
\sQuote{l}     \tab \code{long}      \tab raw, logical, integer, double\cr
\sQuote{f}     \tab \code{float}     \tab raw, logical, integer, double\cr
\sQuote{d}     \tab \code{double}    \tab raw, logical, integer, double\cr
\sQuote{L}     \tab \code{long long} \tab raw, logical, integer, double\cr
\sQuote{p}     \tab \code{void*}     \tab externalptr, raw, logical, integer, double, complex, character, NULL\cr
\sQuote{S}     \tab \code{char*}     \tab externalptr, character, NULL\cr
\sQuote{v}     \tab \code{void}      \tab NULL\cr
}
}

\section{Return type conversion from dyncall to R}{
\tabular{cll}{
Signature char \tab C type           \tab accepted R data types\cr
\sQuote{B}     \tab \code{bool}      \tab logical\cr
\sQuote{c}     \tab \code{char}      \tab raw\cr
\sQuote{s}     \tab \code{short}     \tab integer\cr
\sQuote{i}     \tab \code{int}       \tab integer\cr
\sQuote{l}     \tab \code{long}      \tab integer\cr
\sQuote{f}     \tab \code{float}     \tab double\cr
\sQuote{d}     \tab \code{double}    \tab double\cr
\sQuote{L}     \tab \code{long long} \tab double\cr
\sQuote{p}     \tab \code{void*}     \tab externalptr or NULL\cr
\sQuote{S}     \tab \code{char*}     \tab character or NULL\cr
\sQuote{v}     \tab \code{void}      \tab NULL\cr
}
}


value types: bool,char,short,int,long,float,double,long long
  accepted types: first element of R vector. Any atomic R vector such as raw, logical, integer and double atomic
  is valid and will be C casted to the target value type.
  Return value is casted to atomic R vector.
    
pointer types: void*,char*
  external pointers are returned.
no return type: void

\section{By-value scalar types}{

Any R vector type such as raw, logical, integer and double atomic R vector is accepted
for by-value.

By-value scalar argument types such as bool, char, short, int, long, float, double and long long
accept .


By-pointer

Accepted are types are fixed-width

Such as bool, char, short, int, long, float, double and long long 
accept any fixed-width atomic R data type such as raw, logical, integer or double vector.


extract the first element and automatically cast to the underlying type.

When using by-pointer argument types such as void* and char*, externalptrs are to transmit
raw pointer information, while raw, logical, integer, double and character vectors         

When using R characters in by-pointer arguments, the address of the first character in the first element is taken.

The order of the arguments is left-to-right according to the C prototyp function declaration.

}   
\section{Passing arguments}{

 that were
given at the time the C function was compiled.
Together with the knowledge about the calling convention, dyncall is able to call such
functions dynamically.
  
The dyncall \code{signature} character string specifies the types for argument and return values.
Only plain by-value C types are supported and no sup 
consists of a series of type codes (given as ordinary characters) 
to specify the argument (input) and return (output) type, separated by the ')' character.



A signature character encodes the C type at the given argument position or return-type.




e.g. the signature string of the function \samp{double foobar(int a, long long b, float c);} is \code{"iLf)d"}.
}

The dyncall library provides a foreign function call interface with
support for multiple architectures and  

It is lightweight.


The signature


The rdyncall package provides tools to establish flexible function calls to low-level precompiled code.
It is more flexible than \code{\link{.C}} and has the same type-unsafety dangers.
One can make arbitrary C (and C++ member-) function calls.

The language binding was designed to help write glue code to low-level C libraries in R (if the target library function is compatible with
the supported typeset and calling convention).
It makes use of signature strings to specify the function prototyp to call. 

to providing a thin binding layer between the core
dyncall library and the R programming language.

The loading and unloading of code modules (*.DLL files on windows, *.dylib files on darwin and *.so files on other *nix flavour OSs)
is done using rdcLoad, similar to \code{\link{dyn.load}}. While \code{\link{dyn.load}} loads a DLL to the R run-time process,
rdcLoad returns the module handle as an external pointer.

Symbol lookup is done using \code{rdcFind} and returns an external pointer pointing to the foreign function.

The \code{rdcCall} function does invoke the function call.
 s and the expected return type of the foreign function call which are separated by an ')' character.


\section{TODO}{

\itemize{
\item Description of the signature. 
\item Callmode has only effect on Windows Platform currently.
\item Dyncall limitations:
  \itemize{
    \item passing of structures
  }
\item Howto:
  \itemize{
    \item handling of C pointer types in R
    \item passing R objects as arrays
  } 
}

}

}
\examples{


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
  Adler, D., Philipp, T. (2008) \emph{Dyncall Library}. 
  \url{http://dyncall.org}
}
\author {
  Daniel Adler \email{dadler@uni-goettingen}
}
\examples {
  # bla

}
\keyword{programming::interface}


