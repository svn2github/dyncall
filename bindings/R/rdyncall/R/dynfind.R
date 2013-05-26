
dynfind1 <- if (.Platform$OS.type == "windows") {
  function(libnames, ...) {
    handle <- .dynload(paste("lib",name,name,sep=""),...)
    if (!is.null(handle)) return(handle)
    .dynload(paste("lib",name,name,sep=""),...)
  }
} else {
  if ( Sys.info()[["sysname"]] == "Darwin" ) {
    function(name, ...) {
      handle <- .dynload(paste(name,".framework/",name,sep=""),...)
      if (!is.null(handle)) return(handle)
      .dynload(paste("lib",name,".dylib",sep=""),...)
    }
  } else {
    function(name, ...) {
      handle <- .dynload(paste("lib",name,".so",sep=""),...)
      if (!is.null(handle)) return(handle)
      .dynload(paste("lib",name,sep=""),...)
    }
  }
}

dynfind <- function(libnames, auto.unload = TRUE) {
  for (libname in libnames) {
    handle <- dynfind1(libname)
    if (!is.null(handle)) return(handle)
  }
}

