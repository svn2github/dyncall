#include "erl_nif.h"
#include "dyncall/dyncall.h"

#include <string.h>
#include <stdio.h>

/************ Begin NIF initialization *******/

#define MAX_LIBPATH_SZ 128
#define MAX_SYMBOL_NAME_SZ 32
#define MAX_STRING_ARG_SZ 1024

ErlNifResourceType *g_ptrrestype, *g_vmrestype;

static void noop_dtor(ErlNifEnv* env, void* obj) {
  // When erlang gc's a ptr, no-op since we can't know how to free it.
  // Likewise with symbols, etc.
}
static void vm_dtor(ErlNifEnv* env, void* obj) {
  void** ptr = (void**)obj;
  dcFree(*ptr);
}

static int nifload(ErlNifEnv* env, void** priv_data, ERL_NIF_TERM load_info) {
  
  // Allows us to have a native pointer (to vm, lib, symbol, or user-defined) and
  // pass a safe opaque handle into erlang
  g_ptrrestype = enif_open_resource_type(env,"dyncall","pointer",
                                                        noop_dtor,ERL_NIF_RT_CREATE,
                                                        NULL);

  // Works like g_ptrrestype, but requires a dtor that calls dcFree
  g_vmrestype = enif_open_resource_type(env,"dyncall","vmpointer",
                                                        vm_dtor,ERL_NIF_RT_CREATE,
                                                        NULL);

  return 0;
}

/************ End NIF initialization *******/

#define ATOM_OK "ok"
#define ATOM_ERROR "error"

#define ATOM_LIB_NOT_FOUND "lib_not_found"
#define ATOM_TOO_MANY_VMS "max_vms_exceeded"
#define ATOM_TOO_MANY_LIBS "max_libs_exceeded"
#define ATOM_SYMBOL_NOT_FOUND "symbol_not_found"
#define ATOM_BADSZ "bad_vm_size"
#define ATOM_INVALID_VM "invalid_vm"
#define ATOM_INVALID_LIB "invalid_lib"
#define ATOM_INVALID_SYMBOL "invalid_symbol"
#define ATOM_INVALID_ARG "invalid_arg"

static ERL_NIF_TERM new_call_vm(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) {

  long vmsz = 0;
  if(!enif_get_long(env, argv[0], &vmsz)) {
    return enif_make_tuple2(env,
			      enif_make_atom(env,ATOM_ERROR),
			      enif_make_atom(env,ATOM_BADSZ)
			    );
  }

  DCCallVM* vm = dcNewCallVM( vmsz );

  size_t sz = sizeof(DCCallVM*);
  DCpointer ptr_persistent_vm = enif_alloc_resource(g_vmrestype,sz);
  memcpy(ptr_persistent_vm,&vm,sz);
  ERL_NIF_TERM retterm = enif_make_resource(env,ptr_persistent_vm);
  enif_release_resource(ptr_persistent_vm);

  return enif_make_tuple2(env,
			  enif_make_atom(env,ATOM_OK),
                          retterm
			  );
}
  
#define MAYBE_RET_BAD_STRING_ARG(indexvar,argi,limit,retatom) \
  char indexvar[limit]; \
  indexvar[limit-1] = 0; \
  if(enif_get_string(env, argv[argi], indexvar, limit, ERL_NIF_LATIN1) <= 0) { \
    return enif_make_tuple2(env, \
			    enif_make_atom(env,ATOM_ERROR), \
			    enif_make_atom(env,retatom) \
			    ); \
  }

#define RETURN_ERROR(code) return enif_make_tuple2(env, \
			    enif_make_atom(env,ATOM_ERROR), \
			    enif_make_atom(env,code) \
			    );

static ERL_NIF_TERM load_library(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) {
  MAYBE_RET_BAD_STRING_ARG(path,0,MAX_LIBPATH_SZ,ATOM_INVALID_LIB)

  void* libptr = enif_dlopen(path, NULL, NULL);

  // Error if dlLoadLibrary returned NULL
  if(!libptr) RETURN_ERROR(ATOM_LIB_NOT_FOUND)

  size_t sz = sizeof(void*);
  DCpointer ptr_persistent_lib = enif_alloc_resource(g_ptrrestype,sz);
  memcpy(ptr_persistent_lib,&libptr,sz);
  ERL_NIF_TERM retterm = enif_make_resource(env,ptr_persistent_lib);
  enif_release_resource(ptr_persistent_lib);
  
  return enif_make_tuple2(env,
			  enif_make_atom(env,ATOM_OK),
			  retterm
			  );
}

static ERL_NIF_TERM find_symbol(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) {
  MAYBE_RET_BAD_STRING_ARG(path,1,MAX_SYMBOL_NAME_SZ,ATOM_INVALID_SYMBOL)

  void** libptr;
  if(!enif_get_resource(env, argv[0], g_ptrrestype, (void**)&libptr)) RETURN_ERROR(ATOM_INVALID_LIB)

  void* symptr = enif_dlsym(*libptr,path,dlopen_err,NULL);

  size_t sz = sizeof(void*);
  DCpointer ptr_persistent_symbol = enif_alloc_resource(g_ptrrestype,sz);
  memcpy(ptr_persistent_symbol,&symptr,sz);
  ERL_NIF_TERM retterm = enif_make_resource(env,ptr_persistent_symbol);
  enif_release_resource(ptr_persistent_symbol);

  // Error if enif_dlsym returned NULL
  if(!symptr) RETURN_ERROR(ATOM_SYMBOL_NOT_FOUND)
  
  return enif_make_tuple2(env,
			  enif_make_atom(env,ATOM_OK),
			  retterm
			  );
}

#define GET_VM void** vmptr; \
  if(!enif_get_resource(env, argv[0], g_vmrestype, (void**)&vmptr)) RETURN_ERROR(ATOM_INVALID_VM); \
  if(!*vmptr) RETURN_ERROR(ATOM_INVALID_VM);

static ERL_NIF_TERM arg_double(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) {
  GET_VM;

  double arg = -1.0;
  if(!enif_get_double(env, argv[1], &arg)) RETURN_ERROR(ATOM_INVALID_ARG)

  dcArgDouble(*vmptr,arg);
  return enif_make_atom(env,ATOM_OK);
}

static ERL_NIF_TERM call_double(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) {
  GET_VM;

  void** symptr;
  if(!enif_get_resource(env, argv[1], g_ptrrestype, (void**)&symptr)) RETURN_ERROR(ATOM_INVALID_ARG)

  if(!*symptr) RETURN_ERROR(ATOM_INVALID_SYMBOL)

  DCdouble ret = dcCallDouble(*vmptr,*symptr);

  return enif_make_tuple2(env,
			  enif_make_atom(env,ATOM_OK),
			  enif_make_double(env,ret)
			  );
}

static ERL_NIF_TERM arg_float(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) {
  GET_VM;

  double arg = -1.0;
  if(!enif_get_double(env, argv[1], &arg)) RETURN_ERROR(ATOM_INVALID_ARG)

  dcArgFloat(*vmptr,(float)arg);
  return enif_make_atom(env,ATOM_OK);
}

static ERL_NIF_TERM call_float(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) {
  GET_VM;

  void** symptr;
  if(!enif_get_resource(env, argv[1], g_ptrrestype, (void**)&symptr)) RETURN_ERROR(ATOM_INVALID_ARG)
  if(!*symptr) RETURN_ERROR(ATOM_INVALID_SYMBOL)

  DCfloat ret = dcCallFloat(*vmptr,*symptr);

  return enif_make_tuple2(env,
			  enif_make_atom(env,ATOM_OK),
			  enif_make_double(env,ret)
			  );
}

static ERL_NIF_TERM arg_int(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) {
  GET_VM;

  int arg = -1;
  if(!enif_get_int(env, argv[1], &arg)) RETURN_ERROR(ATOM_INVALID_ARG)

  dcArgInt(*vmptr,arg);
  return enif_make_atom(env,ATOM_OK);
}

static ERL_NIF_TERM call_int(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) {
  GET_VM;

  void** symptr;
  if(!enif_get_resource(env, argv[1], g_ptrrestype, (void**)&symptr)) RETURN_ERROR(ATOM_INVALID_ARG)
  if(!*symptr) RETURN_ERROR(ATOM_INVALID_SYMBOL)

  DCint ret = dcCallInt(*vmptr,*symptr);

  return enif_make_tuple2(env,
			  enif_make_atom(env,ATOM_OK),
			  enif_make_int(env,ret)
			  );
}

static ERL_NIF_TERM arg_char(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) {
  GET_VM;

  int arg = -1;
  if(!enif_get_int(env, argv[1], &arg)) RETURN_ERROR(ATOM_INVALID_ARG)

  dcArgChar(*vmptr,(char)arg);
  return enif_make_atom(env,ATOM_OK);
}

static ERL_NIF_TERM call_char(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) {
  GET_VM;

  void** symptr;
  if(!enif_get_resource(env, argv[1], g_ptrrestype, (void**)&symptr)) RETURN_ERROR(ATOM_INVALID_ARG)
  if(!*symptr) RETURN_ERROR(ATOM_INVALID_SYMBOL)

  DCchar ret = dcCallChar(*vmptr,*symptr);

  return enif_make_tuple2(env,
			  enif_make_atom(env,ATOM_OK),
			  enif_make_int(env,ret)
			  );
}

#define BOOL_BUF_SZ 6
#define ATOM_TRUE "true"
#define ATOM_FALSE "false"

static ERL_NIF_TERM arg_bool(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) {
  GET_VM;

  char arg[BOOL_BUF_SZ];
  if(!enif_get_atom(env, argv[1], arg, BOOL_BUF_SZ, ERL_NIF_LATIN1)) RETURN_ERROR(ATOM_INVALID_ARG)

  dcArgBool(*vmptr,!strcmp(arg,ATOM_TRUE));
  return enif_make_atom(env,ATOM_OK);
}

static ERL_NIF_TERM call_bool(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) {
  GET_VM;

  void** symptr;
  if(!enif_get_resource(env, argv[1], g_ptrrestype, (void**)&symptr)) RETURN_ERROR(ATOM_INVALID_ARG)
  if(!*symptr) RETURN_ERROR(ATOM_INVALID_SYMBOL)

  DCbool ret = dcCallBool(*vmptr,*symptr);
  char* retstr = ret ? ATOM_TRUE : ATOM_FALSE;
  return enif_make_tuple2(env,
			  enif_make_atom(env,ATOM_OK),
			  enif_make_atom(env,retstr)
			  );
}

static ERL_NIF_TERM arg_short(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) {
  GET_VM;

  int arg = -1;
  if(!enif_get_int(env, argv[1], &arg)) RETURN_ERROR(ATOM_INVALID_ARG)

  dcArgShort(*vmptr,(short)arg);
  return enif_make_atom(env,ATOM_OK);
}

static ERL_NIF_TERM call_short(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) {
  GET_VM;

  void** symptr;
  if(!enif_get_resource(env, argv[1], g_ptrrestype, (void**)&symptr)) RETURN_ERROR(ATOM_INVALID_ARG)
  if(!*symptr) RETURN_ERROR(ATOM_INVALID_SYMBOL)

  DCshort ret = dcCallShort(*vmptr,*symptr);

  return enif_make_tuple2(env,
			  enif_make_atom(env,ATOM_OK),
			  enif_make_int(env,ret)
			  );
}

static ERL_NIF_TERM arg_long(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) {
  GET_VM;

  long int arg = -1;
  if(!enif_get_long(env, argv[1], &arg)) RETURN_ERROR(ATOM_INVALID_ARG)

  dcArgLong(*vmptr,arg);
  return enif_make_atom(env,ATOM_OK);
}

static ERL_NIF_TERM call_long(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) {
  GET_VM;

  void** symptr;
  if(!enif_get_resource(env, argv[1], g_ptrrestype, (void**)&symptr)) RETURN_ERROR(ATOM_INVALID_ARG)
  if(!*symptr) RETURN_ERROR(ATOM_INVALID_SYMBOL)

  DClong ret = dcCallLong(*vmptr,*symptr);

  return enif_make_tuple2(env,
			  enif_make_atom(env,ATOM_OK),
			  enif_make_long(env,ret)
			  );
}

static ERL_NIF_TERM arg_longlong(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) {
  GET_VM;

  ErlNifSInt64 arg = -1;
  if(!enif_get_int64(env, argv[1], &arg)) RETURN_ERROR(ATOM_INVALID_ARG)

  dcArgLongLong(*vmptr,arg);
  return enif_make_atom(env,ATOM_OK);
}

static ERL_NIF_TERM call_longlong(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) {
  GET_VM;

  void** symptr;
  if(!enif_get_resource(env, argv[1], g_ptrrestype, (void**)&symptr)) RETURN_ERROR(ATOM_INVALID_ARG)
  if(!*symptr) RETURN_ERROR(ATOM_INVALID_SYMBOL)

  DClonglong ret = dcCallLongLong(*vmptr,*symptr);

  return enif_make_tuple2(env,
			  enif_make_atom(env,ATOM_OK),
			  enif_make_int64(env,ret)
			  );
}

static ERL_NIF_TERM arg_ptr(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) {
  GET_VM;

  void** ptr;
  if(!enif_get_resource(env, argv[1], g_ptrrestype, (void**)&ptr)) RETURN_ERROR(ATOM_INVALID_ARG)

  dcArgPointer(*vmptr,*ptr);

  return enif_make_atom(env,ATOM_OK);
}

static ERL_NIF_TERM call_ptr(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) {
  GET_VM;

  void** symptr;
  if(!enif_get_resource(env, argv[1], g_ptrrestype, (void**)&symptr)) RETURN_ERROR(ATOM_INVALID_ARG);
  if(!*symptr) RETURN_ERROR(ATOM_INVALID_SYMBOL)

  DCpointer ptr = dcCallPointer(*vmptr,*symptr);
  size_t sz = sizeof(DCpointer);

  DCpointer ptr_persistent = enif_alloc_resource(g_ptrrestype,sz);
  memcpy(ptr_persistent,&ptr,sz);
  ERL_NIF_TERM retterm = enif_make_resource(env,ptr_persistent);
  enif_release_resource(ptr_persistent);
  
  return enif_make_tuple2(env,
        		  enif_make_atom(env,ATOM_OK),
                          retterm
        		  );
}

static ERL_NIF_TERM call_void(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) {
  GET_VM;

  void** symptr;
  if(!enif_get_resource(env, argv[1], g_ptrrestype, (void**)&symptr)) RETURN_ERROR(ATOM_INVALID_ARG)
  if(!*symptr) RETURN_ERROR(ATOM_INVALID_SYMBOL)

  dcCallVoid(*vmptr,*symptr);

  return enif_make_atom(env,ATOM_OK);
}

static ERL_NIF_TERM arg_string(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) {
  GET_VM;
  MAYBE_RET_BAD_STRING_ARG(arg,1,MAX_STRING_ARG_SZ,ATOM_INVALID_ARG)

  dcArgPointer(*vmptr,arg);
  return enif_make_atom(env,ATOM_OK);
}

static ERL_NIF_TERM call_string(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) {
  GET_VM;

  void** symptr;
  if(!enif_get_resource(env, argv[1], g_ptrrestype, (void**)&symptr)) RETURN_ERROR(ATOM_INVALID_ARG)
  if(!*symptr) RETURN_ERROR(ATOM_INVALID_SYMBOL)

  DCpointer ret = dcCallPointer(*vmptr,*symptr);

  return enif_make_tuple2(env,
			  enif_make_atom(env,ATOM_OK),
			  enif_make_string(env,(char*)ret, ERL_NIF_LATIN1)
			  );
}

static ErlNifFunc nif_funcs[] = {
  {"new_call_vm", 1, new_call_vm},
  {"load_library", 1, load_library},
  {"find_symbol", 2, find_symbol},
  {"arg_double", 2, arg_double},
  {"call_double", 2, call_double},
  {"arg_float", 2, arg_float},
  {"call_float", 2, call_float},
  {"arg_int", 2, arg_int},
  {"call_int", 2, call_int},
  {"arg_char", 2, arg_char},
  {"call_char", 2, call_char},
  {"arg_bool", 2, arg_bool},
  {"call_bool", 2, call_bool},
  {"arg_short", 2, arg_short},
  {"call_short", 2, call_short},
  {"arg_long", 2, arg_long},
  {"call_long", 2, call_long},
  {"arg_longlong", 2, arg_longlong},
  {"call_longlong", 2, call_longlong},
  {"arg_ptr", 2, arg_ptr},
  {"call_ptr", 2, call_ptr},
  {"call_void", 2, call_void},
  {"arg_string", 2, arg_string},
  {"call_string", 2, call_string}
};

ERL_NIF_INIT(dyncall,nif_funcs,&nifload,NULL,NULL,NULL)
