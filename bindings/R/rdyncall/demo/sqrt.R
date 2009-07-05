dynbind( c("msvcrt","libm.so"), "sqrt(d)d;" )
print(sqrt)
sqrt(144)

