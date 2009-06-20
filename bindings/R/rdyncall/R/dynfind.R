# R-Package: rdyncall
# File: rdyncall/R/dynfind.R
# Description: locating system libraries in common places  

# ----------------------------------------------------------------------------
# function: pathsFromEnv
# description: get paths character vector from environment variable such as LD_LIBRARY_PATH.
pathsFromEnv <- function(name)
  unlist( strsplit( unname( Sys.getenv(name) ), .Platform$path.sep ) )


.libLocations <- c("/lib","/usr/lib", "/usr/local/lib", "/opt/local/lib")

if (Sys.info()[["sysname"]] == "Darwin")
{
  .libLocations <- c(.libLocations, "/Library/Frameworks/R.framework/Resources/lib/" )
}

.sysname <- Sys.info()[["sysname"]]

dynfind.darwin.framework <- function(framework, auto.unload=TRUE)
{
  try.framework.locations <- c("/Library/Frameworks","/System/Library/Frameworks")
  for (location in try.framework.locations) {
    path <- paste( location, "/", framework, ".framework/", framework, sep="")    
    x <- dynload(path, auto.unload)
    if (!is.null(x)) return(x)
  }
  return(NULL)
}

dynfind <- function(libname, auto.unload=TRUE)
{
  try.locations <- c("/lib","/usr/lib","/usr/local/lib","/opt/local/lib/", pathsFromEnv("LD_LIBRARY_PATH") )
  try.prefixes <- c("","lib")
  try.suffixes <- c("",.Platform$dynlib.ext)  
  if ( .sysname == "Darwin" ) {
    try.locations <- c(try.locations, "/Library/Frameworks/R.framework/Resources/lib/")
    handle <-dynfind.darwin.framework(libname, auto.unload)
    if( !is.null(handle) ) return(handle)
    try.suffixes <- c(try.suffixes,".dylib")
  }

  # remove "" entries and duplicates
  try.locations <- unique( try.locations[try.locations != ""] )
  
  # put '""' at the very end
  # try.locations <- c(try.locations,"")
  
  for (location in try.locations)
  {
    for (prefix in try.prefixes)
    {
      for(suffix in try.suffixes)
      {
        path <- file.path( location, paste(prefix, libname, suffix, sep="") )
        x <- .dynload(path, auto.unload)
        if (!is.null(x)) return(x)
      }
    }
  }
}

#.dynpath <- function(add = NULL, remove = NULL)
#{
#  if (nargs() == 0)
#  {
#    strsplit( Sys.getenv("path"), .Platform$path.sep)[[1]]
#  }
#  else
#  {
#    if (! missing(add))
#    {
#      paste(Sys.getenv("path"), paste(add,collapse=.Platform$path.sep), sep=.Platform$path.sep)
#    }
#    if (! missing(remove))
#    {
#      .NotYetImplemented()
#    }
#  }
#}
