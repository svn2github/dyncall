\name{struct}
\alias{struct}
\alias{new.struct}
\alias{as.struct}
\alias{parseStructInfos}
\alias{parseUnionInfos}
\alias{$.struct}
\alias{print.struct}
\alias{$<-.struct}
\title{Allocation and handling of foreign C aggregate data types}
\description{Functions for allocation, access and registration of foreign C \code{struct} and \code{union} data type.}
\usage{
\S3method{$}{struct}(x, index)
\S3method{$}{struct}(x, index) <- value
\S3method{print}{struct}(x, indent=0, \ldots)
new.struct(type)
as.struct(x, type)
parseStructInfos(sigs, envir=parent.frame())
parseUnionInfos(sigs, envir=parent.frame())
}
\arguments{
  \item{x}{external pointer or atomic raw vector of S3 class 'struct'.}
  \item{type}{S3 \link{TypeInfo} Object or character string that names the structure type.}
  \item{sigs}{character string that specifies several C struct/union type \link{signature}s.}
  \item{envir}{the environment to install S3 type information object(s).} 
  \item{index}{character string specifying the field name.}
  \item{indent}{indentation level for pretty printing structures.}
  \item{value}{value to be converted according to struct/union field type given by field index.}
  \item{...}{additional arguments to be passed to \code{\link[base]{print}} method.}
}
\details{

Foreign C aggregate ( \code{struct} and \code{union} ) data and pointer-to-data 
objects can be manipulated using the \dQuote{$} operator.
This is handled by R objects of S3 class \code{struct}.

Basically, two R objects are used to reference foreign C data. External pointers reference pointers to some foreign data.
New objects of a foreign data type can be allocated via the \code{new.struct} function. In this case, the memory is managed
by R using an atomic \code{raw} object that is of S3 class \code{struct}.

Two types of foreign C objects are supported:

\itemize{
  \item \emph{external pointers}, returned by \code{\link{.dyncall}} using a call signature with a typed pointer expression in the return type signature. 
  \item \emph{new objects} of a foreign C data type are \code{new.struct} function:
An atomic \code{raw} object is used for storage, initialized with length equal to the size of the
C foreign \code{type}.
}
 
In order to access and manipulate the data fields of foreign C data types, the \dQuote{$} and \dQuote{$<-} S3 operator methods
can be used.

The type information is given by S3 objects of class \code{\link{typeinfo}}.

Before using a foreign C data type in R, an S3 object of class \code{\link{typeinfo}} need
to be installed. This is done via using \code{parseStructInfos} and  
\code{parseUnionInfos}. Foreign C data types are described by a signature character string.
The format for both types are described below:

\strong{Structure type signatures} describe the layout of aggregate \code{struct} C data types.
Type Signatures are used within the \sQuote{field-types}. \sQuote{field-names} consists of space separated identifier names and
should match the number of fields.

\tabular{rcl}{
\sQuote{struct-name} '\{' \sQuote{field-types} \tab '\}' \sQuote{field-names} '\code{;}' \cr
}

Here is an example of a C \code{struct} type:

\preformatted{
struct Rect \{ 
  signed short x, y; 
  unsigned short w, h;
\};
}

The corresponding Structure type signature is:

\preformatted{"Rect\{ssSS\}x y w h;"}

\strong{Union type signatures} describe the components of the \code{union} C data type.
Type signatures are used within the \sQuote{field-types}. \sQuote{field-names} consists of space separated identifier names and
should match the number of fields.

\tabular{rcl}{
\sQuote{union-name} '|' \sQuote{field-types} \tab '\}' \sQuote{field-names} '\code{;}' \cr
}

Here is an example of a C \code{union} type,

\preformatted{
union Value \{ 
  int anInt; 
  float aFloat; 
  struct LongValue aStruct
\};
} 

The corresponding Union type signature is:

\code{"Value|if<LongValue>}anInt aFloat aStruct;"}

\code{as.struct} can be used to \emph{cast} a structure into a different type. This is not type-safe and can lead to a \strong{fatal R process crash}
if used on pointers.
}
\seealso{
\code{\link{signature}} for details on the Structure and Union Type Signatures and \code{\link{.dyncall}} for foreign function calls and \code{\link{TypeInfo}} for details on S3 run-time type information objects.
}
\examples{
# Specify the following foreign type:
# struct Rect {
#   short x, y;
#   unsigned short w, h;
# }
parseStructInfos("Rect{ssSS}x y w h;")
r <- new.struct(Rect)
print(r)
r$x <- 40
r$y <- 60
r$w <- 10
r$h <- 15
print(r)
str(r)
}
\keyword{programming}
\keyword{interface}
