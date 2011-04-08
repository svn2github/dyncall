\name{dynload}
\alias{.dynload}
\alias{.dynunload}
\alias{.dynsym}
\title{Loading of shared libraries and resolving of symbols (Alternative Framework).}
\description{An alternative framework for loading of shared libraries and resolving of symbols.
The framework offers \emph{automatic unload management} of loaded shared libraries and
provides a direct interface to the dynamic linker of the underlying Operating-System.
Resolved symbols reference opened libraries and protect them from garbage collection.
When library handles are no longer needed (and garbage collected), handle finalizers unload the library from the R process.
}
\usage{
.dynload(libname, auto.unload=TRUE)
.dynsym(libhandle, symname, protect.lib=TRUE)
.dynunload(libhandle)
}
\arguments{
  \item{libname}{character string giving the pathname to a shared library - passed and interpreted directly by the OS loader.}
  \item{libhandle}{external pointer representing a handle to an opened library.}
  \item{symname}{character string specifying the symbolic name to lookup.}
  \item{auto.unload}{logical, if \code{TRUE} a finalizer will be registered that will automatically unload the library.}
  \item{protect.lib}{logical, if \code{TRUE} the external pointer representing the resolved address references the libhandle object and protects library auto unloading as long as the external pointer is alive.}
}
\value{
\code{.dynload} returns an external pointer \code{libhandle} on success. Otherwise NULL is returned, if the library is not found or the linkage failed.
\code{.dynsym} returns an external pointer \code{address} on success. Otherwise NULL is returned, if the address was invalid or the symbol has not been found.
\code{.dynunload} always returns \code{NULL}.    
}
\details{
The function \code{.dynload} attempts to load a library given by \code{libname}
that specifies the location in an OS-specific way. 

If successfull, it loads the library to the run-time process and returns a library handle (external pointer)
that can be used later with \code{.dynsym} and \code{.dynunload}. 
Otherwise \code{NULL} is returned. Function pointers can be resolved using 
\code{.dynsym} to look up a symbol given by the symbolic name \code{symname}. 

Although the same core functionality is available using the R base package functions \code{dyn.load} and \code{getNativeSymbolInfo}, 
this framework features an improved life-cycle management and uses the lookup semantics
of the underlying operating-system:

If both, \code{auto.unload} and \code{protect.lib},  are set to \code{TRUE} (default),
the external pointer objects, representing resolved symbolic addresses returned by \code{.dynsym} , protect the library handle returned from \code{dyn.load}.
A finalizer for the library is then called, when no resolved addresses (stored in external pointers protecting its library handle) are active.

}

\section{Portability}{
The implementation is based on the \emph{dynload} library (part of the DynCall project) which has been ported
to all major R platforms (ELF (Linux,BSD,Solaris), Mach-O (Mac OS X) and Portable Executable (Win32/64)). 
}
\section{Shared library}{

Shared libraries are single files that contain compiled code, data and meta-information.
The code and data can be loaded and mapped to a process at run-time once.
Operating system platforms have slightly different schemes for naming, 
searching and linking options.

\tabular{lll}{
\strong{Platform}                      \tab \strong{Binary format}   \tab \strong{File Extension} \cr
Linux, BSD derivates and Sun Solaris   \tab ELF format               \tab \code{so}          \cr
Darwin / Apple Mac OS X                \tab Mach-O format            \tab \code{dylib}       \cr
Microsoft Windows                      \tab PE format                \tab \code{dll}         \cr
}

}

\section{Library search on Posix platforms (Linux,BSD,Sun Solaris)}{  

The following text is taken from the Linux \code{dlopen} manual page:

These search rules will only be applied to path names that do not contain an embedded '/'. 
\itemize{    
\item If the \code{LD_LIBRARY_PATH} environment variable is defined to contain a colon-separated list of
directories, then these are searched.

\item The cache file \code{/etc/ld.so.cache} is checked to see whether it contains an entry for filename.

\item The directories \code{/lib} and \code{/usr/lib} are searched (in that order).
}  
If the library has dependencies on other shared libraries, then these are also automatically 
loaded by the dynamic linker using the same rules.  
}
\section{Library search on Darwin (Mac OS X) platforms}{

The following text is taken from the Mac OS X dlopen manual page:

dlopen() searches for a compatible Mach-O file in the directories specified by a set of environment
 variables and the process's current working directory.  When set, the environment variables must contain 
 a colon-separated list of directory paths, which can be absolute or relative to the current working
 directory. The environment variables are LD_LIBRARY_PATH, DYLD_LIBRARY_PATH, and DYLD_FALLBACK_LIBRARY_PATH. 
 The first two variables have no default value. The default value of DYLD_FALLBACK_LIBRARY_PATH
  is \$HOME/lib;/usr/local/lib;/usr/lib.  dlopen() searches the directories specified in
 the environment variables in the order they are listed.

     When path doesn't contain a slash character (i.e. it is just a leaf name), dlopen() searches the fol-lowing following
     lowing the following until it finds a compatible Mach-O file: \$LD_LIBRARY_PATH, \$DYLD_LIBRARY_PATH,
     current working directory, \$DYLD_FALLBACK_LIBRARY_PATH.

     When path contains a slash (i.e. a full path or a partial path) dlopen() searches the following the
     following until it finds a compatible Mach-O file: \$DYLD_LIBRARY_PATH (with leaf name from path ), cur-rent current
     rent working directory (for partial paths), \$DYLD_FALLBACK_LIBRARY_PATH (with leaf name from path ).
}
\section{Library search on Microsoft Windows platforms}{

The following text is taken from the Window SDK Documentation:

If no file name extension is specified [...], the default library extension 
\code{.dll} is appended. However, the file name string can include a trailing point character (.) to 
indicate that the [shared library] module name has no extension. When no path is specified, the function searches 
for loaded modules whose base name matches the base name of the module to be loaded. 
If the name matches, the load succeeds. Otherwise, the function searches for the file in the 
following sequence:

\itemize{

\item The directory from which the application loaded. 
\item The current directory. 
\item The system directory. Use the GetSystemDirectory Win32 API function to get the path of this directory.
\item The 16-bit system directory. There is no function that obtains the path of this directory, but it is searched. Windows Me/98/95:  This directory does not exist.
\item The Windows directory. Use the GetWindowsDirectory Win32 API function to get the path of this directory. 
\item The directories that are listed in the PATH environment variable. 
}

Windows Server 2003, Windows XP SP1:  The default value of \code{HKLM\\System\\CurrentControlSet\\Control\\Session Manager\\SafeDllSearchMode} is 1 (current directory is searched after the system and Windows directories).

Windows XP:  If \code{HKLM\\System\\CurrentControlSet\\Control\\Session Manager\\SafeDllSearchMode} is 1, the current directory is searched after the system and Windows directories, but before the directories in the PATH environment variable. The default value is 0 (current directory is searched before the system and Windows directories).


The first directory searched is the one directory containing the image file used to create the calling process. Doing this allows private dynamic-link library (DLL) files associated with a process to be found without adding the process's installed directory to the PATH environment variable.

The search path can be altered using the \code{SetDllDirectory} function. This solution is recommended instead of using \code{SetCurrentDirectory} or hard-coding the full path to the DLL.

If a path is specified and there is a redirection file for the application, the function searches for the module in the application's directory. If the module exists in the application's directory, the LoadLibrary function ignores the specified path and loads the module from the application's directory. If the module does not exist in the application's directory, LoadLibrary loads the module from the specified directory. For more information, see Dynamic Link Library Redirection from the Windows SDK Documentation.
}
\seealso{
  This facility is used by \code{\link{dynfind}} and \code{\link{dynbind}}.
  Similar functionality is available from \code{\link{dyn.load}} and \code{\link{getNativeSymbolInfo}}.
}
\keyword{programming}
\keyword{interface}
