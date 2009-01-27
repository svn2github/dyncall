# File: rdyncall/R/dyncall.R
# Description: dyncall bindings for R

# ----------------------------------------------------------------------------
# available call modes

.callmodes <- c("cdecl","stdcall","fastcall.gcc","fastcall.msvc","this.gcc","this.msvc")

# ----------------------------------------------------------------------------
# call vm alloc/free

new.callvm <- function( callmode = c("cdecl","stdcall","fastcall.gcc","fastcall.msvc","this.gcc","this.msvc"), size = 4096L )
{
  callmode <- match.arg(callmode)
  x <- .Call("new_callvm", callmode, size, PACKAGE="rdyncall")
  reg.finalizer(x, free.callvm)
  return(x)
}

free.callvm <- function(x)
{
  .Call("free_callvm", x, PACKAGE="rdyncall")
}

# ----------------------------------------------------------------------------
# calling convention: cdecl 

# callvm.cdecl   <- new.callvm("cdecl")


.dyncall.cdecl <- function( address, signature, ... )
{
  .External("dyncall", callvm.cdecl, address, signature, ..., PACKAGE="rdyncall")
}

# ----------------------------------------------------------------------------
# calling convention: stdcall on win32 / otherwise fallback to cdecl

if (.Platform$OS == "windows") {  
  # callvm.stdcall <- new.callvm("stdcall")
} else {
  # callvm.stdcall <- .callvm.cdecl
}

.dyncall.stdcall <- function( address, signature, ... )
{
  .External("dyncall", callvm.stdcall, address, signature, ..., PACKAGE="rdyncall")
}  

# ----------------------------------------------------------------------------
# generic call

.dyncall <- function( address, signature, ... , callmode = .callmodes )
{
  callvm <- switch(callmode, cdecl=callvm.cdecl, stdcall=callvm.stdcall)
  .External("dyncall", callvm, address, signature, ..., PACKAGE="rdyncall")
}

callvm.cdecl <- NULL
callvm.stdcall <- NULL

.onLoad <- function(libname,pkgname)
{
  callvm.cdecl <<- new.callvm("cdecl")
  callvm.stdcall <<- new.callvm("stdcall")
}
