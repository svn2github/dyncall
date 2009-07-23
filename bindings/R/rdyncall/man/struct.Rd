\name{cstructs}
\alias{cstructs}
\alias{.pack1}
\alias{.unpack1}
\alias{new.struct}
\alias{as.struct}
\alias{parseStructInfos}
\alias{parseUnionInfos}
\title{Low-level access to C data structures.}
\description{Functions for parsing C structure/union type information and a structure class to operate on C structure/union types in R.}
\usage{
.pack1(x, offset, sigchar, value)
.unpack1(x, offset, sigchar)
new.struct(structName)
as.struct(x, structName)
parseStructInfos(sigs, envir=parent.frame())
parseUnionInfos(sigs, envir=parent.frame())
}
\arguments{
  \item{x}{An atomic vector or an external pointer.}
  \item{offset}{Positive integer specifying the offset from within the beginning (item 0) given in bytes.}
  \item{sigchar}{Data type specifying the low-level representation of \code{value}}
  \item{value}{Value} 
  \item{structName}{A character string that specifies a symbolic name of type 'TypeInfo'.}
  \item{sigs}{A character string that specifies structure or union signatures. See details below.}
  \item{envir}{Specifies an environment to install the type information into.} 

}
\details{

With the functions \code{.pack1} and \code{.unpack1} one can make low-level manipulations 
of C-level structure data.
Atomic vectors are first adjusted to start at the first element (offset 0). 

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
\author{
  Daniel Adler \email{dadler@uni-goettingen.de}
}
\keyword{programming}
\keyword{interface}
