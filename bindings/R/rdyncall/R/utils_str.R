ptr2str <- function(x) .Call("r_ptr2str", x, PACKAGE="rdyncall")
strarrayptr <- function(x) .Call("r_strarrayptr", x, PACKAGE="rdyncall")
strptr <- function(x) .Call("r_strptr", x, PACKAGE="rdyncall")

