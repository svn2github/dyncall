.addrval <- function(x)
{
  .Call("addrval", x, PACKAGE="rdyncall")
}

is.externalptr <- function(x)
{
  (typeof(x) == "externalptr")
}

is.nullptr <- function(x)
{
  stopifnot(is.externalptr(x))
  (.addrval(x) == 0)    
}

offsetPtr <- function(x, offset)
{
  .Call("offsetPtr", x, offset, PACKAGE="rdyncall")
}

as.extptr <- function(x)
{
  .Call("asextptr", x, PACKAGE="rdyncall")
}

sexpraddr <- function(x) .Call("sexpraddr", x, PACKAGE="rdyncall")

#.dataptr <- function(x, offset=0L)
#{
#  .Call("dataptr", x, as.integer(offset), PACKAGE="rdyncall" )
#}

#as.externalptr <- function(x)
#{
#  if (is.atomic(x))
#  {
#    value <- as.integer(x)
#    return(.unpack(value, 0, 'p'))
#  }
#  else if (is.function(x))
#  {
#    # extract dynbind function pointers
#    code <- body(x)
#    if ( as.character(code[[1]]) == ".dyncall.cdecl" ) return(code[[2]])    
#    else if ( as.character(code[[1]]) == ".dyncall.stdcall" ) return(code[[2]])    
#  }
#  stop("invalid type")
#}

