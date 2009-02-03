#include "Rinternals.h"

SEXP r_new_callback(SEXP sig_x, SEXP fun_x, SEXP rho_x, SEXP mode_x)
{
	return R_NilValue;
}
#if 0

#include "Rinternals.h"
#include "rdyncall_signature.h"
#include "dyncall_callback.h"

#define DC_MODE_C_CDECL   DC_CALL_C_DEFAULT
#define DC_MODE_C_STDCALL DC_CALL_C_X86_WIN32_STD

#define DC_MODE_C_FASTCALL_GCC DC_CALL_C_X86_WIN32_FAST_GNU
#define DC_MODE_C_FASTCALL_MSVC DC_CALLC_X86_WIN32_FAST_MS
#define DC_MODE_C_THISCALL_GCC DC_CALL_C_X86_WIN32_THIS_GNU
#define DC_MODE_C_THISCALL_MSVC DC_CALLC_X86_WIN32_THIS_MS

#define DC_MODE_C_VARARGS DC_CALL_C_DEFAULT

/* abstract tokens */
#define DC_MODENAME_CDECL     "cdecl"
#define DC_MODENAME_VARGS     "vargs"
#define DC_MODENAME_THISCALL  "thiscall"
/* x86 specific: */
#define DC_MODENAME_STDCALL   "stdcall"
#define DC_MODENAME_FASTMSVC  "fastcall_msvc"
#define DC_MODENAME_FASTGCC   "fastcall_gcc"
#define DC_MODENAME_THISMSVC  "thiscall_msvc"
#define DC_MODENAME_THISGCC   "thiscall_gcc"

int dcStringToMode(const char* mode)
{
  int x;

  if (strcmp(mode, "cdecl") == 0)
    x = DC_MODE_C_CDECL;
  else if (strcmp(mode, "stdcall") == 0)
    x = DC_MODE_C_STDCALL;
  else
    x = -1;

  return x;
}

SEXP r_new_callback(SEXP sig_x, SEXP fun_x, SEXP rho_x, SEXP mode_x)
{
  const char* mode_z = CHAR( STRING_ELT(mode_x,0) );

  int mode = dcStringToMode(mode_z)
  if (mode == -1) error("invalid 'mode'");

  const char* sig = CHAR( STRING_ELT(value_x,0) );
  CallbackData* userdata = Calloc(1, CallbackData);
  userdata->fun = fun_x;
  userdata->rho = rho_x;
  DCCallback* pcb = dcNewCallback( mode, sig, userdata);

  SEXP x = R_MakeExternalPtr( pcb, R_NilValue, R_NilValue );

}


#if 0
typedef void (*funptr_t) ();

typedef struct
{
  char*   sig;
  int     nargs;
  DCArgs* args;
  SEXP    fun;
} info;

void do_eval(info* p)
{
  char* sig = p->sig;
  int nargs = p->nargs;
  SEXP s, t = PROTECT( allocList(nargs) );
  SET_TYPEOF(s, LANGSXP);
  SETCAR( t, p->fun );
  t = CDR(t);
  for(i=0;i < nargs; ++i)
  {
    switch(*sig++)
    {
	  case DC_SIGCHAR_CHAR:
	    SETCAR( t, ScalarInteger( dcPopChar(p->args) ) );
	    break;
	  case DC_SIGCHAR_INT:
		SETCAR( t, ScalarInteger( dcPopInt(p->args) ) );
		break;
	  case DC_SIGCHAR_POINTER:
		SETCAR( t, MakeExternalPtr( dcPopPointer(p->args) ) );
		break;
	}
    t = CDR(t);
  }
}

typedef struct
{
  SEXP signature;
  SEXP function;
  SEXP rho;
} r_callback;

void* dcNewCallback();

#endif

typedef void (*DCCallBack)(DCArgs* pa, void* userdata);

typedef struct
{
  const char* signature;
  int  nargs;
  SEXP fun;
  SEXP rho;
} R_DC_CallBack;

void trampoline(DCThunk* thunk, int arg0)
{
  thunk->call_handler( thunk, &arg0 );
}

struct DCThunk
{
  void (*arg_handler)();
  void (*call_handler)(DCThunk* thunk);
  void (*userdata)();
  void* callback;
  unsigned char code[];
};

void emit_thunk(unsigned char* code, DCThunk* trampo)
{
//  mov eax, #address
//  jmp [eax]
}

void dcThunkInit_x86_stdcall(DCThunk* pthunk, size_t nargs)
{
  pthunk->callback = &pthunk->jumpcode;
  //
  pthunk->code[0] = 0x10;
  * ( (int*) &pthunk->code[1] ) = pthunk;
  pthunk->code[5] = 0x
}

void init()
{
  DCThunk* pthunk = malloc(sizeof(DCThunk));
  dcThunkInit_x86( pthunk );

}

DCValue dyncall_R_callback(void* userdata, DCArgs* pa)
{
  RCallback* pCallback = (RCallback*) userdata;
  const char* sig  = pCallback->signature;
  int nargs = pCallback->nargs;
  SEXP fun = pCallback->fun;
  SEXP args;
  PROTECT( args = R_allocNewList(nargs) );
  int index = 0;
  for(;index < nargs;++index) {
	SEXP x;
    switch(*sig++)
    {
    case DC_SIGCHAR_POINTER: x = R_MakeExternalPtr( dcPopPointer(pa), R_NilValue, R_NilValue ); break;
    case DC_SIGCHAR_INT: x = ScalarInteger( dcPopInt(pa) ); break; }
    }
	SET_VECTOR_ELT( args, index, x );
  }
  ans = eval(fun, rho);
  switch(*sig)
  {
	case DC_SIGCHAR_INT: result.i = AS_INTEGER(INTSXP, ans)[0]; break;
  }
  return result;
}

int istype(char ch)
{
  if (ch >= 'a' && ch <= 'z') return 1;
  return 0;
}

void x86_stdcall_stacksize(char* sig)
{
  size_t s;
  switch(*sig++)
  {
  case DC_SIGCHAR_SHORT:
  case DC_SIGCHAR_USHORT:
  case DC_SIGCHAR_CHAR:
  case DC_SIGCHAR_UCHAR:
  case DC_SIGCHAR_LONG:
  case DC_SIGCHAR_ULONG:
  case DC_SIGCHAR_INT:
  case DC_SIGCHAR_UINT:
  case DC_SIGCHAR_FLOAT:
  case DC_SIGCHAR_POINTER:
  case DC_SIGCHAR_STRING:
	  s += 4;
	  break;
  case DC_SIGCHAR_DOUBLE:
  case DC_SIGCHAR_LONGLONG:
	  s += 8;
	  break;
  }
}

#endif
