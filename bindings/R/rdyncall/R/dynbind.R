# R-Package: rdyncall
# File: rdyncall/R/dynbind.R
# Description: single-entry front-end to dynamic binding of library functions 

dynbind <- function(libname, libsignature, envir=parent.frame(), callmode="cdecl")
{
  # load library
  libh <- .dynload(libname)
  
  envir$.libs <- c(envir$.libs,libh)
    
  # convert library signature to signature table
  
  # eat white spaces
  sigtab <- gsub("[ \n\t]*","",libsignature)
  
  # split functions at ';'
  sigtab <- strsplit(sigtab, ";")[[1]]
  
  # split name/call signature at '('
  sigtab <- strsplit(sigtab, "\\(")
  
  
  dyncallfunc <- as.symbol( paste(".dyncall.",callmode, sep="") )
  
  # install functions
  for (i in seq(along=sigtab)) 
  {
    symname   <- sigtab[[i]][[1]]
    signature <- sigtab[[i]][[2]]
    address  <- .dynfind( libh, symname )
    if (!is.null(address))
    {
      f <- function(...) NULL
      body(f) <- substitute( dyncallfunc(address, signature,...), list(dyncallfunc=dyncallfunc,address=address,signature=signature) )
      environment(f) <- envir # NEW
      assign( symname, f, envir=envir)  
    }
    else
    {
      warning("unable to find symbol ", symname, " in shared library ", libname)
    }
  }
  
  reg.finalizer(envir, function(x) { sapply( x$.libs, .dynunload ) } )
  return(libh)
}
