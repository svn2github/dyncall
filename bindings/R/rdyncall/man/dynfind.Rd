\name{dynfind}
\alias{dynfind}
\alias{pathsFromEnv}
\title{Find system libraries in common places.}
\description{Searches in common places in the file-system to locate a library by a common name.}
\usage{
dynfind(name)
pathsFromEnv(envname)
}
\arguments{
  \item{name}{A character string specifying a fragment of the library name such as 'c', 'GL' or 'zlib'.}
  \item{envname}{A character string specifying the name of a system environment variable such as 'LD_LIBRARY_PATH' or 'PATH'.} 
}
\keyword{interface}
\keyword{programming::interface}
