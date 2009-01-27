dynbind1 <- function(libh, symbol, signature, callvm, env)
{
  funcptr <- .dynfind(libh, symbol)
  
  f <- function(...) NULL
  body(f) <- substitute( call(".dyncall", MODE=mode)
  assign( symbol, f, env=env,  )
  
}

dynbind <- function(libname, signature, env=parent.frame(), .callvm=.cdecl)
{
  # load library
  libh <- dynload(libname)
  # parse signature
  sigtab <- gsub("[ \n\t]*","",signature)
  sigtab <- strsplit(sigtab, ";")[[1]]
  sigtab <- strsplit(sigtab, "\\(")
  # install functions
  for (i in seq(along=sigs)) bind1(libh, sigtab[[i]][[1]], sigtab[[i]][[2]], callvm, envir )    
}
