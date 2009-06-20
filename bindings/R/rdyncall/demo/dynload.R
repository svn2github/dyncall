# test for automatic unloading when the last user of a libhandle is removed

x <- .dynload("/lib/libc.so.6")
x <- NULL
gc()



x <- .dynload("/lib/libc.so.6")
y <- .dynsym(x, "sqrt")
x <- NULL
y <- NULL
gc()
