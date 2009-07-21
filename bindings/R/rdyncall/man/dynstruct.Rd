\name{dynstruct}
\alias{dynstruct}
\alias{new.struct}
\alias{as.struct}
\alias{parseStructInfos}
\alias{parseUnionInfos}
\title{Handling of C structure and union types.}
\description{Functions for parsing C structure/union type information and a structure class to operate on C structure/union types in R.}
\usage{
new.struct(structName)
as.struct(x, structName)
parseStructInfos(sigs, envir=parent.frame())
parseUnionInfos(sigs, envir=parent.frame())
}
\arguments{
  \item{structName}{A character string that specifies a symbolic name of type 'TypeInfo'.}
  \item{x}{An atomic vector or an external pointer.}
  \item{sigs}{A character string that specifies structure or union signatures. See details below.}
}
\details{

The new.struct function allocates a raw atomic vector and marks it with a new class attribute
of type 'struct'. In addition, the attribute 'struct' will be set to the 'structName'.

Working with C structures and unions in R requires type-information.
Therefore type information will be registered with the two front-end parser functions
parseStructInfo and parseUnionInfos.
It will install type information objects. 
  
Structure and Union signatures are collections of single type information signatures.
They are separated by a ';' (semikolon) character.

A structure signature format is as following:

structure-typename '\{' field-types '\}' field-names (white space separated) ';' 

A union signature format is as following:

union-typename '\|' field-types '\}' field-names (white space separated) ';' 

}
\seealso{
\code{\link{.unpack1}} and \code{\link{.pack1}}.
}
\keyword{interface}
\keyword{programming::interface}
