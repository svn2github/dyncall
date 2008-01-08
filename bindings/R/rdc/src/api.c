#include <R.h>
#include <Rinternals.h>
#include <R_ext/Rdynload.h>

#include "dynload.h"
#include "dyncall.h"
#include "dyncall_signature.h"


/* rdcLoad */

SEXP rdcLoad(SEXP sLibPath)
{ 
  void* libHandle;
  const char* libPath;
  SEXP r;
  libPath = CHAR(STRING_ELT(sLibPath,0));

  libHandle = dlLoadLibrary(libPath);
  
  if (!libHandle) {
    error("rdcLoad failed on path %s", libPath );
  }

  r = R_NilValue;

  PROTECT( r = R_MakeExternalPtr(libHandle, R_NilValue, R_NilValue) );  
  UNPROTECT(1);
  
  return r;
}

/* rdcFree */

SEXP rdcFree(SEXP sLibHandle)
{
  void* libHandle;

  libHandle = R_ExternalPtrAddr(sLibHandle);  
  dlFreeLibrary( libHandle );
  
  R_SetExternalPtrAddr(sLibHandle, 0);
  return R_NilValue;
}

/* rdcFind */

SEXP rdcFind(SEXP sLibHandle, SEXP sSymbol)
{
  void* libHandle;
  const char* symbol;
  void* addr;
  SEXP r;
  libHandle = R_ExternalPtrAddr(sLibHandle);
  symbol = CHAR(STRING_ELT(sSymbol,0) );
  addr = dlFindSymbol( libHandle, symbol );
  
  r = R_NilValue;
  
  PROTECT( r = R_MakeExternalPtr(addr, R_NilValue, R_NilValue) );
  UNPROTECT(1);
  
  return r;
}

/* rdcCall */

DCCallVM* gCall;

SEXP rdcCall(SEXP sFuncPtr, SEXP sSignature, SEXP sArgs)
{
  void* funcPtr;
  const char* signature;
  const char* ptr;
  int i,l;
  SEXP r;

  funcPtr = R_ExternalPtrAddr(sFuncPtr);
  
  if (!funcPtr) error("funcptr is null");

  signature = CHAR(STRING_ELT(sSignature,0) );

  if (!signature) error("signature is null");
    
  dcReset(gCall);
  ptr = signature;

  l = LENGTH(sArgs);
  
  i = 0;
  for(;;) {
    char ch = *ptr++;
    SEXP arg;
    
    if (ch == '\0') error("invalid signature - no return type specified");
    
    if (ch == ')') break;
    
    if (i >= l) error("not enough arguments for given signature (arg length = %d %d %c)", l,i,ch );
      
    arg = VECTOR_ELT(sArgs,i);
    switch(ch) {
      case DC_SIGCHAR_BOOL:
      {
        PROTECT(arg = coerceVector(arg, LGLSXP));
	dcArgBool(gCall, ( LOGICAL(arg)[0] == 0 ) ? DC_FALSE : DC_TRUE );
	UNPROTECT(1);
	break;
      }
      case DC_SIGCHAR_INT:
      {
	PROTECT(arg = coerceVector(arg, INTSXP));
        dcArgInt(gCall, INTEGER(arg)[0]);
        UNPROTECT(1);
        break;
      }
      case DC_SIGCHAR_FLOAT:
      {
        PROTECT(arg = coerceVector(arg, REALSXP) );
	dcArgFloat( gCall, REAL(arg)[0] );
	UNPROTECT(1);
	break;
      }
      case DC_SIGCHAR_DOUBLE:
      {
        PROTECT(arg = coerceVector(arg, REALSXP) );
	dcArgDouble( gCall, REAL(arg)[0] );
	UNPROTECT(1);
	break;      
      }
      case DC_SIGCHAR_LONG:
      {
        PROTECT(arg = coerceVector(arg, REALSXP) );
	dcArgLong( gCall, (DClong) ( REAL(arg)[0] ) );
	UNPROTECT(1);
	break;
      }
      case DC_SIGCHAR_POINTER:
      {
        DCpointer ptr;
	if ( arg == R_NilValue ) ptr = (DCpointer) 0;
	else if (isString(arg) ) ptr = (DCpointer) CHAR( STRING_ELT(arg,0) );
	else { error("invalid signature"); break; }
        dcArgPointer(gCall, ptr);
	break;
      }
    }
    ++i;
  }
  
  if ( i != l ) error ("signature claims to have %d arguments while %d arguments are given", i, l); 
  
  switch(*ptr) {
    case DC_SIGCHAR_BOOL:
      PROTECT( r = allocVector(LGLSXP, 1) );
      LOGICAL(r)[0] = ( dcCallBool(gCall, funcPtr) == DC_FALSE ) ? FALSE : TRUE;
      UNPROTECT(1);
      return r;
    case DC_SIGCHAR_INT:       
      PROTECT( r = allocVector(INTSXP, 1) );
      INTEGER(r)[0] = dcCallInt(gCall, funcPtr);
      UNPROTECT(1);
      return r;
    case DC_SIGCHAR_LONG:
      PROTECT( r = allocVector(REALSXP, 1) );
      REAL(r)[0] = (double) ( dcCallLong(gCall, funcPtr) );
      UNPROTECT(1);
      return r;
    case DC_SIGCHAR_FLOAT:
      PROTECT( r = allocVector(REALSXP, 1) );
      REAL(r)[0] = (double) ( dcCallFloat(gCall, funcPtr) );
      UNPROTECT(1);
      return r;
    case DC_SIGCHAR_DOUBLE:
      PROTECT( r = allocVector(REALSXP, 1) );
      REAL(r)[0] = dcCallDouble(gCall, funcPtr);
      UNPROTECT(1);
      return r;
    case DC_SIGCHAR_POINTER:
      PROTECT( r = R_MakeExternalPtr( dcCallPointer(gCall,funcPtr), R_NilValue, R_NilValue ) );
      UNPROTECT(1);
      return r;
    case DC_SIGCHAR_VOID:
      dcCallVoid(gCall,funcPtr);
      break;
    default:
      error("invalid return type signature");
  }
  return R_NilValue;
}

/* register R to C calls */

R_CallMethodDef callMethods[] =
{
 {"rdcLoad", (DL_FUNC) &rdcLoad, 1},
 {"rdcFree", (DL_FUNC) &rdcFree, 1},
 {"rdcFind", (DL_FUNC) &rdcFind, 2},
 {"rdcCall", (DL_FUNC) &rdcCall, 3},


 {NULL, NULL, 0}
};

void R_init_rdc(DllInfo *info)
{
  R_registerRoutines(info, NULL, callMethods, NULL, NULL);
  gCall = dcNewCallVM(4096);
}

void R_unload_rdc(DllInfo *info)
{
}

