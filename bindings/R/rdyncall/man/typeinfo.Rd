\name{typeinfo}
\alias{TypeInfo}
\title{Type Information S3 Class}
\description{Type Information}
\usage{
TypeInfo()
getTypeInfo()
}
\details{
Type information object.
}
\value{
List object of S3 class 'TypeInfo' with the following fields
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

