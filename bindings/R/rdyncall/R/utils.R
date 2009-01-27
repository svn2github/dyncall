.unpack1 <- function(ptr, offset, sigchar)
{
  .Call("unpack1", ptr, as.integer(offset), as.character(sigchar) )
}

.dataptr <- function(x, offset=0L)
{
  .Call("dataptr", x, as.integer(offset) )
}
