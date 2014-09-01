-module(dyncall).

-export([ 
          mode/2,
          get_error/1,
          reset/1,
          load_library/1,
	  find_symbol/2,
	  new_call_vm/1,
	  arg_double/2,
	  call_double/2,
	  arg_float/2,
	  call_float/2,
	  arg_int/2,
	  call_int/2,
	  arg_char/2,
	  call_char/2,
	  arg_bool/2,
	  call_bool/2,
	  arg_short/2,
	  call_short/2,
	  arg_long/2,
	  call_long/2,
	  arg_longlong/2,
	  call_longlong/2,
	  arg_ptr/2,
	  call_ptr/2,
	  call_void/2,
	  arg_string/2,
	  call_string/2
	]).

-on_load(load_nif/0).

load_nif() ->
    Dir = case code:priv_dir(dyncall) of
	      {error, bad_name} ->
		  filename:dirname(code:which(?MODULE)) ++ "/../priv";
	              OtherDir -> OtherDir
    end,
    erlang:load_nif(Dir ++ "/erldc", 0).

-spec load_library(LibPath :: string()) -> {ok,Lib :: pos_integer()} | {error,_Reason}.
load_library(_LibPath) ->
    {error,"NIF library not loaded"}.

-spec find_symbol(Lib :: pos_integer(), SymName :: string()) -> {ok,Sym :: pos_integer()} | {error,_Reason}.
find_symbol(_Lib, _SymName) ->
    {error,"NIF library not loaded"}.

-spec new_call_vm(Size :: pos_integer()) -> {ok,Vm :: pos_integer()} | {error,_Reason}.
new_call_vm(_Size) ->
    {error,"NIF library not loaded"}.

-spec arg_double(Vm :: pos_integer(), Double :: float()) -> ok | {error, _Reason}.
arg_double(_Vm, _Double) ->
    {error,"NIF library not loaded"}.

-spec call_double(Vm :: pos_integer(), Sym :: pos_integer()) -> {ok, Result :: float()} | {error, _Reason}.
call_double(_Vm, _Sym) ->
    {error,"NIF library not loaded"}.

-spec arg_float(Vm :: pos_integer(), Float :: float()) -> ok | {error, _Reason}.
arg_float(_Vm, _Float) ->
    {error,"NIF library not loaded"}.

-spec call_float(Vm :: pos_integer(), Sym :: pos_integer()) -> {ok, Result :: float()} | {error, _Reason}.
call_float(_Vm, _Sym) ->
    {error,"NIF library not loaded"}.

-spec arg_int(Vm :: pos_integer(), Int :: integer()) -> ok | {error, _Reason}.
arg_int(_Vm, _Int) ->
    {error,"NIF library not loaded"}.

-spec call_int(Vm :: pos_integer(), Sym :: pos_integer()) -> {ok, Result :: integer()} | {error, _Reason}.
call_int(_Vm, _Sym) ->
    {error,"NIF library not loaded"}.

-spec arg_char(Vm :: pos_integer(), Char :: char()) -> ok | {error, _Reason}.
arg_char(_Vm, _Char) ->
    {error,"NIF library not loaded"}.

-spec call_char(Vm :: pos_integer(), Sym :: pos_integer()) -> {ok, Result :: char()} | {error, _Reason}.
call_char(_Vm, _Sym) ->
    {error,"NIF library not loaded"}.

-spec arg_bool(Vm :: pos_integer(), Bool :: boolean()) -> ok | {error, _Reason}.
arg_bool(_Vm, _Bool) ->
    {error,"NIF library not loaded"}.

-spec call_bool(Vm :: pos_integer(), Sym :: pos_integer()) -> {ok, Result :: boolean()} | {error, _Reason}.
call_bool(_Vm, _Sym) ->
    {error,"NIF library not loaded"}.

-spec arg_short(Vm :: pos_integer(), Short :: integer()) -> ok | {error, _Reason}.
arg_short(_Vm, _Short) ->
    {error,"NIF library not loaded"}.

-spec call_short(Vm :: pos_integer(), Sym :: pos_integer()) -> {ok, Result :: integer()} | {error, _Reason}.
call_short(_Vm, _Sym) ->
    {error,"NIF library not loaded"}.

-spec arg_long(Vm :: pos_integer(), Long :: integer()) -> ok | {error, _Reason}.
arg_long(_Vm, _Long) ->
    {error,"NIF library not loaded"}.

-spec call_long(Vm :: pos_integer(), Sym :: pos_integer()) -> {ok, Result :: integer()} | {error, _Reason}.
call_long(_Vm, _Sym) ->
    {error,"NIF library not loaded"}.

-spec arg_longlong(Vm :: pos_integer(), Longlong :: integer()) -> ok | {error, _Reason}.
arg_longlong(_Vm, _Longlong) ->
    {error,"NIF library not loaded"}.

-spec call_longlong(Vm :: pos_integer(), Sym :: pos_integer()) -> {ok, Result :: integer()} | {error, _Reason}.
call_longlong(_Vm, _Sym) ->
    {error,"NIF library not loaded"}.


-spec arg_ptr(Vm :: pos_integer(), Ptr :: binary()) -> ok | {error, _Reason}.
arg_ptr(_Vm, _Ptr) ->
    {error,"NIF library not loaded"}.

-spec call_ptr(Vm :: pos_integer(), Sym :: pos_integer()) -> {ok, Result :: binary()} | {error, _Reason}.
call_ptr(_Vm, _Sym) ->
    {error,"NIF library not loaded"}.

-spec call_void(Vm :: pos_integer(), Sym :: pos_integer()) -> ok | {error, _Reason}.
call_void(_Vm, _Sym) ->
    {error,"NIF library not loaded"}.

-spec arg_string(Vm :: pos_integer(), String :: string()) -> ok | {error, _Reason}.
arg_string(_Vm, _String) ->
    {error,"NIF library not loaded"}.

-spec call_string(Vm :: pos_integer(), Sym :: pos_integer()) -> {ok, Result :: string()} | {error, _Reason}.
call_string(_Vm, _Sym) ->
    {error,"NIF library not loaded"}.

-spec mode(Vm :: pos_integer(), Mode :: pos_integer()) -> ok | {error, _Reason}.
mode(_Vm, _Mode) ->
    {error,"NIF library not loaded"}.

-spec get_error(Vm :: pos_integer()) -> {ok, ErrorCode :: pos_integer()} | {error, _Reason}.
get_error(_Vm) ->
    {error,"NIF library not loaded"}.

-spec reset(Vm :: pos_integer()) -> ok | {error, _Reason}.
reset(_Vm) ->
    {error,"NIF library not loaded"}.


