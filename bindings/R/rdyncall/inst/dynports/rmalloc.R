# Dynport: Rmalloc
# Description: R low-level memory management
# Maintainer: dadler@uni-goettingen.de

# -----------------------------------------------------------------------------
# dynbind "R" calloc/free

dynbind("R","
R_chk_calloc(ii)p;
R_chk_free(p)v;
")

malloc <- function(size) 
{
  x <- R_chk_calloc(as.integer(size),1L)
  reg.finalizer(x, R_chk_free)
  return(x)
}

