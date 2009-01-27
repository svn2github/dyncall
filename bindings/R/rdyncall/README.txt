Package: rdyncall

Components:

- dyncall API

  ".dyncall()" and ".dyncall.<callconv>()"
  
  with support for calling conventions:
  
  ".dyncall.cdecl"
  ".dyncall.stdcall"
  ".dyncall.fastcall.msvc"
  ".dyncall.fastcall.gcc"
  
- dynbind
  binding automation using signature strings for function imports.

  e.g.:
    dynbind("opengl32", "glClear(i)v;", CALLMODE="stdcall")
    dynbind("c", "sqrt(d)d;")

- dynport 
  a repository of multi-platform dynamic ports to 
  precompiled R, system and add-on libraries.

  e.g.:
    dynport("gl")
    
  planed ports: 
    Rmalloc
    sdl
    opengl
    glu
    glut
    curl
    openal    

Open issues:

- finding/loading of dynamic libraries in R
   dyn.load or dynload library ? (rdcLoad/rdcUnload)

- dynport namespace management

    
Interface design issues:

1. R provides a dynamic library load and lookup mechanism.
   dyn.load, getNativeSymbolInfo, dyn.unload
   
2. We support two variants: "cdecl" and "stdcall" on windows with a
   default implementation as "cdecl" on non-windows platforms.

dynport open issues:

  - load dynamic packages into virtual package namespaces and
    unload

  - DLL entry and exit control?
  

