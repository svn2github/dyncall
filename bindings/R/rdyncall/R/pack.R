# File: rdyncall/R/pack.R
# Description: (un-)packing functions for raw C struct data. 

.pack1   <- function(ptr, offset, sigchar, value)
{
  .Call("pack1", ptr, as.integer(offset), as.character(sigchar), value, PACKAGE="rdyncall" )
}

.unpack1 <- function(ptr, offset, sigchar)
{
  .Call("unpack1", ptr, as.integer(offset), as.character(sigchar), PACKAGE="rdyncall" )
}
