# File: rdyncall/R/dyncall.R
# Description: dyncall bindings for R

# ----------------------------------------------------------------------------
# call vm alloc/free (internal)

new.callvm <- function( callmode = c("cdecl","stdcall","thiscall.gcc","thiscall.msvc","fastcall.gcc","fastcall.msvc"), size = 4096L )
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
# CallVM's for calling conventions - will be initialized .onLoad

callvm.cdecl         <- NULL
callvm.stdcall       <- NULL
callvm.thiscall.gcc  <- NULL
callvm.thiscall.msvc <- NULL
callvm.fastcall.gcc  <- NULL
callvm.fastcall.msvc <- NULL

# ----------------------------------------------------------------------------
# public interface

.dyncall <- function( address, signature, ... , callmode = "cdecl" )
{
  callvm <- switch(callmode, 
      default=,cdecl=callvm.cdecl, 
      stdcall=callvm.stdcall, 
      thiscall=,thiscall.gcc=callvm.thiscall.gcc, thiscall.msvc=callvm.thiscall.msvc, 
      fastcall=,fastcall.gcc=callvm.fastcall.gcc, fastcall.msvc=callvm.fastcall.msvc)
  .External("dyncall", callvm, address, signature, ..., PACKAGE="rdyncall")
}

.dyncall.cdecl <- function( address, signature, ... )
  .External("dyncall", callvm.cdecl, address, signature, ..., PACKAGE="rdyncall")
.dyncall.stdcall <- function( address, signature, ... )
  .External("dyncall", callvm.stdcall, address, signature, ..., PACKAGE="rdyncall")
.dyncall.thiscall.gcc <- function( address, signature, ... )
  .External("dyncall", callvm.thiscall.gcc, address, signature, ..., PACKAGE="rdyncall")
.dyncall.thiscall.msvc <- function( address, signature, ... )
  .External("dyncall", callvm.thiscall.msvc, address, signature, ..., PACKAGE="rdyncall")
.dyncall.fastcall.gcc <- function( address, signature, ... )
  .External("dyncall", callvm.fastcall.gcc, address, signature, ..., PACKAGE="rdyncall")
.dyncall.fastcall.msvc <- function( address, signature, ... )
  .External("dyncall", callvm.fastcall.msvc, address, signature, ..., PACKAGE="rdyncall")

# ----------------------------------------------------------------------------
# initialize callvm's on load

.onLoad <- function(libname,pkgname)
{
  callvm.cdecl         <<- new.callvm("cdecl")
  callvm.stdcall       <<- new.callvm("stdcall")
  callvm.thiscall.gcc  <<- new.callvm("thiscall.gcc")
  callvm.thiscall.msvc <<- new.callvm("thiscall.msvc")
  callvm.fastcall.gcc  <<- new.callvm("fastcall.gcc")
  callvm.fastcall.msvc <<- new.callvm("fastcall.msvc")
}
