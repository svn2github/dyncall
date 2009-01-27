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

/* dyncall */
SEXP r_new_callvm(SEXP callmode, SEXP size);
SEXP r_free_callvm(SEXP callvm);
SEXP r_dyncall(SEXP args); /* .External() with args = callvm, address, signature, args */

/* dynload */
SEXP r_dynload(SEXP libpath);
SEXP r_dynfind(SEXP libobj, SEXP symname);
SEXP r_dynunload(SEXP libobj);

/* utils */
SEXP r_unpack1(SEXP ptr_x, SEXP offset, SEXP sig_x);
SEXP r_dataptr(SEXP x, SEXP offset);

/** ---------------------------------------------------------------------------
 ** R Interface .External registry
 */

R_ExternalMethodDef externalMethods[] =
{
  /* dyncall */
  {"dyncall",     (DL_FUNC) &r_dyncall,      -1},
  /* end */
  {NULL,NULL,0}
};

/** ---------------------------------------------------------------------------
 ** R Interface .Call registry
 */

R_CallMethodDef callMethods[] =
{
  /* dyncall */
  {"new_callvm",  (DL_FUNC) &r_new_callvm,    2},
  {"free_callvm", (DL_FUNC) &r_free_callvm,   1},
  /* dynload */
  {"dynload",     (DL_FUNC) &r_dynload,       1},
  {"dynfind",     (DL_FUNC) &r_dynfind,       2},
  {"dynunload",   (DL_FUNC) &r_dynunload,     1},
  /* utils */
  {"unpack1",     (DL_FUNC) &r_unpack1,       3},
  {"dataptr",     (DL_FUNC) &r_dataptr,       2},
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
