/** ===========================================================================
 ** R-Package: rdyncall
 ** File: src/rutils.c
 ** Description: misc utility functions to work with low-level data structures in R
 **
 ** Copyright (C) 2009-2010 Daniel Adler
 **/

// uses: DATAPTR macro
#define USE_RINTERNALS
#include <Rinternals.h>

SEXP r_dataptr(SEXP x, SEXP offset)
{
  void* ptr = ( ( (unsigned char*) DATAPTR(x) ) + INTEGER(offset)[0] );
  return R_MakeExternalPtr( ptr, R_NilValue, R_NilValue );
}

SEXP r_addrval(SEXP x)
{
  switch(TYPEOF(x)) 
  {
    case NILSXP: return ScalarInteger(0);
    case EXTPTRSXP: return ScalarInteger( (int) (unsigned long long) (ptrdiff_t) R_ExternalPtrAddr( x ) );
    default: error("invalid type");
  }
  return R_NilValue;
}

SEXP r_offsetPtr(SEXP x, SEXP offset)
{
  switch(TYPEOF(x)) 
  {
    case EXTPTRSXP:
      return R_MakeExternalPtr( R_ExternalPtrAddr(x) + (ptrdiff_t) INTEGER(offset)[0], R_NilValue, R_NilValue );
    case RAWSXP:
      return R_MakeExternalPtr( ( (unsigned char*) RAW(x) ) + (ptrdiff_t) INTEGER(offset)[0], R_NilValue, R_NilValue );
    default:
      error("expected an external ptr or raw");
  }
}

SEXP r_asextptr(SEXP x)
{
  void* addr = NULL;
  switch(TYPEOF(x))
  {
    case NILSXP: addr = NULL; break;
    case INTSXP: addr = (void*) (unsigned long) INTEGER(x)[0]; break;
    case REALSXP: addr = (void*) (unsigned long) REAL(x)[0]; break;
    default: error("invalid type");
  }
  return R_MakeExternalPtr( addr, R_NilValue, R_NilValue );
}

SEXP r_sexpraddr(SEXP x)
{
  return R_MakeExternalPtr( x, R_NilValue, R_NilValue );
}

