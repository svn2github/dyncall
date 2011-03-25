rdyncall R package 
- A Foreign Library Interface for R 
(C) 2007-2011, Daniel Adler <dadler@uni-goettingen.de>


What is this?
-------------

This package implements middleware interoperability services for R that
enables to interact with precompiled code.

At the core of the package, an improved foreign function interface for
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

- Intel 32- and AMD 64-bit Platforms
- PowerPC 32-bit 
- ARM 32-bit
- MIPS 32- and 64-bit (support for callbacks are not implemented)

The DynCall libraries are tested on Linux, Mac OS X, Windows, BSD derivates
and more exotic platforms such as game consoles and Plan9.

The R Package has been tested on several major R platforms.

As of this release, no support for callbacks is available on MIPS.
Callbacks on PowerPC 32-bit are considered unstable.
Currently there is no support for SPARC platforms so far.


Demos
-----

The package contains several demos. Some of them run out-of-the-box,
others need additional libraries:

  Demos that should run out-of-the-box: 
    R_ShowMessage, R_malloc, sqrt, stdio, callbacks
  
  Demos that need libSDL and OpenGL >= 1.1: 
    SDL, blink, randomfield
  
  Demos that need OpenGL >= 3 API: 
    blink_gl3
  
  Demos that need Expat:
    expat

  Demos that run on Windows only:
    Win32PlaySound

  Demos that need SDL_ttf as well:
    ttf


To get an idea of what rdyncall can offer to developers, 
install the SDL libraries and run

>  demo(SDL)

which shows an OpenGL/SDL 3D demo.


Installation of additional shared libraries
-------------------------------------------

  OpenGL: preinstalled or use MesaGL (http://www.mesa3d.org/)
  SDL:    Downloads are available at http://www.libsdl.org/
  Expat:  Downloads are available at http://expat.sourceforge.net/

Place the *.DLL, *.so and *.dylib files in a standard location or
modify LD_LIBRARY_PATH(unix) or PATH(windows) so that the package
can find the libraries.


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
    (e.g. http://dyncall.org/r0.6/dyncall-0.6.tar.gz


Tested Platforms:
-----------------

Debian 6.0/x64: ok.
Mac OS X 10.4/ppc R-2.10.0: ok.
Mac OS X 10.6/{i386,x64} R-2.12.2: ok.
Windows XP/x86 R-2.12.2: ok.
Windows XP/x64 R-2.12.2: sqrt ok - others fail.
OpenBSD 4.8/x64: SDL demos fail (SDL to pthread dependency fails).

