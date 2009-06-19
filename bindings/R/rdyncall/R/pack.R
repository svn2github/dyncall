# File: rdyncall/R/pack.R
# Description: (un-)packing functions for raw C struct data. 

.pack1   <- function(x, offset, sigchar, value)
{
  .Call("pack1", x, as.integer(offset), as.character(sigchar), value, PACKAGE="rdyncall" )
}

.unpack1 <- function(x, offset, sigchar)
{
  .Call("unpack1", x, as.integer(offset), as.character(sigchar), PACKAGE="rdyncall" )
}
