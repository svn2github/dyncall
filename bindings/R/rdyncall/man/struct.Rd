\name{struct}
\alias{struct}
\alias{new.struct}
\alias{as.struct}
\alias{parseStructInfos}
\alias{parseUnionInfos}
\alias{unpack.struct}
\alias{pack.struct}
\alias{makeStructInfo}
\alias{makeUnionInfo}
\alias{$.struct}
\alias{print.struct}
\alias{$<-.struct}
\title{Handling of C structure and union types.}
\description{Functions for parsing C type information and a struct S3 class to operate on C structure/union types in R.}
\usage{
new.struct(type)
as.struct(x, type)
unpack.struct(x, index)
pack.struct(x, index, value)
\S3method{$}{struct}(x, index)
\S3method{$}{struct}(x, index) <- value
% \S3method{[}{struct}(x, index)
% \S3method{[}{struct}(x, index) <- value
\S3method{print}{struct}(x, indent=0, \ldots)
parseStructInfos(sigs, envir=parent.frame())
parseUnionInfos(sigs, envir=parent.frame())
makeStructInfo(name, signature, fieldNames, envir=parent.frame())
makeUnionInfo(name, signature, fieldNames, envir=parent.frame())
}
\arguments{
  \item{x}{external pointer or atomic raw vector of S3 class 'struct'.}
  \item{type}{S3 TypeInfo Object or character string naming the structure type.}
  \item{sigs}{character string that specifies several C struct/union type \link{signature}s.}
  \item{signature}{character string that specifies a field layout  \link{signature} for struct and union C types.}
  \item{envir}{the environment to install the type information S3 object.} 
  \item{index}{character string specifying the field name.}
  \item{indent}{indentation level for pretty printing structures.}
  \item{value}{value to be converted according to struct/union field type given by field index.}
  \item{fieldNames}{vector of character strings to label fields.}
  \item{name}{character string specifying the struct/union type name.}
  \item{...}{additional arguments to be passed to \code{\link[base]{print}} method.}
}
\details{
This framework handles foreign C data types and provides helper functions for registration, allocation and an S3 class for symbolic access to foreign C data types. 
The framework uses platform-portable struct and union type \link{signature} strings for registration and platform-specific type information objects, derived and
computed for run-time \link{type information} objects.

\code{parseStructInfos} and \code{parseUnionInfos} use \link{signature}s to compute and install concrete Type Information objects that
describe the concrete layout and size (including correct alignments) of the currently running host machine.

The framework supports memory-managed variables and external pointers to foreign C data types. Memory managed variables are supported via the \code{new.struct} function
that returns an atomic \code{\link{raw}} vector tagged as an S3 'struct' object.
External pointers returned by \code{\link{.dyncall}} and specified as \emph{typed} C pointers via return type signature notation \code{*<TypeName>}
are also tagged as S3 'struct' objects.

S3 objects of class 'struct' hold a reference to the type information objects. They support symbolic read/write access via overloaded subsetting operators.

\code{as.struct} can be used to \emph{cast} a structure into a different type.
}
\seealso{
\code{\link{signature}} for signatures and \code{\link{.dyncall}} for foreign function calls and \code{\link{TypeInfo}} for details on type information S3 objects.
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
