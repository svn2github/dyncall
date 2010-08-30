\name{typeinfo}
\alias{TypeInfo}
\alias{getTypeInfo}
\title{Type Information S3 Class}
\description{Type Information}
\usage{
TypeInfo(name, type = c("base","pointer","struct","union"), size = NA, align = NA, basetype = NA, fields = NA, signature = NA)
getTypeInfo(name, envir = parent.frame())
}
\arguments{
  \item{name}{Scalar character string specifying the type name.}
  \item{type}{Scalar character string specifying the type.}
  \item{size}{Size of type in bytes.}
  \item{align}{Alignment of type in bytes.}
  \item{basetype}{Base type of 'pointer' types.}
  \item{signature}{Scalar character string specifying the type signature.}
  \item{envir}{Environment to look for type object.}
  \item{fields}{Dataframe with type and offset information that specifies aggregate struct and union types.}
}
\details{
Type information objects.
}
\value{
List object tagged as S3 class 'TypeInfo' with the following fields
\item{type}{Type name.}
\item{size}{Size in bytes.}
\item{align}{Alignment in bytes.}
\item{fields}{Data frame for field information:
  \itemize{
  \item{type}{Type name}
  \item{offset}{Offset (counted from 0)}
  }
}
}

