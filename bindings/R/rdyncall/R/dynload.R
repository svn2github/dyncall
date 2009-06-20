# File: rdyncall/R/dyncall.R
# Description: R bindings for dynload library
#

.dynload <- function(libpath, auto.unload=TRUE)
{  
  libh <- .Call("dynload", as.character(libpath), PACKAGE="rdyncall")
  if (!is.null(libh)) {
    attr(libh, "path") <- libpath
    attr(libh, "auto.unload") <- auto.unload
    if (auto.unload) reg.finalizer(libh, .dynunload)
  }
  libh
}

.dynunload <- function(libh)
{
  if (!is.externalptr(libh)) stop("libh argument must be of type 'externalptr'")
  .Call("dynunload", libh, PACKAGE="rdyncall")
}

.dynsym <- function(libh, name, protect.lib=TRUE)
{
  if (!is.externalptr(libh)) stop("libh argument must be of type 'externalptr'") 
  .Call("dynsym", libh, as.character(name), as.logical(protect.lib), PACKAGE="rdyncall")
}

