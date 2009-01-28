# File: rdyncall/R/dyncall.R
# Description: R bindings for dynload library
#

.dynload <- function(libname)
{
  try.prefixes <- c("","lib")
  try.suffixes <- c("",.Platform$dynlib.ext)  
  
  for (prefix in try.prefixes)
  {
    for(suffix in try.suffixes)
    {
      path <- paste( prefix, libname, suffix, sep="" )
      x <- .Call("dynload", path, PACKAGE="rdyncall")
      if (!is.null(x))
      	return(x)
    }
  }

}

.dynunload <- function(libh)
{
  .Call("dynunload", libh, PACKAGE="rdyncall")
}

.dynfind <- function(lib, name)
{
  .Call("dynfind", lib, name, PACKAGE="rdyncall")
}

.dynpath <- function(add = NULL, remove = NULL)
{
  if (nargs() == 0)
  {
    strsplit( Sys.getenv("path"), .Platform$path.sep)[[1]]
  }
  else
  {
    if (! missing(add))
    {
      paste(Sys.getenv("path"), paste(add,collapse=.Platform$path.sep), sep=.Platform$path.sep)
    }
    if (! missing(remove))
    {
      .NotYetImplemented()
    }
  }
}
