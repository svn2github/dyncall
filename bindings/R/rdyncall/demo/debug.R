# TODO: Add comment
# 
# Author: dadler
###############################################################################

dynport(win32)
x <- new.struct(WNDCLASSEXA)
r <- RegisterClassExA(x)
print(r)
is.nullptr(r)
