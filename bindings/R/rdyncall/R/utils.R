.dataptr <- function(x, offset=0L)
{
  .Call("dataptr", x, as.integer(offset), PACKAGE="rdyncall" )
}

.addrval <- function(x)
{
  .Call("addrval", x, PACKAGE="rdyncall")
}

is.externalptr <- function(x)
{
  (typeof(x) == "externalptr")
}

as.externalptr <- function(x)
{
  if (is.atomic(x))
  {
    value <- as.integer(x)
    return(.unpack1(value, 0, 'p'))
  }
  else if (is.function(x))
  {
    # extract dynbind function pointers
    code <- body(x)
    if ( as.character(code[[1]]) == ".dyncall.cdecl" ) return(code[[2]])    
    else if ( as.character(code[[1]]) == ".dyncall.stdcall" ) return(code[[2]])    
  }
  stop("invalid type")
}

is.nullptr <- function(x)
{
  stopifnot(is.externalptr(x))
  (.addrval(x) == 0)    
}

test_c <- function(...)
{
  .External("test_c", ..., PACKAGE="rdyncall")
}
