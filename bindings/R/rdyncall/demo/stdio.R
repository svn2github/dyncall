# Example: read/write to R directly using C stdio

dynport(stdio)

# test: fopen returns NULL pointer on error

nonexisting <- "dummyname"
f <- fopen(nonexisting, "r")
is.nullptr(f)

# test: R raw object read/write

tempfile <- "bla"
f <- fopen(tempfile, "wb")
writebuf <- as.raw(0:255)
copy <- writebuf
copy[[1]] <- as.raw(0xFF)
fwrite(writebuf, 1, length(writebuf), f)
fclose(f)

f <- fopen(tempfile, "rb")
readbuf <- raw(256)
copybuf <- readbuf
fread(readbuf, 1, length(readbuf), f)
copybuf[[1]] <- as.raw(0xFF)
fclose(f)

identical(readbuf,writebuf)

