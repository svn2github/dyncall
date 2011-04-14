\name{signature}
\alias{signature}
\alias{call signature}
\alias{function signature}
\alias{type signature}
\alias{library signature}
\title{Platform-portable Type Information Format to describe C types.}
\description{A simple and compact plain text format to encode descriptors of C function- and data types that are valid across platforms.}
\details{
The \pkg{rdyncall} package makes extensive use of type information encoded as text strings.
The low-level facilities offered by the package such as foreign function calls, wrappers for callbacks and handling of
foreign data types are data-driven by signatures - which makes the FFI very flexible and dynamic and does
such that foreign function calls, callbacks and the handling of aggregate data types is data-driven and
thus very flexible - developers can specify the signature dynamically at run-time without the need for
extra compilation of C code for each and every variant of a functionc call or data type.

The following list gives an overview of the formats and how they are related to each other.

\itemize{
\item Type Signatures describe fundamental C types. This notation is integrated into all signature formats below, because fundamental C typesh are contained in functions, callbacks as well as aggregate data types. 
\item Call Signatures describe C function calls and are used for foreign function calls and when wrapping R functions as callback C function pointers.
\item Library Signatures describe a series of library functions using names and call signatures.
\item Structure- and Union Type Signatures describe record-like C data types. 
}

}
\section{Type Signature}{
Type signatures are used within Call Signatures (see above),(un)-\code{\link{packing}} functions
to manipulate and extract C data types, and, to describe the field types within struct and union aggregate data types.

The following table lists valid type signatures, corresponding C types, acceptable R argument types and returned R types.

\tabular{clll}{
\strong{Type code} \tab \strong{C type}        \tab \strong{R input types}           \tab \strong{R output type}\cr
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
\emph{argument types signature}.. \tab '\code{)}' \tab \emph{return type signature}\cr
}

The \bold{argument types signature} is specified in \emph{left-to-right} order \bold{without} white spaces in accordance with the target C function type that will be called.
See the next section for details on the argument and return type signatures.
Base type are specified using a one-character type code.  A closing bracket character '\code{)}' marks the end of argument types, followed by a
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
by ';' (semicolon). Whitespaces are allowed to pre- and suffix the ';'.
\tabular{c}{
\emph{function-name} \samp{(} \emph{argument-types} \samp{)} \emph{return-type} \samp{;} \ldots \cr
}

Here is an example of a Library Signature for some OpenGL functions:

\preformatted{"glAccum(If)v ; glClear(I)v ;  glClearColor(ffff)v ;  fopen(*c*c)*<__sFILE>;"}

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

\code{"Value|if<LongValue>\}anInt aFloat aStruct;"}

}
\seealso{
\code{\link{.dyncall}} for foreign function interface, \code{\link{dynbind}} for 
batched dynamic bindings,\code{\link{new.callback}} for use in callbacks,
\code{\link{.pack}} for (un-)packing interface and \code{\link{parseStructInfo}} for 
registration of aggregate types.

}
\keyword{programming}
\keyword{interface}
