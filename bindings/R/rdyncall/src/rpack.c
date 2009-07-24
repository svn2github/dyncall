/** ===========================================================================
 ** R-Package: rdyncall
 ** File: rdyncall/src/rpack
 ** Description: (un-)packing of C structure data
 **
 ** Copyright (C) 2007-2009 Daniel Adler
 **
 ** TODO
 ** - support for bitfields
 **/

// #define USE_RINTERNALS
#include <Rinternals.h>
#include "rdyncall_signature.h"

/** ---------------------------------------------------------------------------
 ** C-Function: r_dataptr
 ** Description: retrieve the 'data' pointer on an R expression.
 ** R-Calling Convention: .Call
 **
 **/

static char* r_dataptr(SEXP data_x)
{
  int type_of = TYPEOF(data_x);
  switch(type_of)
  {
    case CHARSXP:   return (char*) CHAR(data_x);
    case LGLSXP:    return (char*) LOGICAL(data_x);
    case INTSXP:    return (char*) INTEGER(data_x);
    case REALSXP:   return (char*) REAL(data_x);
    case CPLXSXP:   return (char*) COMPLEX(data_x);
    case STRSXP:    return (char*) CHAR( STRING_ELT(data_x,0) );
	case EXTPTRSXP: return (char*) R_ExternalPtrAddr(data_x);
	case RAWSXP:    return (char*) RAW(data_x);
	default: return NULL;
  }
}

/** ---------------------------------------------------------------------------
 ** C-Function: r_pack
 ** Description: pack R data type into a C data type
 ** R-Calling Convention: .Call
 **
 **/
SEXP r_pack(SEXP ptr_x, SEXP offset, SEXP sig_x, SEXP value_x)
{
  char* ptr = r_dataptr(ptr_x);

  if (ptr == NULL) error("invalid address pointer");

  ptr += INTEGER(offset)[0];

  const char* sig = CHAR(STRING_ELT(sig_x,0) );

  int type_of = TYPEOF(value_x);
  switch(sig[0])
  {
	case DC_SIGCHAR_BOOL:
	{
	  int* Bp = (int*) ptr;
	  switch(type_of)
	  {
	  case LGLSXP:  *Bp = (int) LOGICAL(value_x)[0]; break;
	  case INTSXP:  *Bp = (int) ( INTEGER(value_x)[0] == 0) ? 0 : 1; break;
	  case REALSXP: *Bp = (int) ( REAL(value_x)[0] == 0.0) ? 0 : 1; break;
	  case RAWSXP:  *Bp = (int) ( RAW(value_x)[0] == 0) ? 0 : 1; break;
	  default: error("value mismatch with 'B' pack type");
	  }
	}
	break;
	case DC_SIGCHAR_CHAR:
	{
	  char* cp = (char*) ptr;
	  switch(type_of)
	  {
	  case LGLSXP:  *cp = (char) LOGICAL(value_x)[0]; break;
	  case INTSXP:  *cp = (char) INTEGER(value_x)[0]; break;
	  case REALSXP: *cp = (char) REAL(value_x)[0];    break;
	  case RAWSXP:  *cp = (char) RAW(value_x)[0];     break;
	  default: error("value mismatch with 'c' pack type");
	  }
	}
	break;
	case DC_SIGCHAR_UCHAR:
	{
	  unsigned char* cp = (unsigned char*) ptr;
	  switch(type_of)
	  {
	  case LGLSXP:  *cp = (unsigned char) LOGICAL(value_x)[0]; break;
	  case INTSXP:  *cp = (unsigned char) INTEGER(value_x)[0]; break;
	  case REALSXP: *cp = (unsigned char) REAL(value_x)[0];    break;
	  case RAWSXP:  *cp = (unsigned char) RAW(value_x)[0];     break;
	  default: error("value mismatch with 'C' pack type");
	  }
	}
	break;
	case DC_SIGCHAR_SHORT:
	{
	  short* sp = (short*) ptr;
	  switch(type_of)
	  {
	  case LGLSXP:  *sp = (short) LOGICAL(value_x)[0]; break;
	  case INTSXP:  *sp = (short) INTEGER(value_x)[0]; break;
	  case REALSXP: *sp = (short) REAL(value_x)[0];    break;
	  case RAWSXP:  *sp = (short) RAW(value_x)[0];     break;
	  default: error("value mismatch with 's' pack type");
	  }
	}
	break;
	case DC_SIGCHAR_USHORT:
	{
	  unsigned short* sp = (unsigned short*) ptr;
	  switch(type_of)
	  {
	  case LGLSXP:  *sp = (unsigned short) LOGICAL(value_x)[0]; break;
	  case INTSXP:  *sp = (unsigned short) INTEGER(value_x)[0]; break;
	  case REALSXP: *sp = (unsigned short) REAL(value_x)[0];    break;
	  case RAWSXP:  *sp = (unsigned short) RAW(value_x)[0];     break;
	  default: error("value mismatch with 'S' pack type");
	  }
	}
	break;
	case DC_SIGCHAR_INT:
	{
	  int* ip = (int*) ptr;
	  switch(type_of)
	  {
	  case LGLSXP:  *ip = (int) LOGICAL(value_x)[0]; break;
	  case INTSXP:  *ip = (int) INTEGER(value_x)[0]; break;
	  case REALSXP: *ip = (int) REAL(value_x)[0];    break;
	  case RAWSXP:  *ip = (int) RAW(value_x)[0];     break;
	  default: error("value mismatch with 'i' pack type");
	  }
	}
	break;
	case DC_SIGCHAR_UINT:
	{
	  unsigned int* ip = (unsigned int*) ptr;
	  switch(type_of)
	  {
	  case LGLSXP:  *ip = (unsigned int) LOGICAL(value_x)[0]; break;
	  case INTSXP:  *ip = (unsigned int) INTEGER(value_x)[0]; break;
	  case REALSXP: *ip = (unsigned int) REAL(value_x)[0];    break;
	  case RAWSXP:  *ip = (unsigned int) RAW(value_x)[0];     break;
	  default: error("value mismatch with 'I' pack type");
	  }
	}
	break;
	case DC_SIGCHAR_LONG:
	{
	  long* ip = (long*) ptr;
	  switch(type_of)
	  {
	  case LGLSXP:  *ip = (long) LOGICAL(value_x)[0]; break;
	  case INTSXP:  *ip = (long) INTEGER(value_x)[0]; break;
	  case REALSXP: *ip = (long) REAL(value_x)[0];    break;
	  case RAWSXP:  *ip = (long) RAW(value_x)[0];     break;
	  default: error("value mismatch with 'j' pack type");
	  }
	}
	break;
	case DC_SIGCHAR_ULONG:
	{
	  unsigned long* ip = (unsigned long*) ptr;
	  switch(type_of)
	  {
	  case LGLSXP:  *ip = (unsigned long) LOGICAL(value_x)[0]; break;
	  case INTSXP:  *ip = (unsigned long) INTEGER(value_x)[0]; break;
	  case REALSXP: *ip = (unsigned long) REAL(value_x)[0];    break;
	  case RAWSXP:  *ip = (unsigned long) RAW(value_x)[0];     break;
	  default: error("value mismatch with 'J' pack type");
	  }
	}
	break;
	case DC_SIGCHAR_LONGLONG:
	{
	  long long* Lp = (long long*) ptr;
	  switch(type_of)
	  {
	  case LGLSXP:  *Lp = (long long) LOGICAL(value_x)[0]; break;
	  case INTSXP:  *Lp = (long long) INTEGER(value_x)[0]; break;
	  case REALSXP: *Lp = (long long) REAL(value_x)[0];    break;
	  case RAWSXP:  *Lp = (long long) RAW(value_x)[0];     break;
	  default: error("value mismatch with 'l' pack type");
	  }
	}
	break;
	case DC_SIGCHAR_ULONGLONG:
	{
	  unsigned long long* Lp = (unsigned long long*) ptr;
	  switch(type_of)
	  {
	  case LGLSXP:  *Lp = (unsigned long long) LOGICAL(value_x)[0]; break;
	  case INTSXP:  *Lp = (unsigned long long) INTEGER(value_x)[0]; break;
	  case REALSXP: *Lp = (unsigned long long) REAL(value_x)[0];    break;
	  case RAWSXP:  *Lp = (unsigned long long) RAW(value_x)[0];     break;
	  default: error("value mismatch with 'L' pack type");
	  }
	}
	break;
	case DC_SIGCHAR_FLOAT:
	{
	  float* fp = (float*) ptr;
	  switch(type_of)
	  {
	  case LGLSXP:  *fp = (float) LOGICAL(value_x)[0]; break;
	  case INTSXP:  *fp = (float) INTEGER(value_x)[0]; break;
	  case REALSXP: *fp = (float) REAL(value_x)[0];    break;
	  case RAWSXP:  *fp = (float) RAW(value_x)[0];     break;
	  default: error("value mismatch with 'f' pack type");
	  }
	}
	break;
	case DC_SIGCHAR_DOUBLE:
	{
	  double* dp = (double*) ptr;
	  switch(type_of)
	  {
	  case LGLSXP:  *dp = (double) LOGICAL(value_x)[0]; break;
	  case INTSXP:  *dp = (double) INTEGER(value_x)[0]; break;
	  case REALSXP: *dp = (double) REAL(value_x)[0];    break;
	  case RAWSXP:  *dp = (double) RAW(value_x)[0];     break;
	  default: error("value mismatch with 'd' pack type");
	  }
	}
	break;
	case DC_SIGCHAR_POINTER:
	case '*':
	{
	  void** pp = (void**) ptr;
	  switch(type_of)
	  {
	  case NILSXP:   *pp = (void*) 0; break;
	  case CHARSXP:  *pp = (void*) CHAR(value_x); break;
	  case LGLSXP:   *pp = (void*) LOGICAL(value_x); break;
	  case INTSXP:   *pp = (void*) INTEGER(value_x); break;
	  case REALSXP:  *pp = (void*) REAL(value_x); break;
	  case CPLXSXP:  *pp = (void*) COMPLEX(value_x); break;
	  case STRSXP:   *pp = (void*) CHAR( STRING_ELT(value_x,0) ); break;
	  case EXTPTRSXP:*pp = (void*) R_ExternalPtrAddr(value_x); break;
	  case RAWSXP:   *pp = (void*) RAW(value_x); break;
	  default: error("value type mismatch with 'p' pack type");
	  }
	}
	break;
	case DC_SIGCHAR_STRING:
	{
	  char** Sp = (char**) ptr;
	  switch(type_of)
	  {
	  case NILSXP:   *Sp = (char*) NULL; break;
	  case CHARSXP:  *Sp = (char*) CHAR(value_x); break;
	  case STRSXP:   *Sp = (char*) CHAR( STRING_ELT(value_x,0) ); break;
	  case EXTPTRSXP:*Sp = (char*) R_ExternalPtrAddr(value_x); break;
	  default: error("value type mismatch with 'Z' pack type");
	  }
	}
	break;
	case DC_SIGCHAR_SEXP:
	{
	  SEXP* px = (SEXP*) ptr;
	  *px = value_x;
	}
	break;
	default: error("invalid signature");
  }
  return R_NilValue;
}

/** ---------------------------------------------------------------------------
 ** C-Function: r_unpack
 ** Description: unpack elements from C-like structures to R values.
 ** R-Calling Convention: .Call
 **
 **/
SEXP r_unpack(SEXP ptr_x, SEXP offset, SEXP sig_x)
{
  char* ptr = r_dataptr(ptr_x);
  if (ptr == NULL) error("invalid address pointer");
  ptr += INTEGER(offset)[0];
  const char* sig = CHAR(STRING_ELT(sig_x,0) );
  switch(sig[0])
  {
    case DC_SIGCHAR_BOOL:     return ScalarLogical( ((int*)ptr)[0] );
    case DC_SIGCHAR_CHAR:     return ScalarInteger( ( (char*)ptr)[0] );
    case DC_SIGCHAR_UCHAR:     return ScalarInteger( ( (unsigned char*)ptr)[0] );
    case DC_SIGCHAR_SHORT:    return ScalarInteger( ( (short*)ptr)[0] );
    case DC_SIGCHAR_USHORT:    return ScalarInteger( ( (unsigned short*)ptr)[0] );
    case DC_SIGCHAR_INT:      return ScalarInteger( ( (int*)ptr )[0] );
    case DC_SIGCHAR_UINT:      return ScalarReal( (double) ( (unsigned int*)ptr )[0] );
	case DC_SIGCHAR_LONG:     return ScalarReal( (double) ( (long*)ptr )[0] );
	case DC_SIGCHAR_ULONG:    return ScalarReal( (double) ( (unsigned long*) ptr )[0] );
    case DC_SIGCHAR_FLOAT:    return ScalarReal( (double) ( (float*) ptr )[0] );
    case DC_SIGCHAR_DOUBLE:   return ScalarReal( ((double*)ptr)[0] );
    case DC_SIGCHAR_LONGLONG: return ScalarReal( (double) ( ((long long*)ptr)[0] ) );
    case DC_SIGCHAR_ULONGLONG: return ScalarReal( (double) ( ((unsigned long long*)ptr)[0] ) );
    case '*':
    case DC_SIGCHAR_POINTER:  return R_MakeExternalPtr( ((void**)ptr)[0] , R_NilValue, R_NilValue );
    case DC_SIGCHAR_STRING:   {
    	char* s = ( (char**) ptr )[0];
		if (s == NULL) return R_MakeExternalPtr( 0, R_NilValue, R_NilValue );
		return mkString(s);
    }
    case DC_SIGCHAR_SEXP:     return (SEXP) ptr;
    default: error("invalid signature");
  }
  return R_NilValue;
}
