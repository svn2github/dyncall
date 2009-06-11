# File: rdyncall/R/dyncall.R
# Description: R bindings for dynload library
#
  
.sysname <- Sys.info()[["sysname"]]

.dynload.darwin.framework <- function(framework)
{
  try.framework.locations <- c("/Library/Frameworks","/System/Library/Frameworks")
  for (location in try.framework.locations) {
    path <- paste( location, "/", framework, ".framework/", framework, sep="")
    x <- .Call("dynload", path, PACKAGE="rdyncall")
    if (!is.null(x))
      return(x)
  }
  return(NULL)
}

.dynload <- function(libname)
{
  try.locations <- c("","/opt/local/lib/","/Library/Frameworks/R.framework/Resources/lib/")
  try.prefixes <- c("","lib")
  try.suffixes <- c("",.Platform$dynlib.ext)  
  if ( .sysname == "Darwin" ) {
    handle <- .dynload.darwin.framework(libname)
    if( !is.null(handle) ) return(handle)
    try.suffixes <- c(try.suffixes,".dylib")
  }
  
  for (location in try.locations)
  {
    for (prefix in try.prefixes)
    {
      for(suffix in try.suffixes)
      {
        path <- paste( location, prefix, libname, suffix, sep="" )
        x <- .Call("dynload", path, PACKAGE="rdyncall")
        if (!is.null(x))
          return(x)
      }
    }
  }
  warning("failed to load library ",libname)
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
