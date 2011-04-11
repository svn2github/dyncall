\name{signature}
\alias{signature}
\alias{call signature}
\alias{callback signature}
\alias{function signature}
\alias{type signature}
\alias{library signature}
\title{Signature Format}
\description{Description of Signature Formats and Text Encoding}
\details{
The following page contains text string encodings and conversion rules for mapping types between R and C.
}
\section{Call Signatures}{
Call Signatures are used by \code{\link{.dyncall}} and \code{\link{callback}}s.
The general form of a call signature is as following:

\tabular{rcl}{
\emph{argument type signatures}.. \tab '\code{)}' \tab \emph{return type signature}\cr
}

The argument type signatures are specified in \emph{left-to-right} order \bold{without} white spaces in accordance with the C function type that will be interfaced.
See the next section for details on the argument and return type signatures.
Base type are specified using a one-character type code.  A closing bracket character '\code{)}' marks the end of argument types, followed by a
single return type signature. 
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

Here are some examples of some known C functions and corresponding call signatures:

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
}
\section{Structure Type Signatures}{
Structure Type Signatures describe the layout of aggregate \code{struct} C data type.
Type signatures are used within the \emph{field-types}. \emph{field-names} consists of space separated identifier names and
should match the number of fields.

\tabular{rcl}{
\emph{struct-name} '\{' \emph{field-types} \tab '\}' \emph{field-names} '\code{;}' \cr
}

Example:

The C \code{struct} type

\preformatted{
struct Rect \{ 
  signed short x, y; 
  unsigned short w, h;
\};
}

can be registered via:

\code{parseStructType("Rect{ssSS}x y w h;")}
}

\section{Union Type Signatures}{
Union Type Signatures describe the components of the \code{union} C data type.
Type signatures are used within the \emph{field-types}. \emph{field-names} consists of space separated identifier names and
should match the number of fields.

\tabular{rcl}{
\emph{union-name} '|' \emph{field-types} \tab '\}' \emph{field-names} '\code{;}' \cr
}

Example:

The C \code{union} type

\preformatted{
union Value \{ 
  int anInt; 
  float aFloat; 
  struct LongValue aStruct
\};
} 

can be registered via:

\code{parseUnionType("Value|if<LongValue>}anInt aFloat aStruct;")}

}
\seealso{
\code{\link{.dyncall}} for foreign function interface, \code{\link{dynbind}} for 
batched dynamic bindings,\code{\link{new.callback}} for use in callbacks,
\code{\link{.pack}} for (un-)packing interface and \code{\link{parseStructInfo}} for 
registration of aggregate types.

}
\keyword{programming}
\keyword{interface}
