rdyncall R package - Improved Foreign Function Interface (FFI) and Dynamic Bindings to C Libraries (e.g. OpenGL) 

What is this?
-------------

rdyncall offers a stack of interoperability technologies for working
with foreign compiled languages using cross-platform portable abstraction
methods. 

For R application development, the package facilitates direct access from R
to the C Application Programming Interface (API) of common libraries.
This enables a new style of development: R applications can use
low-level services of portable C libraries. 
System-level code can be implemented in R without leaving the language.
C APIs can be explored from within the R interpreter.
Moving the R code from one platform to the other does not involve
recompilation.
Ofcourse, the run-time libraries need to be installed using a standard
procedure of the target Operating-System Distribution. 
See ?'rdyncall-demos' (in R) for details on this.

For R core development and research, the package provides an improved Foreign 
Function Interface (FFI) that can be used to call foreign precompiled C code 
without the need for additional compilation of wrapper code.
The interface has basic mechanisms included for type-safety checks for
argument types and supports working with pointers, arrays, structs and unions.
R functions can be wrapped into first-level C callback function pointers.


Supported Platforms:
--------------------

This package implements fundamental low-level services such as foreign
function interfaces, foreign callbacks and handling of foreign data structures.
It relies on libraries from the DynCall Project (http://dyncall.org) which
implement a certain amount of code in Assembly for each supported platform.
As of version 0.6, the following processor architectures are supported:

- Intel i386 32-bit and AMD 64-bit Platforms
- PowerPC 32-bit 
- ARM 32-bit (with support for Thumb)
- MIPS 32- and 64-bit (support for callbacks not yet implemented)

The DynCall libraries are tested on Linux, Mac OS X, Windows, BSD derivates
and more exotic platforms such as game consoles and Plan9.

The R Package has been tested on several major R platforms.

As of this release, no support for callbacks is available on MIPS.
Callbacks on PowerPC 32-bit are considered unstable.
Currently there is no support for SPARC platforms so far.


Building R package from subversion source tree
----------------------------------------------

1. install R package source from subversion

  $ svn co http://dyncall.org/svn/dyncall/trunk/bindings/R/rdyncall


2. install dyncall sources under rdyncall/src

  $ ( cd rdyncall ; sh ./bootstrap )


3. build & install it

  $ R CMD INSTALL rdyncall

