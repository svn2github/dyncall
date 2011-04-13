\name{typeinfo}
\alias{TypeInfo}
\alias{getTypeInfo}
\alias{type information}
\title{Type Information S3 Class}
\description{Type Information object to describe run-time properties of foreign data types such as field layout including alignment considerations.}
\usage{
TypeInfo(name, type = c("base","pointer","struct","union"), size = NA, align = NA, basetype = NA, fields = NA, signature = NA)
getTypeInfo(name, envir = parent.frame())
}
\arguments{
  \item{name}{character string specifying the type name.}
  \item{type}{character string specifying the type.}
  \item{size}{integer, size of type in bytes.}
  \item{align}{integer, alignment of type in bytes.}
  \item{basetype}{character string, base type of 'pointer' types.}
  \item{signature}{character string specifying the struct/union type \link{signature}.}
  \item{envir}{the environment to look for type object.}
  \item{fields}{data frame with type and offset information that specifies aggregate struct and union types.}
}
\details{
Internal S3 object class to store run-time type information for foreign C struct and union data types.
}
\value{
List object tagged as S3 class 'TypeInfo' with the following named entries
\item{type}{Type name.}
\item{size}{Size in bytes.}
\item{align}{Alignment in bytes.}
\item{fields}{Data frame for field information with the following columns:
  \tabular{ll}{
    \code{type} \tab type name\cr
    \code{offset} \tab byte offset (starts counted from 0)\cr
  }
}
}
\seealso{
\code{\link{parseStructInfos}} for details on the framework for handling foreign C data types.
}

