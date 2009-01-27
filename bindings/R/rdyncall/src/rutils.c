/** ===========================================================================
 ** R-Package: rdyncall
 ** File: rdyncall/src/rutils.c
 ** Description: utility functions to work with low-level data structures in R
 **
 ** Copyright (C) 2007-2009 Daniel Adler
 **/

// uses: DATAPTR macro
#define USE_RINTERNALS 
#include <Rinternals.h>
#include "dyncall_signature.h"

SEXP r_unpack1(SEXP ptr_x, SEXP offset, SEXP sig_x)
{
  char* ptr = ( (char*) R_ExternalPtrAddr(ptr_x) ) + INTEGER(offset)[0];
  const char* sig = CHAR(STRING_ELT(sig_x,0) );
  switch(sig[0])
  {
    case DC_SIGCHAR_CHAR:     return ScalarInteger( ( (unsigned char*)ptr)[0] );
    case DC_SIGCHAR_SHORT:    return ScalarInteger( ( (short*)ptr)[0] );
    case DC_SIGCHAR_INT:      return ScalarInteger( ( (int*)ptr )[0] );
    case DC_SIGCHAR_FLOAT:    return ScalarReal( (double) ( (float*) ptr )[0] );
    case DC_SIGCHAR_DOUBLE:   return ScalarReal( ((double*)ptr)[0] );
    case DC_SIGCHAR_LONGLONG: return ScalarReal( (double) ( ((long long*)ptr)[0] ) );
    default: error("invalid signature");
  }
  return R_NilValue;
}

SEXP r_dataptr(SEXP x, SEXP offset)
{
	void* ptr = ( ( (unsigned char*) DATAPTR(x) ) + INTEGER(offset)[0] );
	return R_MakeExternalPtr( ptr, R_NilValue, R_NilValue );
}
