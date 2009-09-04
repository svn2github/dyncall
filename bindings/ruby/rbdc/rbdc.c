/*/////////////////////////////////////////////////////////////////////

	rbdc.c
	Copyright 2007 Tassilo Philipp

	Ruby/dyncall extension implementation.

//////////////////////////////////////////////////////////////////////*/

#include <ruby.h>
#include "../../../dyncall/dyncall/dyncall.h"
#include "../../../dyncall/dynload/dynload.h"
#include "../../../dyncall/dyncall/dyncall_signature.h"

/* Our ruby module and its classes. */
static VALUE rb_dcModule;
static VALUE rb_dcExtLib;


typedef struct {
	void*     lib;
	DCCallVM* cvm;
} rb_dcLibHandle;


/* Mark-and-sweep GC handlers. */
static void GCMark_ExtLib(rb_dcLibHandle* extLib)
{
}


static void GCSweep_ExtLib(rb_dcLibHandle* extLib)
{
	if(extLib->lib != NULL)
		dlFreeLibrary(extLib->lib);

	dcFree(extLib->cvm);
	free(extLib);
}


/* Allocators. */
static VALUE AllocExtLib(VALUE cl)
{
	rb_dcLibHandle* extLib = malloc(sizeof(rb_dcLibHandle));
	extLib->lib = NULL;
	extLib->cvm = dcNewCallVM(4096/*@@@*/);
	return Data_Wrap_Struct(cl, GCMark_ExtLib, GCSweep_ExtLib, extLib);
}


/* Methods. */
static VALUE ExtLib_Load(VALUE self, VALUE path)
{
	void* newLib;
	rb_dcLibHandle* extLib;

	Data_Get_Struct(self, rb_dcLibHandle, extLib);

	if(TYPE(path) != T_STRING)
		rb_raise(rb_eRuntimeError, "argument must be of type 'String'");/*@@@ respond to to_s*/

	newLib = dlLoadLibrary(RSTRING_PTR(path));
	if(newLib != NULL) {
		dlFreeLibrary(extLib->lib);
		extLib->lib = newLib;

		return self;
	}

	return Qnil;
}



static void ExtLib_SecCheck(rb_dcLibHandle* extLib)
{
	if(extLib->lib == NULL)
		rb_raise(rb_eRuntimeError, "no library loaded - use ExtLib#load");
}


static VALUE ExtLib_Count(VALUE self)
{
	rb_dcLibHandle* extLib;

	Data_Get_Struct(self, rb_dcLibHandle, extLib);

	ExtLib_SecCheck(extLib);

	return LONG2NUM(dlSymsCount(extLib->lib));
}


static VALUE ExtLib_Each(int argc, VALUE* argv, VALUE self)//@@@ bug
{
	rb_dcLibHandle* extLib;
	size_t i, c;

	Data_Get_Struct(self, rb_dcLibHandle, extLib);

	if(!rb_block_given_p())
		rb_raise(rb_eRuntimeError, "no block given");

	ExtLib_SecCheck(extLib);

	c = dlSymsCount(extLib->lib);
	for(i=0; i<c; ++i)
		rb_yield(ID2SYM(rb_intern(dlSymsName(extLib->lib, i))));

	return self;
}


static VALUE ExtLib_ExistsQ(VALUE self, VALUE sym)
{
	rb_dcLibHandle* extLib;

	Data_Get_Struct(self, rb_dcLibHandle, extLib);

	ExtLib_SecCheck(extLib);

	return dlFindSymbol(extLib->lib, rb_id2name(SYM2ID(sym))) ? Qtrue : Qfalse;
}


static VALUE ExtLib_Call(int argc, VALUE* argv, VALUE self)
{
	/* argv[0] - symbol to call  *
	 * argv[1] - signature       *
	 * argv[2] - first parameter *
	 * argv[x] - parameter x-2   */

	rb_dcLibHandle* extLib;
	DCpointer   fptr;
	int         i, t, b;
	VALUE       r;
	DCCallVM*   cvm;
	const char* sig;


	/* Security checks. */
	if(argc < 2)
		rb_raise(rb_eRuntimeError, "wrong number of arguments for function call");

	if(TYPE(argv[0]) != T_SYMBOL)
		rb_raise(rb_eRuntimeError, "syntax error - argument 0 must be of type 'Symbol'");

	if(TYPE(argv[1]) != T_STRING)
		rb_raise(rb_eRuntimeError, "syntax error - argument 1 must be of type 'String'");

	Data_Get_Struct(self, rb_dcLibHandle, extLib);
	cvm = extLib->cvm;

	if(argc != RSTRING_LEN(argv[1]))	/* Don't count the return value in the signature @@@ write something more secure */
		rb_raise(rb_eRuntimeError, "number of provided arguments doesn't match signature");

	ExtLib_SecCheck(extLib);


	/* Flush old arguments. */
	dcReset(cvm);


	/* Get a pointer to the function and start pushing. */
	fptr = (DCpointer)dlFindSymbol(extLib->lib, rb_id2name(SYM2ID(argv[0])));
	sig = RSTRING_PTR(argv[1]);/*@@@ should use StringValuePtr for real strings... 'S' in signature*/

	for(i=2; i<argc; ++i) {
		t = TYPE(argv[i]);

		switch(sig[i-2]) {
			case DC_SIGCHAR_BOOL:
				b = 1;
				switch(t) {
					case T_TRUE:   dcArgBool(cvm, DC_TRUE);                break;  /* TrueClass.  */
					case T_FALSE:                                                  /* FalseClass. */
					case T_NIL:    dcArgBool(cvm, DC_FALSE);               break;  /* NilClass.   */
					case T_FIXNUM: dcArgBool(cvm, FIX2LONG(argv[i]) != 0); break;  /* Fixnum.     */
					default:       b = 0;                                  break;
				}
				break;
/* @@@ Allow conversion of Bignum, too. */
			case DC_SIGCHAR_CHAR:
			case DC_SIGCHAR_UCHAR:     if(b = (t == T_FIXNUM)) dcArgChar    (cvm, (DCchar)    FIX2LONG(argv[i]));      break;
			case DC_SIGCHAR_SHORT:
			case DC_SIGCHAR_USHORT:    if(b = (t == T_FIXNUM)) dcArgShort   (cvm, (DCshort)   FIX2LONG(argv[i]));      break;
			case DC_SIGCHAR_INT:
			case DC_SIGCHAR_UINT:      if(b = (t == T_FIXNUM)) dcArgInt     (cvm, (DCint)     FIX2LONG(argv[i]));      break;
			case DC_SIGCHAR_LONG:
			case DC_SIGCHAR_ULONG:     if(b = (t == T_FIXNUM)) dcArgLong    (cvm, (DClong)    FIX2LONG(argv[i]));      break;
			case DC_SIGCHAR_LONGLONG:
			case DC_SIGCHAR_ULONGLONG: if(b = (t == T_FIXNUM)) dcArgLongLong(cvm, (DClonglong)FIX2LONG(argv[i]));      break;
			case DC_SIGCHAR_FLOAT:     if(b = (t == T_FLOAT))  dcArgFloat   (cvm, (DCfloat)   RFLOAT_VALUE(argv[i]));  break;
			case DC_SIGCHAR_DOUBLE:    if(b = (t == T_FLOAT))  dcArgDouble  (cvm, (DCdouble)  RFLOAT_VALUE(argv[i]));  break;

			//@@@case DC_SIGCHAR_POINTER:
			case DC_SIGCHAR_STRING:
				b = 1;	
				switch(t) {
					case T_STRING: dcArgPointer(cvm, RSTRING_PTR(argv[i])); break;  /* String. */
					default:       b = 0;                                   break;
				}
				break;

			default:
				b = 0;
				break;
		}


		if(!b)
			rb_raise(rb_eRuntimeError, "syntax error in signature or type mismatch at argument %d", i-2);
	}


	/* Get the return type and call the function. */
	switch(sig[i-1]) {
		case DC_SIGCHAR_VOID:      r = Qnil;        dcCallVoid    (cvm, fptr);                  break;
		case DC_SIGCHAR_BOOL:      r =              dcCallBool    (cvm, fptr) ? Qtrue : Qfalse; break;
		case DC_SIGCHAR_CHAR:
		case DC_SIGCHAR_UCHAR:     r = CHR2FIX(     dcCallChar    (cvm, fptr));                 break;
		case DC_SIGCHAR_SHORT:
		case DC_SIGCHAR_USHORT:    r = INT2FIX(     dcCallShort   (cvm, fptr));                 break;
		case DC_SIGCHAR_INT:
		case DC_SIGCHAR_UINT:      r = INT2FIX(     dcCallInt     (cvm, fptr));                 break;
		case DC_SIGCHAR_LONG:
		case DC_SIGCHAR_ULONG:     r = INT2FIX(     dcCallLong    (cvm, fptr));                 break;
		case DC_SIGCHAR_LONGLONG:
		case DC_SIGCHAR_ULONGLONG: r = INT2FIX(     dcCallLongLong(cvm, fptr));                 break;
		case DC_SIGCHAR_FLOAT:     r = rb_float_new(dcCallFloat   (cvm, fptr));                 break;
		case DC_SIGCHAR_DOUBLE:    r = rb_float_new(dcCallDouble  (cvm, fptr));                 break;
		case DC_SIGCHAR_STRING://@@@implement
		case DC_SIGCHAR_POINTER:
		default:
			rb_raise(rb_eRuntimeError, "unsupported return type or syntax error in signature");
	}

	return r;
}


/* Main initialization. */
void Init_rbdc()
{
	rb_dcModule = rb_define_module("Dyncall");

	/* Handle to the external dynamic library. */
	rb_dcExtLib = rb_define_class_under(rb_dcModule, "ExtLib", rb_cObject);

	/* Class allocators. */
	rb_define_alloc_func(rb_dcExtLib, AllocExtLib);

	/* Methods. */
	rb_define_method(rb_dcExtLib, "load",         &ExtLib_Load,     1);
	rb_define_method(rb_dcExtLib, "symbol_count", &ExtLib_Count,    0);
	rb_define_method(rb_dcExtLib, "each",         &ExtLib_Each,    -1);
	rb_define_method(rb_dcExtLib, "exists?",      &ExtLib_ExistsQ,  1);
	rb_define_method(rb_dcExtLib, "call",         &ExtLib_Call,    -1);
}

