\name{cstructs}
\alias{struct}
\alias{structs}
\alias{cstructs}
\alias{new.struct}
\alias{as.struct}
\alias{parseStructInfos}
\alias{parseUnionInfos}
\title{Handling of C structure and union types.}
\description{Functions for parsing C type information and a struct S3 class to operate on C structure/union types in R.}
\usage{
new.struct(type)
as.struct(x, type)
\S3method{$}{struct}(x, index)
\S3method{$}{struct}(x, index) <- value
\S3method{[}{struct}(x, index)
\S3method{[}{struct}(x, index) <- value
\S3method{print}{struct}(x, indent=0, \ldots)
parseStructInfos(structsSignature, envir=parent.frame())
parseUnionInfos(unionsSignature, envir=parent.frame())
makeStructInfo(structSignature, fieldNames, envir=parent.frame())
makeUnionInfo(unionSignature, fieldNames, envir=parent.frame())
}
\arguments{
  \item{x}{External pointer or atomic raw vector of S3 class 'struct'.}
  \item{type}{S3 TypeInfo Object or character string naming the structure type.}
  \item{signatures}{Scalar character string that specifies multiple structure or union signatures. See details below.}
  \item{envir}{Environment to install type information.} 
  \item{index}{Scalar character string specifying the field name.}
  \item{indent}{Indentation level for pretty printing structures.}
}
\details{
Many C library interfaces require the correct handling of C structure types.
A framework for R to work with such structures is provided by these functions.

The new.struct function allocates an atomic raw vector S3 Object of class 'struct' with a length 
to hold the C data structure.
Objects of S3 class struct are either R raw vector (allocated in R context) or 
external pointer retrieved by some C interface.
On can easily manipulate external pointers and raw vectors using the as.struct. 
Objects of class struct hold an attribute struct which contains the name of a registered type.

raw atomic vector and marks it with a new class attribute
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
