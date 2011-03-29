The package contains a mix of different demos, where some demos
need additional libraries and run-time modules.
See overview for a list of available demos, and Installation for
additional information related to OS-specific issues.

OVERVIEW
========

It follows a short overview:

  Interaction with R shared library:

    R_ShowMessage:
    Dynamically calls the C function 'R_ShowMessage'.

    R_malloc:
    Low-level allocation of Memory and freeing via finalizers.

  Foreign Function Calls to Standard C libraries:

    'sqrt':
    Call sqrt(144) using C math library function.

    'stdio':
    Using C Standard I/O functions via FFI.

  Multimedia Demos using Dynports for SDL and OpenGL:

    'blink':
    Skeleton for an R application mainloop.

    'SDL':
    Spinning color-cube.

    'randomfield':
    Real-time Random fields generator(1024x1024) using fast texture mapping 
    and blending. Procudes 1024x1024 matrices with 5000 gaussian blends.
    Via click, transmitted from GL to R and plotted in R device.
    Renders up to 100 matrices per second with common graphics hardware.

    'blink_gl3':
    Skeleton using modern OpenGL 3 API. (which might not work on old systems).

  Callback Demos:

    'callbacks':
    Wraps R functions into Callbacks and get called via dyncall FFI.
    Callbacks are recursively invoked via dyncall functions.

    'expat':
    XML Parser via expat using Callbacks.

INSTALLATION
============

Some notes on installation of additional run-time libraries
required for some rdyncall demos:

  libSDL  Multimedia Framework,   http://libsdl.org 
  OpenGL  3D Real-Time Graphics,  http://OpenGL.org, http://www.mesa3d.org
  Expat   XML Parser,		  http://expat.sourceforge.org

Place the *.DLL, *.so and *.dylib files in a standard location or
modify LD_LIBRARY_PATH(unix) or PATH(windows) so that the package
can find the libraries.

Installation Notes for Windows:

  32-bit:
    Download Run-time from http://www.libsdl.org/release/SDL-1.2.14-win32.zip
    Unpack and copy sdl.dll to a local directory.
    Make sure, local directory is in your PATH variable.

  No Installation needed for pre-installed software (part of OS Installation):
    Standard C Run-Time: named MSVCRT.dll

Installation Notes for Mac OS X:
    
  Downloads:
    libSDL: http://www.libsdl.org/release/SDL-1.2.14.dmg
  
  No Installation needed for pre-installed software (part of Mac OS X):
    Standard C Run-Time: located /usr/lib/libc.dylib
    Expat: located at /usr/lib/libexpat.dylib
    OpenGL: located at /System/Library/Frameworks/OpenGL.framework/OpenGL
 
Installation Notes for Unix Flavour:
   
   Debian:
     Install via apt-get install ...

     Recommended packages:
        libsdl1.2debian-<NAME>  with NAME = alsa,all,esd,arts,oss,nas or pulseaudio (depending on your sound system)
	libgl1-mesa-glx 	OpenGL for X11 run-time
	libgl1-mesa-dri		OpenGL Accelaration
	libglu1-mesa 		OpenGL Utility run-time
	libexpat1		Expat XML run-time library
     
