# Package: rdyncall 
# File: demo/sqrt.R
# Description: C math library demo (dynbind demo) 

dynbind( c("msvcrt","m"), "sqrt(d)d;" )
print(sqrt)
sqrt(144)

