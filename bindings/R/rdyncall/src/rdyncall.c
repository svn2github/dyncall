/** ===========================================================================
 ** R-Package: rdyncall
 ** File: rdyncall/src/rdyncall.c
 ** Description: R bindings to dyncall
 **
 ** Copyright (C) 2007-2009 Daniel Adler
 **/

#include <Rinternals.h>
#include "dyncall.h"
#include "dyncall_signature.h"
#include <string.h>

/** ---------------------------------------------------------------------------
 ** C-Function: new_callvm
 ** R-Interface: .Call
 **/

SEXP r_new_callvm(SEXP mode_x, SEXP size_x)
{
  int mode_i;
  int size_i = INTEGER(size_x)[0];

  const char* mode_S = CHAR( STRING_ELT( mode_x, 0 ) );

  if (strcmp(mode_S,"cdecl") == 0)
    mode_i = DC_CALL_C_DEFAULT;
  else if (strcmp(mode_S,"stdcall") == 0)
    mode_i = DC_CALL_C_X86_WIN32_STD;
  else if (strcmp(mode_S,"fastcall.gcc") == 0)
    mode_i = DC_CALL_C_X86_WIN32_FAST_GNU;
  else if (strcmp(mode_S,"fastcall.msvc") == 0)
    mode_i = DC_CALL_C_X86_WIN32_FAST_MS;
  else if (strcmp(mode_S,"thiscall.gcc") == 0)
    mode_i = DC_CALL_C_X86_WIN32_THIS_GNU;
  else if (strcmp(mode_S,"thiscall.msvc") == 0)
    mode_i = DC_CALL_C_X86_WIN32_THIS_MS;
  else
  {
    error("invalid callmode");
    return R_NilValue;
  }

  DCCallVM* pvm = dcNewCallVM(size_i);
  dcMode( pvm, mode_i);
  return R_MakeExternalPtr( pvm, R_NilValue, R_NilValue );
}

/** ---------------------------------------------------------------------------
 ** C-Function: free_callvm
 ** R-Interface: .Call
 **/

SEXP r_free_callvm(SEXP callvm_x)
{
  DCCallVM* callvm_p = (DCCallVM*) R_ExternalPtrAddr( callvm_x );
  dcFree( callvm_p );
  return R_NilValue;
}

/** ---------------------------------------------------------------------------
 ** C-Function: r_dyncall
 ** R-Interface: .External
 **/

SEXP r_dyncall(SEXP args)
{
  DCCallVM*   pvm;
  void*       addr;
  const char* sig;
  SEXP        arg;

  args = CDR(args);

  pvm  = (DCCallVM*) R_ExternalPtrAddr( CAR(args) ); args = CDR(args);
  addr = R_ExternalPtrAddr( CAR(args) ); args = CDR(args);
  sig  = CHAR( STRING_ELT( CAR(args), 0 ) ); args = CDR(args);

  if (!pvm) error("callvm is null");
  if (!addr) error("addr is null");

  dcReset(pvm);

  /* process arguments */
#define DC_SIGCHAR_SEXP	'x'
  for(;;) {

    char ch = *sig++;

    if (ch == '\0') error("invalid signature - no return type specified");

    if (ch == ')') break;

    if (args == R_NilValue)
      error("expect more arguments");

    arg = CAR(args); args = CDR(args);

    if (ch == DC_SIGCHAR_SEXP) {
      dcArgPointer(pvm, (void*)arg);
      continue;
    }

    int type_id = TYPEOF(arg);

    if ( type_id != NILSXP && LENGTH(arg) == 0 ) error("invalid argument with zero length");

    switch(ch) {
      case DC_SIGCHAR_BOOL:
      {
        DCbool boolValue;
        switch(type_id)
        {
          case LGLSXP:  boolValue = ( LOGICAL(arg)[0] == 0 ) ? DC_FALSE : DC_TRUE; break;
          case INTSXP:  boolValue = ( INTEGER(arg)[0] == 0 ) ? DC_FALSE : DC_TRUE; break;
          case REALSXP: boolValue = ( REAL(arg)[0]    == 0.0 ) ? DC_FALSE : DC_TRUE; break;
          case RAWSXP:  boolValue = ( RAW(arg)[0]     == 0 ) ? DC_FALSE : DC_TRUE; break;
          default:      error("expected bool castable argument value"); return NULL;
        }
        dcArgBool(pvm, boolValue );
      }
      break;
      case DC_SIGCHAR_CHAR:
      {
      	char charValue;
        switch(type_id)
        {
          case LGLSXP:  charValue = (char) LOGICAL(arg)[0]; break;
          case INTSXP:  charValue = (char) INTEGER(arg)[0];        break;
          case REALSXP: charValue = (char) REAL(arg)[0];    break;
          case RAWSXP:  charValue = (char) RAW(arg)[0];     break;
          default:      error("expected int castable argument value"); return NULL;
        }
      	dcArgChar(pvm, charValue);
      }
      break;
      case DC_SIGCHAR_SHORT:
      {
      	short shortValue;
        switch(type_id)
        {
          case LGLSXP:  shortValue = (short) LOGICAL(arg)[0]; break;
          case INTSXP:  shortValue = (short) INTEGER(arg)[0];        break;
          case REALSXP: shortValue = (short) REAL(arg)[0];    break;
          case RAWSXP:  shortValue = (short) RAW(arg)[0];     break;
          default:      error("expected int castable argument type"); return NULL;
        }
      	dcArgShort(pvm, shortValue);
      }
      break;
      case DC_SIGCHAR_LONG:
      {
      	long longValue;
        switch(type_id)
        {
          case LGLSXP:  longValue = (long) LOGICAL(arg)[0]; break;
          case INTSXP:  longValue = (long) INTEGER(arg)[0];        break;
          case REALSXP: longValue = (long) REAL(arg)[0];    break;
          case RAWSXP:  longValue = (long) RAW(arg)[0];     break;
          default:      error("expected long castable argument type"); return NULL;
        }
      	dcArgLong(pvm, longValue);
      }
      break;
      case DC_SIGCHAR_INT:
      {
      	int intValue;
        switch(TYPEOF(arg))
        {
          case LGLSXP:  intValue = (int) LOGICAL(arg)[0]; break;
          case INTSXP:  intValue = INTEGER(arg)[0]; break;
          case REALSXP: intValue = (int) REAL(arg)[0]; break;
          case RAWSXP:  intValue = (int) RAW(arg)[0]; break;
          default:      error("expected int argument type"); return NULL;
        }
      	dcArgInt(pvm, intValue);
      }
      break;
      case DC_SIGCHAR_FLOAT:
      {
        float floatValue;
        switch(type_id)
        {
          case LGLSXP: floatValue = (float) LOGICAL(arg)[0]; break;
          case INTSXP: floatValue = (float) INTEGER(arg)[0]; break;
          case REALSXP: floatValue = (float) REAL(arg)[0]; break;
          case RAWSXP:  floatValue = (float) RAW(arg)[0]; break;
          default: error("expected float argument type"); return NULL;
        }
        dcArgFloat( pvm, floatValue );
      }
      break;
      case DC_SIGCHAR_DOUBLE:
      {
      	DCdouble doubleValue;
        switch(type_id)
        {
          case LGLSXP: doubleValue = (double) LOGICAL(arg)[0]; break;
          case INTSXP: doubleValue = (double) INTEGER(arg)[0]; break;
          case REALSXP: doubleValue = REAL(arg)[0]; break;
          case RAWSXP:  doubleValue = (double) RAW(arg)[0]; break;
          default: error("expected double argument type"); return NULL;
        }
        dcArgDouble( pvm, doubleValue );
      }
      break;
      case DC_SIGCHAR_LONGLONG:
      {
        DClonglong longlongValue;
        switch(type_id)
        {
          case LGLSXP:  longlongValue = (DClonglong) LOGICAL(arg)[0]; break;
          case INTSXP:  longlongValue = (DClonglong) INTEGER(arg)[0]; break;
          case REALSXP: longlongValue = (DClonglong) REAL(arg)[0]; break;
          case RAWSXP:  longlongValue = (DClonglong) RAW(arg)[0]; break;
          default: error("expected long long argument type"); return NULL;
        }
        dcArgLongLong( pvm, longlongValue );
      }
      break;
      case DC_SIGCHAR_POINTER:
      {
        DCpointer ptrValue;
        switch(type_id)
        {
          case NILSXP:    ptrValue = (DCpointer) 0; break;
          case CHARSXP:   ptrValue = (DCpointer) CHAR(arg); break;
          case SYMSXP:    ptrValue = (DCpointer) PRINTNAME(arg); break;
          case STRSXP:    ptrValue = (DCpointer) CHAR( STRING_ELT(arg,0) ); break;
          case LGLSXP:    ptrValue = (DCpointer) LOGICAL(arg); break;
          case INTSXP:    ptrValue = (DCpointer) INTEGER(arg); break;
          case REALSXP:   ptrValue = (DCpointer) REAL(arg); break;
          case CPLXSXP:   ptrValue = (DCpointer) COMPLEX(arg); break;
          case RAWSXP:    ptrValue = (DCpointer) RAW(arg); break;
          case EXTPTRSXP: ptrValue = R_ExternalPtrAddr(arg); break;
          default: error("expected pointer argument type"); return NULL;
        }
        dcArgPointer(pvm, ptrValue);
      }
      break;
      case DC_SIGCHAR_STRING:
      {
        DCpointer cstringValue;
        switch(type_id)
        {
          case NILSXP:    cstringValue = (DCpointer) 0; break;
          case CHARSXP:   cstringValue = (DCpointer) CHAR(arg); break;
          case SYMSXP:    cstringValue = (DCpointer) PRINTNAME(arg); break;
          case STRSXP:    cstringValue = (DCpointer) CHAR( STRING_ELT(arg,0) ); break;
          case EXTPTRSXP: cstringValue = R_ExternalPtrAddr(arg); break;
          default: error("expected cstring argument type"); return NULL;
        }
        dcArgPointer(pvm, cstringValue);
      }
      break;
      default: error("invalid argument signature"); return NULL;
    }
  }


  if (args != R_NilValue)
    error ("too many arguments");

  /* process return type */

  switch(*sig) {
    case DC_SIGCHAR_BOOL:     return ScalarLogical( ( dcCallBool(pvm, addr) == DC_FALSE ) ? FALSE : TRUE );
    case DC_SIGCHAR_CHAR:     return ScalarInteger( (int) dcCallChar(pvm, addr)  );
    case DC_SIGCHAR_SHORT:    return ScalarInteger( (int) dcCallShort(pvm,addr) );
    case DC_SIGCHAR_INT:      return ScalarInteger( dcCallInt(pvm,addr) );
    case DC_SIGCHAR_LONG:     return ScalarInteger( (int) dcCallLong(pvm, addr) );
    case DC_SIGCHAR_LONGLONG: return ScalarReal( (double) dcCallLongLong(pvm, addr) );
    case DC_SIGCHAR_FLOAT:    return ScalarReal( (double) dcCallFloat(pvm,addr) );
    case DC_SIGCHAR_DOUBLE:   return ScalarReal( dcCallDouble(pvm,addr) );
    case DC_SIGCHAR_POINTER:  return R_MakeExternalPtr( dcCallPointer(pvm,addr), R_NilValue, R_NilValue );
    case DC_SIGCHAR_STRING:   return ScalarString( dcCallPointer(pvm, addr) );
    case DC_SIGCHAR_VOID: dcCallVoid(pvm,addr); return R_NilValue;
    default: error("invalid return type signature"); return NULL;
  }

}


#if 0
  switch(*sig) {
    case DC_SIGCHAR_BOOL:
      PROTECT( r = allocVector(LGLSXP, 1) ); protect_count++;
      LOGICAL(r)[0] = ( dcCallBool(pvm, addr) == DC_FALSE ) ? FALSE : TRUE;
      UNPROTECT(protect_count);
      return r;
    case DC_SIGCHAR_CHAR:
        PROTECT( r = allocVector(INTSXP, 1) ); protect_count++;
        INTEGER(r)[0] = dcCallChar(pvm, addr);
        UNPROTECT(protect_count);
        return r;
    case DC_SIGCHAR_SHORT:
        PROTECT( r = allocVector(INTSXP, 1) ); protect_count++;
        INTEGER(r)[0] = dcCallShort(pvm, addr);
        UNPROTECT(protect_count);
        return r;
    case DC_SIGCHAR_LONG:
        PROTECT( r = allocVector(INTSXP, 1) ); protect_count++;
        INTEGER(r)[0] = dcCallLong(pvm, addr);
        UNPROTECT(protect_count);
        return r;
    case DC_SIGCHAR_INT:
      PROTECT( r = allocVector(INTSXP, 1) ); protect_count++;
      INTEGER(r)[0] = dcCallInt(pvm, addr);
      UNPROTECT(protect_count);
      return r;
    case DC_SIGCHAR_LONGLONG:
      PROTECT( r = allocVector(REALSXP, 1) ); protect_count++;
      REAL(r)[0] = (double) ( dcCallLong(pvm, addr) );
      UNPROTECT(protect_count);
      return r;
    case DC_SIGCHAR_FLOAT:
      PROTECT( r = allocVector(REALSXP, 1) ); protect_count++;
      REAL(r)[0] = (double) ( dcCallFloat(pvm, addr) );
      UNPROTECT(protect_count);
      return r;
    case DC_SIGCHAR_DOUBLE:
      PROTECT( r = allocVector(REALSXP, 1) );
      protect_count++;
      REAL(r)[0] = dcCallDouble(pvm, addr);
      UNPROTECT(protect_count);
      return r;
    case DC_SIGCHAR_POINTER:
      PROTECT( r = R_MakeExternalPtr( dcCallPointer(pvm,addr), R_NilValue, R_NilValue ) );
      protect_count++;
      UNPROTECT(protect_count);
      return r;
    case DC_SIGCHAR_VOID:
      dcCallVoid(pvm,addr);
      if (protect_count) UNPROTECT(protect_count);
      break;
    default:
      {
        if (protect_count)
          UNPROTECT(protect_count);
        error("invalid return type signature");
      }
      break;
  }

  return R_NilValue;
}
#endif

