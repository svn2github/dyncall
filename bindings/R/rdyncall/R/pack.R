# File: rdyncall/R/pack.R
# Description: (un-)packing functions for raw C struct data. 

.pack1   <- function(x, offset, signature, value)
{
  char1 <- substr(signature,1,1)
  if (char1 == "*") char1 <- "p"
  .Call("pack1", x, as.integer(offset), char1, value, PACKAGE="rdyncall" )
}

.unpack1 <- function(x, offset, signature)
{
  sigchar <- char1 <- substr(signature,1,1)
  if (char1 == "*") sigchar <- "p"
  x <- .Call("unpack1", x, as.integer(offset), sigchar, PACKAGE="rdyncall" )
  if (char1 == "*")
  {
    attr(x,"basetype") <- substr(signature,2,nchar(signature))
  }
  return(x)
}

