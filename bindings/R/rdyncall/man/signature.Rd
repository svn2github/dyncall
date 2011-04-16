\name{signature}
\alias{signature}
\alias{call signature}
\alias{function signature}
\alias{type signature}
\alias{library signature}
\title{Type Information Format for C Types}
\description{A Type Information Format comprising compact plain text \emph{signature} formats.
Signatures are platform-portable descriptors for C function- and data types. The format was
designed to be compact for performance reasons, but still human readable for rapid development purpose.}
\details{
The following list gives an overview of the formats and how they are related to each other.

\itemize{
\item Type Signatures describes single C data types ; The format is embedded into all other formats below.
\item Call Signatures describe C function calls and are used for foreign function calls and when wrapping R functions as callback C function pointers.
\item Library Signatures describe a series of library functions using names and call signatures.
\item Structure- and Union Type Signatures describe record-like C data types. 
}

}
\section{Type Signature}{
Type signatures are used by allmost all  Signatures and the low-level (un)-\code{\link{packing}} functions.

The following table gives a list of valid type signatures for all supported C types. 

\tabular{clll}{
\strong{Type Signature} \tab \strong{C type}        \tab \strong{valid R argument types}           \tab \strong{R return type}\cr
'\code{B}'           \tab bool                   \tab raw,logical,integer,double         \tab logical\cr
'\code{c}'           \tab char                   \tab raw,logical,integer,double         \tab integer\cr
'\code{C}'           \tab unsigned char          \tab raw,logical,integer,double         \tab integer\cr
'\code{s}'           \tab short                  \tab raw,logical,integer,double         \tab integer\cr
'\code{S}'           \tab unsigned short         \tab raw,logical,integer,double         \tab integer\cr
'\code{i}'           \tab int                    \tab raw,logical,integer,double         \tab integer\cr
'\code{I}'           \tab unsigned int           \tab raw,logical,integer,double         \tab double\cr
'\code{j}'           \tab long                   \tab raw,logical,integer,double         \tab double\cr
'\code{J}'           \tab unsigned long          \tab raw,logical,integer,double         \tab double\cr
'\code{l}'           \tab long long              \tab raw,logical,integer,double         \tab double\cr
'\code{L}'           \tab unsigned long long     \tab raw,logical,integer,double         \tab double\cr
'\code{f}'           \tab float                  \tab raw,logical,integer,double         \tab double\cr
'\code{d}'           \tab double                 \tab raw,logical,integer,double         \tab double\cr
'\code{p}'           \tab \emph{C type}* (pointer) \tab \emph{any vector},externalptr,NULL \tab externalptr\cr
'\code{Z}'           \tab char*                  \tab character,NULL                     \tab character or NULL\cr
'\code{x}'           \tab SEXP                   \tab \emph{any}                         \tab \emph{any}\cr
'\code{v}'           \tab void                   \tab \emph{invalid}                     \tab NULL\cr
'\code{*}' \ldots    \tab \emph{C type}* (pointer) \tab \emph{any vector},externalptr,NULL \tab externalptr\cr
"\code{*<}" \emph{typename} '\code{>}' \tab \emph{typename}* (pointer) \tab raw,externalptr \tab externalptr\cr
}

}
\section{Call Signatures}{
Call Signatures are used by \code{\link{.dyncall}} and \code{\link{new.callback}} to describe foreign C function types.
The general form of a call signature is as following:

\tabular{rcl}{
\emph{argument-types} \tab '\code{)}' \tab \emph{return-type}\cr
}

The calling sequence given by the \bold{argument types signature} is specified in direct \emph{left-to-right} order of the formal argument types defined in C.
The type signature characters and more complex building blocks (like typed pointers) are put in sequence without any white space.
Base type are specified using a one-character character.  A closing bracket character '\code{)}' marks the end of argument types, followed by a
single \bold{return type signature}. 

Here are some examples of C library functions and corresponding call signatures:

\tabular{ll}{
\code{double sqrt(double);}                    \tab "\code{d)d}"    \cr
\code{double dnorm(double,double,double,int);} \tab "\code{dddi)d}" \cr
\code{void   R_isort(int*,int);}               \tab "\code{pi)v}"   \cr
\code{void   revsort(double*,int*,int);}       \tab "\code{ppi)v}"  \cr
}
}

\section{Library Signature}{
The library signature is a text-based representation for a set of function bindings.
It consists of function names and corresponding call signatures. Function bindings are separated 
by ';' (semicolon). White spaces are allowed to pre- and suffix the ';'.
\tabular{c}{
\emph{function-name} \samp{(} \emph{argument-types} \samp{)} \emph{return-type} \samp{;} \ldots \cr
}

Here is an example of a Library Signature:

\preformatted{"glAccum(If)v ; 
glClear(I)v ;  
glClearColor(ffff)v ;  
fopen(*c*c)*<__sFILE>;"}
}
\section{Structure Type Signatures}{
Structure Type Signatures describe the layout of aggregate \code{struct} C data types.
Type Signatures are used within the \emph{field-types}. \emph{field-names} consists of space separated identifier names and
should match the number of fields.

\tabular{rcl}{
\emph{struct-name} '\{' \emph{field-types} \tab '\}' \emph{field-names} '\code{;}' \cr
}

Example:

Here is an example of a C \code{struct} type:

\preformatted{
struct Rect \{ 
  signed short x, y; 
  unsigned short w, h;
\};
}

The corresponding Structure Type Signature is:

\preformatted{"Rect\{ssSS\}x y w h;"}

}

\section{Union Type Signatures}{

Union Type Signatures describe the components of the \code{union} C data type.
Type signatures are used within the \emph{field-types}. \emph{field-names} consists of space separated identifier names and
should match the number of fields.

\tabular{rcl}{
\emph{union-name} '|' \emph{field-types} \tab '\}' \emph{field-names} '\code{;}' \cr
}

Here is an example of a C \code{union} type,

\preformatted{
union Value \{ 
  int anInt; 
  float aFloat; 
  struct LongValue aStruct
\};
} 

The corresponding Union Type Signature is:

\code{"Value|if<LongValue>}anInt aFloat aStruct;"}

}
\seealso{
\code{\link{.dyncall}} for calling foreign functions, \code{\link{dynbind}} for 
binding functions in batch-mode, \code{\link{new.callback}} for use in callbacks,
\code{\link{.pack}} for (un-)packing interfaces and \code{\link{parseStructInfos}} for 
registration of aggregate types.

}
\keyword{programming}
\keyword{interface}
