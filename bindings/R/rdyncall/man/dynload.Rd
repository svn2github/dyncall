\name{dynload}
\alias{.dynload}
\alias{.dynunload}
\alias{.dynfind}
\title{Low-level loading and unload of shared libraries}
\description{Low-level functions to load and unload shared libraries and to resolve symbols.}
\usage{
.dynload  (libname)
.dynfind  (libhandle,symname)
.dynunload(libhandle)
}
\arguments{
  \item{libname}{A character string specifying the library file in short, relative- or absolute-path form.}
  \item{libhandle}{An external pointer representing a handle to an open library.}
  \item{symname}{A character string specifying the symbolic name to lookup.}
}
\value{
\code{.dynload} returns an external pointer \code{libhandle} on success. Otherwise NULL is returned, if the library is not found or the linkage failed.
\code{.dynfind} returns an external pointer \code{address} on sucess. Otherwise NULL is returned, if the address was invalid or the symbol has not been found.
\code{.dynunload} always returns NULL.    
}
\details{
The function \code{.dynload} searches for a library specified by \code{libname}. 
It loads the library to the run-time process and returns its \code{libhandle} (library handle) 
as an external pointer.
Function pointers can be resolved using \code{.dynfind} to lookup a symbol given by \code{symname} 
in a library specified by \code{libhandle}. 
\code{.dynunload} can be used to unload a library from the run-time process.
}
\section{Shared library}{

Shared libraries are single files that contain compiled code, data and meta-information.
The code and data can be loaded and mapped to a process at run-time once.
Operating system platforms have slightly different schemes for naming, 
searching and linking options.

\tabular{lll}{
\strong{Platform}                      \tab \strong{Binary format}   \tab \strong{File Extension} \cr
Linux, BSD derivates and Sun Solaris   \tab ELF format               \tab \code{lib*.so}          \cr
Darwin / Apple Mac OS X                \tab Mach-O format            \tab \code{lib*.dylib}       \cr
Microsoft Windows                      \tab PE format                \tab \code{*.DLL}            \cr
}

}

\section{Library search on Posix platforms (Linux,BSD,Sun Solaris)}{  
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
dlopen() searches for a compatible Mach-O file in the directories specified by a set of environment
 variables and the process's current working directory.  When set, the environment variables must contain 
 a colon-separated list of directory paths, which can be absolute or relative to the current working
 directory. The environment variables are LD_LIBRARY_PATH, DYLD_LIBRARY_PATH, and DYLD_FALLBACK_LIBRARY_PATH. 
 The first two variables have no default value. The default value of DYLD_FALLBACK_LIBRARY_PATH
  is $HOME/lib;/usr/local/lib;/usr/lib.  dlopen() searches the directories specified in
 the environment variables in the order they are listed.

     When path doesn't contain a slash character (i.e. it is just a leaf name), dlopen() searches the fol-lowing following
     lowing the following until it finds a compatible Mach-O file: $LD_LIBRARY_PATH, $DYLD_LIBRARY_PATH,
     current working directory, $DYLD_FALLBACK_LIBRARY_PATH.

     When path contains a slash (i.e. a full path or a partial path) dlopen() searches the following the
     following until it finds a compatible Mach-O file: $DYLD_LIBRARY_PATH (with leaf name from path ), cur-rent current
     rent working directory (for partial paths), $DYLD_FALLBACK_LIBRARY_PATH (with leaf name from path ).
}
\section{Library search on Microsoft Windows platforms}{

If no file name extension is specified in the lpFileName parameter, the default library extension 
.dll is appended. However, the file name string can include a trailing point character (.) to 
indicate that the module name has no extension. When no path is specified, the function searches 
for loaded modules whose base name matches the base name of the module to be loaded. 
If the name matches, the load succeeds. Otherwise, the function searches for the file in the 
following sequence:

\itemize{

\item The directory from which the application loaded. 
\item The current directory. 
\item The system directory. Use the GetSystemDirectory function to get the path of this directory.
\item The 16-bit system directory. There is no function that obtains the path of this directory, but it is searched. Windows Me/98/95:  This directory does not exist.
\item The Windows directory. Use the GetWindowsDirectory function to get the path of this directory. 
\item The directories that are listed in the PATH environment variable. 
}

Windows Server 2003, Windows XP SP1:  The default value of HKLM\System\CurrentControlSet\Control\Session Manager\SafeDllSearchMode is 1 (current directory is searched after the system and Windows directories).



Windows XP:  If HKLM\System\CurrentControlSet\Control\Session Manager\SafeDllSearchMode is 1, the current directory is searched after the system and Windows directories, but before the directories in the PATH environment variable. The default value is 0 (current directory is searched before the system and Windows directories).


The first directory searched is the one directory containing the image file used to create the calling process. Doing this allows private dynamic-link library (DLL) files associated with a process to be found without adding the process's installed directory to the PATH environment variable.

The search path can be altered using the SetDllDirectory function. This solution is recommended instead of using SetCurrentDirectory or hard-coding the full path to the DLL.

If a path is specified and there is a redirection file for the application, the function searches for the module in the application's directory. If the module exists in the application's directory, the LoadLibrary function ignores the specified path and loads the module from the application's directory. If the module does not exist in the application's directory, LoadLibrary loads the module from the specified directory. For more information, see Dynamic Link Library Redirection.



}
\keyword{interface}
\keyword{programming::interface}
