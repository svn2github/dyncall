rdyncall R package - an improved foreign function interface for R using dyncall.

Dyncall C library is a portable and feature-rich foreign function interface.
Dynport Framework is a portable dynamic binding.


Building from checked out source of subversion repository

1. Run unix shell script 'bootstrap' .

   This will download dyncall library source package.
	 
   Requirements: 
   Command-line tools 'wget', 'unzip', 'mv', 'rm'   
   
   On Windows: 
   Make sure, command-line tools are available.
   Then use 'sh' from rtools or use other unix-like environment such as cygwin or mingw.
   
   
   

      

Developer notes: (till end of the file)

PLANED:
- dynport repo under revision control
- automatic installation of pre-built shared libraries
- (cross-) build server network (virtual building via DynOS / QEMU and friends)

Done:
- SDL Event demo for rdyncall's C structure support.

TODO:
- polish callback example (expat library)
- callbacks should fail with "not yet implemented" on platforms
- use raw vectors for 1-to-1 bit encoding of values e.g. raw(8) for (u)int64 values
- make dynfind locations configurable from extern

  e.g. - dynAddPath, dynRemovePath

- windows: test findLibPath 
- darwin: test findFrameworkPath 
- type-safe signatures

old style: pppp

new style: *<struct/union name>**i***p

special handling:

- expat callback: char** attribute map

	typedef void (*f)(void* userData, const XML_Char* name, const XML_Char** atts);
	
	vector of characters -> char** ?
	
	STRSXP a vector of characters
	
	"ppc.to.character" <- function(ptr)
	{
	  while(true) {
		  key   <- .unpack( .unpack(ptr, 0, "p"), 0, "Z" )
		  if (is.null(key))
		  {
		    break
		  }
		  value <- .unpack( .unpack(ptr, 0, "p"), 0, "Z" )
		  list[key] <- value
	  }
	}
	"ppc"
	as.character( offset(ptr, 0) ) # result "pc"
	



- R utilities 
	- pointer allocation
	- structure pack/unpack
	- float arrays and handling of Csingle attribute on double vectors
- character encoding support, R supports UTF-8.
- searching system dll's
- library live time management:
- namespace support
- signature character definition file and processing of headers, R code using the definition file
- Fortran binding 
TASKS:
- R package manual pages
- vignette package
- complete SDL bindings
EXPLORE:
- Fortran calling conventions
- dynbind resolving library path by libname ; Mac OS X 
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
  

TODO:
- ability to put dynport into a namespace ?
- R utility class: float arrays
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
  

