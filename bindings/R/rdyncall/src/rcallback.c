#include "Rinternals.h"
#include "Rdefines.h"
#include "dyncall_callback.h"

typedef struct
{
	int         disabled;
	SEXP        fun;
	SEXP        rho;
	int         nargs;
	const char* signature; /* argument signature without call mode prefix */
} R_Callback;

char dcCallbackHandler_R( DCCallback* pcb, DCArgs* args, DCValue* result, void* userdata )
{
	R_Callback* rdata;
	const char* ptr;
	int i,n;
	SEXP s, x, ans, item;
	char ch;

	rdata = (R_Callback*) userdata;

	if (rdata->disabled) return DC_SIGCHAR_VOID;

	ptr = rdata->signature;

	// allocate an nargs + 1 'call' language object
	//   first argument is function
	//   rest is arguments from callback
	n = 1 + rdata->nargs;

	PROTECT( s = allocList(n) );
	SET_TYPEOF(s, LANGSXP);
	SETCAR( s, rdata->fun ); x = CDR(s);

	// fill up call object

	i = 1;
	for( ;; ++i) {
		ch = *ptr++;
		if (ch == ')') break;
		if (i >= n) {
			warning("invalid signature.");
			rdata->disabled = 1;
			UNPROTECT(1);
			return DC_SIGCHAR_VOID;
		}
		switch(ch) {
		case DC_SIGCHAR_BOOL:      item = ScalarLogical( ( dcArgs_bool(args) == DC_FALSE ) ? FALSE : TRUE ); break;
		case DC_SIGCHAR_CHAR:      item = ScalarInteger( (int) dcArgs_char(args) ); break;
		case DC_SIGCHAR_UCHAR:     item = ScalarInteger( (int) dcArgs_uchar(args) ); break;
		case DC_SIGCHAR_SHORT:     item = ScalarInteger( (int) dcArgs_short(args) ); break;
		case DC_SIGCHAR_USHORT:    item = ScalarInteger( (int) dcArgs_ushort(args) ); break;
		case DC_SIGCHAR_INT:       item = ScalarInteger( (int) dcArgs_int(args) ); break;
		case DC_SIGCHAR_UINT:      item = ScalarInteger( (int) dcArgs_uint(args) ); break;
		case DC_SIGCHAR_LONG:      item = ScalarInteger( (int) dcArgs_long(args) ); break;
		case DC_SIGCHAR_ULONG:     item = ScalarInteger( (int) dcArgs_ulong(args) ); break;
		case DC_SIGCHAR_LONGLONG:  item = ScalarReal( (double) dcArgs_longlong(args) ); break;
		case DC_SIGCHAR_ULONGLONG: item = ScalarReal( (double) dcArgs_ulonglong(args) ); break;
		case DC_SIGCHAR_FLOAT:     item = ScalarReal( (double) dcArgs_float(args) ); break;
		case DC_SIGCHAR_DOUBLE:    item = ScalarReal( dcArgs_double(args) ); break;
		case DC_SIGCHAR_POINTER:   item = R_MakeExternalPtr( dcArgs_pointer(args), R_NilValue, R_NilValue ); break;
		case DC_SIGCHAR_STRING:    item = mkString( dcArgs_pointer(args) ); break;
		default:
		case '\0':
			warning("invalid signature");
			rdata->disabled = 1;
			UNPROTECT(1);
			return DC_SIGCHAR_VOID;
		}
		SETCAR( x, item);
		x = CDR(x);
	}

	/* evaluate expression */

	int error = 0;

	PROTECT( ans = R_tryEval( s, rdata->rho, &error ) );

	if (error)
	{
		warning("an error occurred during callback invocation in R. Callback disabled.");
		rdata->disabled = 1;
		UNPROTECT(2);
		return DC_SIGCHAR_VOID;
	}

	/* propagate return value */

	ch = *ptr;	/* scan return value type character */

	/* handle NULL and len(x) == 0 expressions special */
	if ( (ans == R_NilValue) || (LENGTH(ans) == 0) )
	{
		/* handle NULL */
		result->L = 0;
	}
	else
	{
		switch(ch)
		{
		case DC_SIGCHAR_VOID:
			break;
		case DC_SIGCHAR_BOOL:
			switch( TYPEOF(ans) )
			{
			case INTSXP: result->B = (INTEGER(ans)[0] == 0 ) ? DC_FALSE : DC_TRUE; break;
			case LGLSXP: result->B = (LOGICAL(ans)[0] == FALSE ) ? DC_FALSE : DC_TRUE; break;
			default:     result->B = DC_FALSE; break;
			}
			break;
		case DC_SIGCHAR_CHAR:
		case DC_SIGCHAR_UCHAR:
		case DC_SIGCHAR_SHORT:
		case DC_SIGCHAR_USHORT:
		case DC_SIGCHAR_INT:
		case DC_SIGCHAR_UINT:
		case DC_SIGCHAR_LONG:
		case DC_SIGCHAR_ULONG:
			switch( TYPEOF(ans) )
			{
			case INTSXP:  result->i = INTEGER(ans)[0]; break;
			case REALSXP: result->i = (int) REAL(ans)[0]; break;
			default:      result->i = 0; break;
			}
			break;
		case DC_SIGCHAR_ULONGLONG:
		case DC_SIGCHAR_LONGLONG:
			switch( TYPEOF(ans) )
			{
			case INTSXP:  result->L = (long long) INTEGER(ans)[0]; break;
			case REALSXP: result->L = (long long) REAL(ans)[0]; break;
			default:      result->L = 0; break;
			}
			break;
		case DC_SIGCHAR_FLOAT:
			switch( TYPEOF(ans) )
			{
			case INTSXP:  result->f = (float) INTEGER(ans)[0]; break;
			case REALSXP: result->f = (float) REAL(ans)[0]; break;
			default:      result->f = 0.0f; break;
			}
			break;
		case DC_SIGCHAR_DOUBLE:
			switch( TYPEOF(ans) )
			{
			case INTSXP:  result->d = (double) INTEGER(ans)[0]; break;
			case REALSXP: result->d = REAL(ans)[0]; break;
			default:      result->d = 0.0; break;
			}
			break;
		case DC_SIGCHAR_POINTER:
			switch( TYPEOF(ans) )
			{
			case EXTPTRSXP: result->p = R_ExternalPtrAddr(ans); break;
			case INTSXP   : result->p = (DCpointer) INTEGER(ans)[0]; break;
			case REALSXP  : result->p = (DCpointer) (int) REAL(ans)[0]; break;
			default:        result->p = NULL; break;
			}
			break;
		case DC_SIGCHAR_STRING:
			warning("not implemented");
			rdata->disabled = 1;
			break;
		}
	}
	UNPROTECT(2);
	return ch;
}

SEXP r_new_callback(SEXP sig_x, SEXP fun_x, SEXP rho_x)
{
	const char* signature;
	R_Callback* rdata;
	const char* ptr;
	char ch;
	signature  = CHAR( STRING_ELT( sig_x, 0 ) );
	rdata = Calloc(1, R_Callback);
	rdata->disabled = 0;
	rdata->fun = fun_x;
	rdata->rho = rho_x;
	ptr = signature;
	// skip call mode signature
	if ( (ch=*ptr) == '_') {
		ptr += 2;
		ch=*ptr;
	}
	rdata->signature = ptr++;
	int nargs = 0;
	while( ch != ')')
	{
		nargs ++;
		ch = *ptr++;
	}
	rdata->nargs = nargs;
	Rprintf("%d\n", nargs);
	DCCallback* cb = dcNewCallback( signature, dcCallbackHandler_R, rdata);
	return R_MakeExternalPtr( cb, R_NilValue, R_NilValue );
}

SEXP r_free_callback(SEXP x)
{
	dcFreeCallback( R_ExternalPtrAddr(x) );
	return R_NilValue;
}
