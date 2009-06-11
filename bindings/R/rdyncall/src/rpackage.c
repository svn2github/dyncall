/** ===========================================================================
 ** R-Package: rdyncall
 ** File: rdyncall/src/rpackage.c
 ** Description: R package registry
 **
 ** Copyright (C) 2007-2009 Daniel Adler
 **/

#include <Rinternals.h>
#include <R_ext/Rdynload.h>

/** ---------------------------------------------------------------------------
 ** Package contents:
 */

/* rdyncall.c */
SEXP r_new_callvm(SEXP callmode, SEXP size);
SEXP r_free_callvm(SEXP callvm);
SEXP r_dyncall(SEXP args); /* .External() with args = callvm, address, signature, args */

/* rdynload.c */
SEXP r_dynload(SEXP libpath);
SEXP r_dynfind(SEXP libobj, SEXP symname);
SEXP r_dynunload(SEXP libobj);

/* rpack.c */
SEXP r_pack1(SEXP ptr, SEXP offset, SEXP sig, SEXP value);
SEXP r_unpack1(SEXP ptr, SEXP offset, SEXP sig);

/* rcallback.c */
SEXP r_new_callback(SEXP sig, SEXP fun, SEXP rho, SEXP mode);
SEXP r_free_callback(SEXP ptr_cb);

/* rutils.c */
SEXP r_dataptr(SEXP x, SEXP offset);
SEXP r_addrval(SEXP x);

/** ---------------------------------------------------------------------------
 ** R Interface .External registry
 */

R_ExternalMethodDef externalMethods[] =
{
  /* rdyncall.c */
  {"dyncall",     (DL_FUNC) &r_dyncall,      -1},
  /* end */
  {NULL,NULL,0}
};

/** ---------------------------------------------------------------------------
 ** R Interface .Call registry
 */

R_CallMethodDef callMethods[] =
{
  /* rdyncall.c */
  {"new_callvm",   (DL_FUNC) &r_new_callvm,    2},
  {"free_callvm",  (DL_FUNC) &r_free_callvm,   1},
  /* rdynload.c */
  {"dynload",      (DL_FUNC) &r_dynload,       1},
  {"dynfind",      (DL_FUNC) &r_dynfind,       2},
  {"dynunload",    (DL_FUNC) &r_dynunload,     1},
  /* rpack.c */
  {"pack1",        (DL_FUNC) &r_pack1,         4},
  {"unpack1",      (DL_FUNC) &r_unpack1,       3},
  /* rutils */
  {"dataptr",      (DL_FUNC) &r_dataptr,       2},
  {"addrval",      (DL_FUNC) &r_addrval,       1},
  /* rcallback.c */
  {"new_callback", (DL_FUNC) &r_new_callback,  3},
  {"free_callback",(DL_FUNC) &r_free_callback, 1},
  /* end */
  {NULL,NULL, 0}
};

/** ---------------------------------------------------------------------------
 ** R Library entry:
 */

void R_init_rdyncall(DllInfo *info)
{
  R_registerRoutines(info, NULL, callMethods, NULL, externalMethods);
}

void R_unload_rdyncall(DllInfo *info)
{
}
