double2floatraw <- function(x) .Call("r_double2floatraw", as.numeric(x), PACKAGE="rdyncall")
floatraw2double <- function(x) .Call("r_floatraw2double", x, PACKAGE="rdyncall")
