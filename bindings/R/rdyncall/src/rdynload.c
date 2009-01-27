/** ===========================================================================
 ** R-Package: rdyncall
 ** File: rdyncall/src/rdynload.c
 ** Description: R bindings to dynload
 **
 ** Copyright (C) 2007-2009 Daniel Adler
 **/

#include <Rinternals.h>
#include "dynload.h"

/** ---------------------------------------------------------------------------
 ** C-Function: r_dynload
 ** Description: load shared library and return lib handle
 ** R-Calling Convention: .Call
 **
 **/

SEXP r_dynload(SEXP libpath_x)
{
  const char* libpath_S;
  void* libHandle;
  
  libpath_S = CHAR(STRING_ELT(libpath_x,0));
  libHandle = dlLoadLibrary(libpath_S);
  
  if (!libHandle) {
    error("r_dynload failed on path %s", libpath_S );
  }

  return R_MakeExternalPtr(libHandle, R_NilValue, R_NilValue);
}

/** ---------------------------------------------------------------------------
 ** C-Function: r_dynunload
 ** Description: unload shared library
 ** R-Calling Convention: .Call
 **
 **/

SEXP r_dynunload(SEXP libobj_x)
{
  void* libHandle = R_ExternalPtrAddr(libobj_x);
  
  if (!libHandle)
    error("not a lib handle");
      
  dlFreeLibrary( libHandle );
    
  return R_NilValue;
}

/** ---------------------------------------------------------------------------
 ** C-Function: r_dynfind
 ** Description: resolve symbol 
 ** R-Calling Convention: .Call
 **
 **/

SEXP r_dynfind(SEXP libobj_x, SEXP symname_x)
{
  void* libHandle = R_ExternalPtrAddr(libobj_x);
  const char* symbol = CHAR(STRING_ELT(symname_x,0) );
  void* addr = dlFindSymbol( libHandle, symbol );
  return (addr) ? R_MakeExternalPtr(addr, R_NilValue, R_NilValue) : R_NilValue;
}
