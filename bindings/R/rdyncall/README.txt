rdyncall R package - Dynamic Bridge to Foreign C Libraries for R 
(C) 2007-2011, Daniel Adler <dadler@uni-goettingen.de>


What is this?
-------------

'rdyncall' is a toolkit that provides R developers a stack of 
interoperability technologies to low-level machine code.

For R application development, the package provides type-safe 
system-level access to C libraries such as OpenGL, SDL and Expat 
cross-platform.
With rdyncall, R borrows capabilities of a system-level programming language.

'rdyncall' enables to develope R multimedia applications that run across platforms.

For R core development, the package provides a new Foreign Function Interface
that can be used to call foreign precompiled C code without the need for
additional compilation of wrapper code but which are more type-safe than
R's built-ins.

'rdyncall' provides an improved foreign function interface for R as
an alternative to .C, .Call, .External.

 middleware interoperability services for R 
that enables direct invocation to C library functions without
the need for additional C wrapper code.

At the core of the package, an improved FFI (foreign function interface) for
R is implemented, that enables direct and flexible interaction with 
precompiled code. See "? .dyncall" for details.

At a high-level the package implements a Foreign Library Interface for R 
designed to access whole C libraries as virtual R namespaces.
See "? dynport" for details.


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
  - run bootstrap 
    $ sh ./bootstrap 
  - or, check out dyncall sources from subversion
    $ cd rdyncall/src && svn co http://dyncall.org/svn/dyncall/trunk/dyncall
  - or, download dyncall sources from net 
    (e.g. http://dyncall.org/r0.7/dyncall-0.7.tar.gz (to-be-released)


Run some Demos
--------------

See README-Demo.txt for details.


Tested Platforms:
-----------------

FreeBSD 8.2/x86: ok.
Linux/Debian 5.0/x86: ok.
Linux/Debian 6.0/x64: ok.
Linux/Fedora 14/x86: ok.
Mac OS X 10.4/ppc R-2.10.0: ok.
Mac OS X 10.6/{i386,x64} R-2.12.2: ok.
NetBSD 5.0/x86: ok.
NetBSD 5.1/x64: ok, do pkg_add -v SDL expat.
OpenBSD 4.8/x64: SDL demos fail (SDL to pthread dependency fails).
Windows XP/x86 R-2.12.2: ok.
Windows XP/x64 R-2.12.2: ok, but beware of wrong pre-compiled SDL 64-bit pitfall - see README-Demo.txt).
FreeBSD 8.1/x86: ?
