ref <- rnorm(10000)

floats <- as.floatraw(ref)
conv <- floatraw2numeric(floats)
error  <- sum(conv - ref)

