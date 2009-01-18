# R/DynCall 
# (C) 2007 Daniel Adler

rdcLoad    <- function (libpath) 
  
  .Call("rdcLoad", as.character(libpath) , PACKAGE="rdc") 


rdcFree <- function (libhandle) 

  .Call("rdcFree", libhandle, PACKAGE="rdc") 


rdcFind    <- function (libhandle, symbol) 

  .Call("rdcFind", libhandle, as.character(symbol) )


rdcCall    <- function (funcptr, signature, ...) 

  .Call("rdcCall", funcptr, signature, list(...) ) 

rdcPath    <- function (addpath)
{
  path <- Sys.getenv("PATH")
  path <- paste(addpath,path,sep=.Platform$path.sep)
  Sys.setenv(PATH=path)
}

rdcUnpath <- function(delpath)
{
  path <- Sys.getenv("PATH")
  path <- sub( paste(delpath,.Platform$path.sep,sep=""), "", path )  
  Sys.setenv(PATH=path)  
}


rdcShowPath <- function()

  Sys.getenv("PATH")

  
rdcUnpack1 <- function(ptr, offset, sigchar)
  .Call("rdcUnpack1", ptr, as.integer(offset), as.character(sigchar) )
  