
This document contains details about demos of 'rdyncall' and OS-specific 
installation instructions for several library run-time's such as
SDL, OpenGL and Expat.

--- Available Demos -----------------------------------------------------------

Working with the R shared C library:
  'R_ShowMessage': Dynamically calls the C function 'R_ShowMessage'.
  'R_malloc':      Low-level allocation of Memory and freeing via finalizers.

Working with the Standard C library:
  'sqrt':  Call sqrt(144) using C math library function.
  'stdio': Using C Standard I/O functions via FFI.

Multimedia with SDL and GL:
  'blink':        Skeleton for an R application mainloop.
  'SDL':          Spinning color-cube.
  'randomfield':  Real-time Random fields generator(1024x1024) using fast texture mapping and blending. Procudes 1024x1024 matrices with 5000 gaussian blends.
  'blink_gl3':    Skeleton using modern OpenGL 3 API. (which might not work on old systems).
  'ttf':          Requires as well SDL_ttf (http://www.libsdl.org/projects/SDL_ttf/)

Callback Demos:
  'callbacks': Wraps R functions into Callbacks and get called via dyncall FFI. Callbacks are recursively invoked via dyncall functions.
  'expat':     XML Parser via expat using Callbacks.


--- GETTING STARTED -----------------------------------------------------------

1. Install additional Library Run-Time Components such as 'SDL' and 'Expat'.

   Follow install check-list instructions in this document for particular OS.

  
2. Start R & load 'rdyncall' Package:

   $ R
   > library(rdyncall)


3. Run SDL/OpenGL Demo 'SDL'

   > demo(SDL)


--- INSTALLATION --------------------------------------------------------------

The following Libraries are used as 'run-time' pre-compiled binaries
for the particular target OS and Hardware platform.
Some notes on installation of additional run-time libraries
required for some rdyncall demos:

  libSDL    Multimedia Framework    http://libsdl.org 
  OpenGL    3D Real-Time Graphics   http://OpenGL.org, http://www.mesa3d.org
  Expat     XML Parser              http://expat.sourceforge.org
  SDL_ttf   Fonts                   http://libsdl.org/projects/SDL_ttf
  SDL_mixer Mixer                   http://libsdl.org/projects/SDL_mixer

Place the *.DLL, *.so and *.dylib files in a standard location or
modify LD_LIBRARY_PATH(unix) or PATH(windows) so that the package
can find the libraries.

--- Windows Installation Notes ------------------------------------------------

Download, unpack. Make sure *.DLL files are in PATH.

Downloads:

  32-Bit:  
  -------
  SDL       http://www.libsdl.org/release/SDL-1.2.14-win32.zip
  SDL_ttf   http://www.libsdl.org/projects/SDL_ttf/release/SDL_ttf-2.0.10-win32.zip
  SDL_mixer http://www.libsdl.org/projects/SDL_mixer/release/SDL_mixer-1.2.11-win32.zip
  expat     http://expat.sourceforge.org

  No Installation needed for pre-installed software (part of OS Installation):
  
  Standard C Run-Time is at %WINDIR%/system32/MSVCRT.DLL


  64-Bit:
  -------
  SDL       http://mamedev.org/tools/20100102/sdl-1.2.14-r5428-w64.zip
  
  Note: The prebuilt SDL from http://www.drangon.org/mingw did not work,
        exiting with OpenGL errors.
        If you know of other resources for prebuilt 64-bit packages
        for SDL and expat, please report.

--- Mac OS X Installation Notes -----------------------------------------------
    
Downloads:
  libSDL: http://www.libsdl.org/release/SDL-1.2.14.dmg
  
  No Installation needed for pre-installed software (checked on Mac OS X 10.{4,6})
    Standard C Run-Time: located /usr/lib/libc.dylib
    Expat: located at /usr/lib/libexpat.dylib
    OpenGL: located at /System/Library/Frameworks/OpenGL.framework/OpenGL
 
   
--- Debian Installation Notes -------------------------------------------------

Usage

  Install via apt-get install ...

Recommended Debian Packages:

  Name                    Description

  libsdl1.2debian         common SDL documentation
  libsdl1.2debian-<NAME>  with NAME = alsa,all,esd,arts,oss,nas or pulseaudio (depending on your sound system)
  libexpat1		  Expat XML run-time library
  libgl1-mesa-glx 	  OpenGL for X11 run-time
  libgl1-mesa-dri	  OpenGL Accelaration
  libglu1-mesa 		  OpenGL Utility run-time
   
  Verified installation on Version 5 and 6.


--- NetBSD pkgsrc -------------------------------------------------------------

Usage
  $ pkg_add -v <pkgname> <pkgname>..
      
  Recommended pkgsrc Packages:

  Name      Version   Location

  SDL       1.2       /usr/pkg/lib/libSDL.so
  expat     2.0.1     /usr/pkg/lib/libexpat.so

  Verified on Version 5.1.  

--- FreeBSD packages ----------------------------------------------------------

Usage
  $ pkg_add -r <pkgname> <pkgname>..

  Recommended Packages:

  xorg
  
  .. to be continued ..  

--- Fedora RPMs ---------------------------------------------------------------

Usage
  pkcon install ...

  SDL                 1.2       /usr/lib/libSDL-1.2.so.0
  mesa-libGL          7.9-2
  mesa-libGLU         7.9-2

Pre-installed:
  expat               1.5.2     /lib/libexpat.so.1.5.2
  c                             /lib/libc.so.6


