# File: rdyncall/R/dyncall.R
# Description: dyncall bindings for R

# ----------------------------------------------------------------------------
# call vm alloc/free

new.callvm <- function(mode = c("cdecl","stdcall"), size = 4096L)
{
  mode <- switch(mode, cdecl=DC_CALL_C_DEFAULT, stdcall=DC_CALL_C_X86_WIN32_STD)
  x <- .External("new_callvm", mode, size)
  reg.finalizer(x, free.callvm)
  return(x)
}

free.callvm <- function(x)
{
  .External("free_callvm", x)
}

# ----------------------------------------------------------------------------
# calling convention: cdecl 

callvm.cdecl   <- new.callvm("cdecl")

.dyncall.cdecl <- function( address, signature, ... )
{
  .External("r_dcCall", callvm.cdecl, address, signature, ..., PACKAGE="rdyncall")
}

# ----------------------------------------------------------------------------
# calling convention: stdcall on win32 / otherwise fallback to cdecl

if (.Platform$OS == "windows") 
{  
  callvm.stdcall <- new.callvm("stdcall")
} else 
{
  callvm.stdcall <- .callvm.cdecl
}

.dyncall.stdcall <- function( address, signature, ... )
{
  .External("r_dcCall", callvm.stdcall, address, signature, ..., PACKAGE="rdyncall")
}  

# ----------------------------------------------------------------------------
# generic call

.dyncall <- function( address, signature, ... , CALLMODE="cdecl" )
{
  callvm <- switch(CALLMODE, cdecl=callvm.cdecl, stdcall=callvm.stdcall)
  .External("r_dcCall", callvm, address, signature, ..., PACKAGE="rdyncall")
}
