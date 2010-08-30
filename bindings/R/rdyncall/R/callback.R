# Package: rdyncall
# File: R/callback.R
# Description: R Callbacks
# Author: Daniel Adler <dadler@uni-goettingen.de>

new.callback <- function(signature, fun, envir=new.env())
{
  stopifnot( is.function(fun) )
  stopifnot( is.character(signature) )
  cb <- .Call("new_callback", signature, fun, envir, PACKAGE="rdyncall")
  
  attr(cb,"signature") <- signature
  attr(cb,"envir") <- envir
  attr(cb,"fun") <- fun
  reg.finalizer(cb, function(x) { .Call("free_callback", x, PACKAGE="rdyncall") } )
  return(cb)
}
