\name{callback}
\alias{new.callback}
\alias{callback}
\alias{dyncallback}
\title{Dynamic wrapping of R functions into C callbacks}
\description{  
Function to wrap R functions as a C function pointer. 
}
\usage{
new.callback( signature, fun, envir = new.env() )
}
\arguments{
  \item{signature}{character string specifying the \link[=signature]{call signature} of the C function callback type.}
  \item{fun}{R function to be wrapped as a C function pointer.}
  \item{envir}{the environment in which to evaluate the call to \code{fun}. }
}
\details{
Callbacks are user-defined functions that are registered in a foreign library and that are executed at a later time from within that library.
Examples include user-interface event handlers that are registered in GUI toolkits, and, comparision functions passed to generic sort algorithm when sorting a vector of a custom data type.

The function \code{new.callback} wraps an R function \code{fun} as a C function pointer with a function type \link{call signature} given by \code{signature}.

When the C function pointer is called, a callback handler is executed that dynamically creates a call expression to \code{fun}
using the arguments passed from C and converted to R according to the argument types signature within the \link{call signature} specified.
Finally, the handler evaluates the call expression within the environment given by \code{envir} and converts back any return values from R to C according to the return tyope specified in the \link{call signature}.
If an R error occurs during the evaluation, the callback will be disabled for further invocations.

}
\value{
\code{new.callback} returns an external pointer to a synthetically generated C function that can be registered as a C callback.
}

\section{Portability}{
The implementation is based on the \emph{dyncallback} library (part of the DynCall project).

The following processor architectures are supported: X86, X64, ARM and PowerPC 32-bit (particial); 

Ports to the following OSs have been validated: Linux, Mac OS X, Windows 32/64-bit, (Open-,Free-,Net-,DragonFly-) BSD, Haiku, Nexenta/Open Solaris, Minix, Plan9
as well as embedded platforms such as Linux/ARM (OpenMoko, Beagleboard, Gumstix), Nintendo DS (ARM), Sony Playstation Portable (MIPS 32-bit/eabi) and iOS (ARM - armv6 mode ok, armv7 unstable).

Special notes for PowerPC 32-Bit: Callbacks for System V (Linux/BSD) are unstable in this release; MacOS X/Darwin works fine.

In the context of R, there is currently no support for callbacks on MIPS, SPARC and PowerPC 64-Bit.
}
\note{
The call signature \strong{MUST} match the foreign C callback function type, otherwise an activated callback call from C can lead to a \strong{fatal R process crash}.

A small amount of memory is allocated with each wrapper. 
A finalizer function that frees the allocated memory is registered at the external pointer.
If the external callback function pointer is registered in a C library, a reference should also be held in R as long as the callback might get activated from C, otherwise the garbage collector might call the
finalizer and the next invocation of the callback could lead to a \strong{fatal R process crash} as well.
}

\references{
  Adler, D., Philipp, T. (2008) \emph{DynCall Project}. 
  \url{http://dyncall.org}
}
\seealso{
See \code{\link{signature}} for details on call signatures,
\code{\link{reg.finalizer}} for details on finalizers.
}
\examples{

# Create a function, wrap it to a callback and call it via .dyncall:
f <- function(x,y) x+y
cb <- new.callback("ii)i", f)
r <- .dyncall(cb, "ii)i", 20, 3)

# Sort vectors directly via 'qsort' C library function using an R callback:
dynbind(c("msvcrt","c","c.so.6"), "qsort(piip)v;")
cb <- new.callback("pp)i",function(px,py){  
  x <- .unpack(px, 0, "d")
  y <- .unpack(py, 0, "d")
  if (x >  y) return(1) else if (x == y) return(0) else return(-1)
})
x <- rnorm(100)
qsort(x,length(x),8,cb)

}
\keyword{programming}
\keyword{interface}
