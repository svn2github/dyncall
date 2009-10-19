#define USE_RINTERNALS
#include <Rdefines.h>
#include <Rinternals.h>
#include <R_ext/RS.h>

/* Float utils */

SEXP r_double2floatraw(SEXP x)
{
  SEXP ans;
  int i, n;
  double *dp;
  float  *fp;
  n = LENGTH(x);
  ans = PROTECT( Rf_allocVector(RAWSXP, sizeof(float)*n) );

  dp = (double*) REAL(x);
  fp = (float*) RAW(ans);

  for(i = 0 ; i < n ; ++i )
    fp[i] = (float) dp[i];

  UNPROTECT(1);
  return ans;
}

SEXP r_floatraw2double(SEXP x)
{
  SEXP ans;
  int i, n;
  float  *fp;
  double *dp;
  n = LENGTH(x) / sizeof(float) ;
  ans = PROTECT( Rf_allocVector(REALSXP, n) );

  fp = (float*) RAW(x);
  dp = (double*) REAL(ans);

  for(i = 0 ; i < n ; ++i )
    dp[i] = (double) fp[i];

  UNPROTECT(1);
  return ans;

}

