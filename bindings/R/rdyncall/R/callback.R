new.callback <- function(signature, fun, envir=new.env(), callmode="cdecl")
{
  stopifnot( is.function(fun) )
  stopifnot( is.character(signature) )
  .Call("new_callback", signature, fun, envir, callmode, PACKAGE="rdyncall")
}
