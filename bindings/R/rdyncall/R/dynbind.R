# R-Package: rdyncall
# File: rdyncall/R/dynbind.R
# Description: single-entry front-end to dynamic binding of library functions 

dynbind <- function(libname, lib.signature, envir=parent.frame(), callmode="cdecl", pat=NULL, replace=NULL, funcptr=FALSE)
{
  # load shared library
  libh <- dynfind(libname)
  if ( is.null(libh) )
  {
    cat("dynbind error: Unable to find shared library '", libname[[1]], "'.\n",sep="")
    cat("Consult the projects page how to build and install the shared library for your operating-system.\n")
    cat("Make sure the shared library can be found at the default system places or adjust environment variables (e.g. %PATH% or $LD_LIBRARY_PATH).\n")
    stop("unable to find shared library '", libname[[1]], "'.\n", call.=FALSE)
  }
  
  # -- convert library signature to signature table
  
  # eat white spaces
  sigtab <- gsub("[ \n\t]*","",lib.signature)  
  # split functions at ';'
  sigtab <- strsplit(sigtab, ";")[[1]]  
  # split name/call signature at '('
  sigtab <- strsplit(sigtab, "\\(")
  
  # -- install functions
 
  # make function call symbol
  dyncallfunc <- as.symbol( paste(".dyncall.",callmode, sep="") )  
  # report info
  syms.failed <- character(0)

  for (i in seq(along=sigtab)) 
  {
    symname   <- sigtab[[i]][[1]]    
    rname  <- if (!is.null(pat)) sub(pat, replace, symname) else symname
    signature <- sigtab[[i]][[2]]
    # lookup symbol
    address  <- .dynsym( libh, symname )
    
    if (!is.null(address))
    {
      # make call function f
      f <- function(...) NULL
      if (funcptr)
      {
        body(f) <- substitute( dyncallfunc( .unpack(address,0,"p"), signature,...), list(dyncallfunc=dyncallfunc,address=address,signature=signature) )
      }
      else
      {
        body(f) <- substitute( dyncallfunc(address, signature,...), list(dyncallfunc=dyncallfunc,address=address,signature=signature) )
      }
      environment(f) <- envir # NEW
      # install symbol
      assign( rname, f, envir=envir)  
    }
    else
    {
      syms.failed <- c(syms.failed,symname)
    }
  }
  # return dynbind.report
  x <- list(libhandle=libh, unresolved.symbols=syms.failed)
  class(x) <- "dynbind.report"
  return(x)
}
