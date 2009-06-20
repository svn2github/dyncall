/** ===========================================================================
 ** R-Package: rdyncall
 ** File: rdyncall/src/rutils.c
 ** Description: misc utility functions to work with low-level data structures in R
 **
 ** Copyright (C) 2007-2009 Daniel Adler
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
