# File: rdyncall/R/dynports.R
# Description: repository for multi-platform bindings to binary components.
dynport <- function(portname, envir=NULL, pos = 2, auto.attach=TRUE)
{      
  portname <- as.character(substitute(portname))
  envname <- paste("dynport",portname,sep=":")
  
  if ( envname %in% search() )
  {
    warning("dynport ", portname, " already loaded.")
    return(NULL)
  }
  
  if ( missing(envir) )
  {    
    envir <- new.env()
  }

  attr(envir, "name") <- envname
  portfile <- file.path( system.file( "dynports", package="rdyncall"), paste(portname,"R",sep=".") )
  sys.source(portfile, envir=envir)
  
  if (auto.attach)
  {
    attach(envir, pos = pos, name = envname)
  }
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