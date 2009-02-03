TASKS:
- R package manual pages
- vignette package
- complete SDL bindings
EXPLORE:
- Fortran calling conventions
- dynbind resolving library path by libname ; Mac OS X 
BUGS:
- library live time management:
- character encoding support, R supports UTF-8.
FIXES:
- void return function calls should not display on R console (interactively) .. hidden
- Mac OS X objective-c cocoa support C code (src/support_cocoa.m)
  conditional compilation ONLY on Mac OS X / Darwin  
FUTURE:
- dynports: privacy e.g. see rmalloc
- callbacks
- C++ proxies
- rdyncall options
- zip file download
DONE:
- 'R' R expression pointer type


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
  

