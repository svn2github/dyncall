# File: rdyncall/R/dynports.R
# Description: repository for multi-platform bindings to binary components.

require(rjson)

jsonparser <- newJSONParser()

parseJSON <- function(path)
{
  parser <- newJSONParser()
  f <- file(path)
  open(f)
  while(TRUE) 
  {
    aLine <- readLines(f, 1)
    if (length(aLine) == 0) break    
    parser$addData( aLine )
  }
  close(f)
  parser$getObject()
}

from.json <- function(file)
{
  json <- parseJSON(file)
  sysname <- Sys.info()[["sysname"]][[1]]
  paste( "_OS_", toupper(sysname) )   
  libname <- json$libname
  dynbind(libname, libsignature, envir=parent.frame(), callmode="cdecl")
}

from.R <- function(file, envir)
{  
  sys.source(file, envir=envir)  
  # source(url, local=TRUE)
}

dynport.json <- function(portname, envir=NULL, pos = 2, auto.attach=TRUE)
{
  
}

dynport <- function(portname, envir=NULL, pos = 2, auto.attach=TRUE)
{      
  portname <- as.character(substitute(portname))
  envname <- paste("dynport",portname,sep=":")
  
  if ( ! envname %in% search() )
  {
    # load dynport package
  
    if ( missing(envir) )
    {    
      envir <- new.env()
    }
  
    attr(envir, "name") <- envname
    portfile <- file.path( system.file( "dynports", package="rdyncall"), paste(portname,"R",sep=".") )
    
    from.R(portfile,envir)
    # sys.source(portfile, envir=envir)
    
    if (auto.attach)
    {
      attach(envir, pos = pos, name = envname)
    }
  }
  return(invisible(NULL))
}

dynport.unload <- function(portname)
{
  portname <- as.character(substitute(portname))
  envname <- paste("dynport",portname,sep=":")
  detach( name=envname )
}

dynport.require <- function(portname)
{
  
}