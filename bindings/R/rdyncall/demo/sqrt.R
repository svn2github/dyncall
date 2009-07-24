# Package: rdyncall 
# File: demo/sqrt.R
# Description: C math library demo (dynbind demo) 
# Author: Daniel Adler

dynbind( c("msvcrt","m"), "sqrt(d)d;" )
print(sqrt)
sqrt(144)

