-module(linkload_SUITE).
-compile(export_all).

-define(VMSZ, 1024).

all() ->
    [create_vm,
     create_vm_badsz,
     load_lib,
     no_such_lib,
     bad_lib,
     bad_sym,
     bad_sym_2,
     load_sym
    ].

create_vm(_) ->
    {ok,Vm} = dyncall:new_call_vm(?VMSZ),
    true = is_binary(Vm).

create_vm_badsz(_) ->
    {error,bad_vm_size} = dyncall:new_call_vm("Hello badarg").

load_lib(_) ->
    {ok,Lib} = dyncall:load_library("libm"),
    true = is_binary(Lib).
    
no_such_lib(_) ->
    {error,lib_not_found} = dyncall:load_library("foobarbaz").

bad_lib(_) ->
    {error,invalid_lib} = dyncall:load_library(12).

bad_sym(_) ->
    {ok,Lib} = dyncall:load_library("libm"),
    {error,symbol_not_found} = dyncall:find_symbol(Lib,"bogussymbol").
    
bad_sym_2(_) ->
    {ok,Lib} = dyncall:load_library("libm"),
    {error,invalid_symbol} = dyncall:find_symbol(Lib,9).
    
load_sym(_) ->
    {ok,Lib} = dyncall:load_library("libm"),
    {ok,_Partner} = dyncall:find_symbol(Lib,"sqrt").
    
    
	
