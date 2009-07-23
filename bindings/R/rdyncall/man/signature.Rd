\name{signature}
\alias{signature}
\title{Signature Format}
\description{Description of the Signature Format and Text Encoding}
\details{
The function call signature string is of the form:

\tabular{rcl}{
\emph{argument-types}.. \tab '\code{)}' \tab \emph{return-type}\cr
}

The argument type characters are specified in \emph{left-to-right} order of the corresponding C function prototype.
Base type are specified using a one-character type code.  A closing bracket character '\code{)}' marks the end of argument types, followed by the
return type specification. 
The following table lists valid type character codes, corresponding C types, acceptable R argument types and returned R types.

\tabular{clll}{
\strong{Type code} \tab \strong{C type}        \tab \strong{R argument type}           \tab \strong{R return type}\cr
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
'\code{Z}'           \tab char*                  \tab character,NULL                     \tab character,NULL\cr
'\code{x}'           \tab SEXP                   \tab \emph{any}                         \tab \emph{any}\cr
'\code{v}'           \tab void                   \tab \emph{invalid}                     \tab NULL\cr
'\code{*}' \ldots    \tab \emph{C type}* (pointer) \tab emph{any vector},externalptr,NULL \tab externalptr\cr
'\code{*<}' \emph{typename} '\code{>}' \tab \emph{typename}* (pointer) \tab raw,externalptr \tab externalptr\cr
}
}
\seealso{
\code{\link{.dyncall}} for foreign function interface, \code{\link{dynbind}} for 
batched dynamic bindings and \code{\link{new.callback}} for use in callbacks. 
}
\keyword{programming}
\keyword{interface}
