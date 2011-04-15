\name{struct}
\alias{struct}
\alias{new.struct}
\alias{as.struct}
\alias{parseStructInfos}
\alias{parseUnionInfos}
\alias{$.struct}
\alias{print.struct}
\alias{$<-.struct}
\title{Allocation and access to foreign C data types.}
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
  \item{type}{S3 TypeInfo Object or character string that names the structure type.}
  \item{sigs}{character string that specifies several C struct/union type \link{signature}s.}
  \item{envir}{the environment to install S3 type information object(s).} 
  \item{index}{character string specifying the field name.}
  \item{indent}{indentation level for pretty printing structures.}
  \item{value}{value to be converted according to struct/union field type given by field index.}
  \item{...}{additional arguments to be passed to \code{\link[base]{print}} method.}
}
\details{

References to foreign C \code{struct} and \code{union} data types can be 
manipulated symbolically using S3 subsetting method \dQuote{[} overload
for S3 objects tagged with class \code{struct}.
Two different kinds of reference objects are supported: 
\itemize{
  \item \code{external pointer}s returned by \code{\link{.dyncall}} are
of S3 class \code{struct} and point to a type of its signature, if the 
return type signature contains a typed pointer signature (e.g. \code{"*<SomeStruct>"}).
  \item new objects of a foreign C \code{type} can be allocated via \code{new.struct} function:
A atomic \code{raw} object will be returned, initialized with length equal to the size of the
C foreign \code{type}.
}

C data types need to be registered, before allocation or accessing objects
of that type. Registration is done via functions \code{parseStructInfos} and  
\code{parseUnionInfos} ; they parse \link[=Struct Signature]{Structure/Union Type} \code{signature}s
and install \link[=typeinfo]{type information object}s.

\code{as.struct} can be used to \emph{cast} a structure into a different type,
which is not type-safe at all and can lead to a \strong{fatal R process crash}.
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
