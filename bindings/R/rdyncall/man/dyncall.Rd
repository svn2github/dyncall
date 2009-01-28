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
}
\value{
}

\section{Table of dyncall signature characters}{

\tabular{clll}{
Signature char \tab C type \tab Accepted R types \cr
B \tab \code{bool}      \tab raw,logical,integer,double \cr
c \tab \code{char}      \tab raw,logical,integer,double \cr
s \tab \code{short}     \tab raw,logical,integer,double \cr
i \tab \code{int}       \tab raw,logical,integer,double \cr
l \tab \code{long}      \tab raw,logical,integer,double \cr
f \tab \code{float}     \tab raw,logical,integer,double \cr
d \tab \code{double}    \tab raw,logical,integer,double \cr
L \tab \code{long long} \tab raw,logical,integer,double \cr
p \tab \code{void}      \tab atomic,character,externalptr and NULL\cr
S \tab \code{char}      \tab character and NULL\cr
v \tab \code{void}      \tab \emph{not allowed}\cr
x \tab \code{SEXP}      \tab \emph{any}        \cr
}


\tabular{clll}{
Signature char \tab C type           \tab Accepted types       \tab Return types        \cr
\sQuote{B}     \tab \code{bool}      \tab raw,logical,integer,double          \tab logical             \cr
\sQuote{c}     \tab \code{char}      \tab R,L,I,D          \tab integer \cr
\sQuote{s}     \tab \code{short}     \tab R,L,I,D         \tab integer \cr
\sQuote{i}     \tab \code{int}       \tab R,L,I,D          \tab integer \cr
\sQuote{l}     \tab \code{long}      \tab R,L,I,D          \tab integer \cr
\sQuote{f}     \tab \code{float}     \tab R,L,I,D          \tab double  \cr
\sQuote{d}     \tab \code{double}    \tab R,L,I,D          \tab double  \cr
\sQuote{L}     \tab \code{long long} \tab raw,logical,integer,double,complex,character,externalptr,NULL          \tab double  \cr
\sQuote{p}     \tab \code{void*}     \tab R,L,I,D,C,S,P,N      \tab externalptr or NULL \cr
\sQuote{S}     \tab \code{char*}     \tab S,P,N       \tab string or NULL      \cr
\sQuote{v}     \tab \code{void}      \tab \emph{not allowed} \tab NULL   \cr
\sQuote{x}     \tab \code{SEXP}      \tab \emph{any}         \tab any     \cr
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


