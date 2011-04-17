\name{rdyncall-demos}
\alias{rdyncall-demos}
\title{rdyncall demos: Platform installation notes for required libraries}
\description{
The demos of the \pkg{rdyncall} package (see \code{demo(package="rdyncall")})
use shared libraries such as SDL, OpenGL and Expat via \code{\link{dynport}}s -
a dynamic binding approach which requires, that prebuilt binary shared library
files are already installed.

Depending on the host system, some libraries are officially a part of the
OS or Distribution, some others need to be installed to get the demos running.

As of the current version of this package, the installation of addtional
shared C libraries need to be done manually. It follows an overview of 
the required libraries and installation notes for various operating-systems and distributions.
}
\section{Overview of Libraries}{
The following Libraries are used as 'run-time' pre-compiled binaries
for the particular target OS and Hardware platform.
Some notes on installation of additional run-time libraries
required for some rdyncall demos:

\tabular{lll}{
\code{SDL} \tab Multimedia Framework \tab \url{http://libsdl.org} \cr
\code{GL} \tab Open Graphics Library \tab \url{http://OpenGL.org}, \url{http://www.mesa3d.org} \cr
\code{GLU} \tab OpenGL Utility Library \tab \cr
\code{Expat} \tab XML Parser \tab \url{http://www.libexpat.org} \cr
\code{SDL_mixer} \tab Music Format playing \tab \url{http://www.libsdl.org/projects/SDL_mixer} \cr
\code{SDL_image} \tab Image Format loading \tab \url{http://www.libsdl.org/projects/SDL_image}  \cr
\code{SDL_ttf}  \tab True Type Font rendering \tab \url{http://www.libsdl.org/projects/SDL_ttf} \cr
}

In short: Place the shared libraries ( \code{*.DLL}, \code{*.so} or \code{*.dylib}) in a \emph{standard location} or
modify LD_LIBRARY_PATH(unix) or PATH(windows) so that \code{\link{dynfind}} can find the libraries. 

On Mac OS X framework folders are supported as well.
Place the \code{*.framework} folder at \code{/Library/Frameworks}.

Detailed platform-specific installation instructions follow up. 
}
\section{Windows Installation Notes}{
Download the \code{*.zip} files, unpack them and place the \code{*.DLL} files to a place within \code{PATH}.

32-Bit Versions:

\tabular{ll}{
\code{SDL} \tab \url{http://www.libsdl.org/release/SDL-1.2.14-win32.zip} \cr
\code{GL} \tab already installed \cr
\code{GLU} \tab already installed \cr
\code{SDL_ttf} \tab \url{http://www.libsdl.org/projects/SDL_ttf/release/SDL_ttf-2.0.10-win32.zip} \cr
\code{SDL_mixer} \tab \url{http://www.libsdl.org/projects/SDL_mixer/release/SDL_mixer-1.2.11-win32.zip} \cr
\code{expat} \tab \url{http://expat.sourceforge.org} \cr
}

64-Bit Version:

\tabular{ll}{
\code{SDL} \tab \url{http://mamedev.org/tools/20100102/sdl-1.2.14-r5428-w64.zip} \cr
\code{GL} \tab already installed \cr
\code{GLU} \tab already installed \cr
\code{SDL_ttf} \tab no prebuilt found \cr
\code{SDL_mixer} \tab no prebuilt found \cr
\code{expat} \tab no prebuilt found \cr
}

The prebuilt SDL from \url{http://www.drangon.org/mingw} did not work (exiting with OpenGL errors).
If you know of other resources for prebuilt 64-bit packages
for SDL and expat, please report.
}
\section{Mac OS X Installation Notes}{
Download the \code{*.dmg} files, mount them (by double-click) and copy \code{*.framework} folders to \code{/Library/Frameworks}.
\tabular{ll}{
\code{SDL} \tab \url{http://www.libsdl.org/release/SDL-1.2.14.dmg} \cr
\code{GL} \tab already installed \cr
\code{GLU} \tab already installed \cr
\code{expat} \tab already installed \cr
\code{SDL_image} \tab \url{http://www.libsdl.org/projects/SDL_image/release/SDL_image-1.2.10.dmg} \cr
\code{SDL_mixer} \tab \url{http://www.libsdl.org/projects/SDL_mixer/release/SDL_mixer-1.2.11.dmg} \cr
\code{SDL_ttf} \tab \url{http://www.libsdl.org/projects/SDL_ttf/release/SDL_ttf-2.0.10.dmg} \cr
}
}
\section{Linux/Debian Installation Notes}{
 
Debian Package installation via aptitude

\preformatted{aptitude install <pkg-names>..}

\tabular{ll}{
\code{SDL} \tab \code{libsdl1.2debian} and \code{libsdl1.2debian-<SOUNDSYS>} \cr
\code{expat} \tab \code{libexpat1} \cr 
\code{GL} \tab \code{libgl1-mesa-glx} and \code{libgl1-mesa-dri} \cr
\code{GLU} \tab \code{libglu1-mesa} \cr
\code{expat} \tab already installed (?) \cr
}
SOUNDSYS is one of the following: alsa,all,esd,arts,oss,nas or pulseaudio (depending on your sound system)
Tested with Debian 5 and 6 (lenny and squeeze).
}
\section{Linux/Fedora Installation Notes}{
\preformatted{pkcon install <pkgname>..}
\tabular{lll}{
\code{SDL} \tab \code{SDL} \tab 1.2 \cr  
\code{GL} \tab \code{mesa-libGL} \tab 7.9-2 \cr
\code{GLU} \tab \code{mesa-libGLU} \tab 7.9-2 \cr
\code{Expat} \tab \code{expat} \tab 1.5.2 \cr
}
Tested with Fedora 13.
}
\section{NetBSD Installation Notes}{

Installation via pkgsrc:

\preformatted{pkg_add <pkgname>..}

\tabular{ll}{
\code{SDL} \tab \code{SDL} \cr
\code{expat} \tab \code{expat} \cr
}
}
\section{OpenBSD Installation Notes}{
Using packages:

\preformatted{pkg_add <pkgname>..}

\tabular{ll}{
\code{SDL} \tab \code{SDL} \cr
\code{expat} \tab \code{expat} \cr
}

The SDL dynport failed on OpenBSD 4.8 - so no multimedia demos here - using the R 2.7 from the ports tree.
This must have been something to do with pthread discrepancies between SDL and R.
}
\section{FreeBSD Installation Notes}{
Using packages:

\preformatted{pkg_add -r <pkgname>..}

\tabular{ll}{
\code{GL} \tab \code{xorg} \cr
}

.. to be continued ..
}

