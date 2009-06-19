# File: rdyncall/R/dynports.R
# Description: repository for multi-platform bindings to binary components.

from.R <- function(file, envir)
{  
  sys.source(file, envir=envir)  
}

makeNamespace <- function(name, version = NULL, lib = NULL) {
  impenv <- new.env(parent = .BaseNamespaceEnv, hash = TRUE)
  attr(impenv, "name") <- paste("imports", name, sep = ":")
  env <- new.env(parent = impenv, hash = TRUE)
  name <- as.character(as.name(name))
  version <- as.character(version)
  info <- new.env(hash = TRUE, parent = baseenv())
  assign(".__NAMESPACE__.", info, envir = env)
  assign("spec", c(name = name, version = version), 
      envir = info)
  setNamespaceInfo(env, "exports", new.env(hash = TRUE, 
          parent = baseenv()))
  setNamespaceInfo(env, "imports", list(base = TRUE))
  setNamespaceInfo(env, "path", file.path(lib, name))
  setNamespaceInfo(env, "dynlibs", NULL)
  setNamespaceInfo(env, "S3methods", matrix(NA_character_, 
          0L, 3L))
  assign(".__S3MethodsTable__.", new.env(hash = TRUE, 
          parent = baseenv()), envir = env)
  .Internal(registerNamespace(name, env))
  env
}

dynport.namespace <- function(name, pos)
{
  dir <- system.file( "dynports", package="rdyncall")
  if ( file.exists(portfile.R) )
    from.R(portfile.R,env)
  ns <- makeNamespace(name)
  namespaceExport(ns, ls(ns))
  
  attach(env, name=paste("dynport:",name,sep=""))
}

dynport <- function(portname, envir=NULL, pos = 2, auto.attach=TRUE, use.namespace=TRUE)
{      
  portname <- as.character(substitute(portname))
  envname <- paste("dynport",portname,sep=":")
  
  if ( ! envname %in% search() )
  {
    # load dynport package
  
    if ( missing(envir) )
    {  
      if (use.namespace) {
        envir <- makeNamespace(portname)        
      } else {
        envir <- new.env()
      }
    }    
  
    attr(envir, "name") <- envname
    dir <- system.file( "dynports", package="rdyncall")

    # R file
    
    portfile.R <- file.path( dir, paste(portname,"R",sep=".") )
    
    if ( file.exists(portfile.R) )
      from.R(portfile.R,envir)
    
    # json file
    
    portfile.json <- file.path( dir, paste(portname,"json",sep=".") )    
    
    if ( file.exists(portfile.json) )
      from.json(portfile.json,envir)
    
    if (auto.attach)
    {
      attach(envir, pos = pos, name = envname)
    }
  }
  return(invisible(NULL))
}

dynport.unload <- function(portname)
{
  portname <- as.character(substitute(portname))
  envname <- paste("dynport",portname,sep=":")
  detach( name=envname )
}

dynport.require <- function(portname)
{
  
}

dynport.cpreprocessor <- function(text)
{
  readLines()


  json.code.commented <- function() {
    
    require(rjson)
    
    jsonparser <- newJSONParser()
    
    parseJSON <- function(path)
    {
      parser <- newJSONParser()
      f <- file(path)
      open(f)
      while(TRUE) 
      {
        aLine <- readLines(f, 1)
        if (length(aLine) == 0) break    
        parser$addData( aLine )
      }
      close(f)
      parser$getObject()
    }
    
    from.json <- function(file)
    {
      json <- parseJSON(file)
      sysname <- Sys.info()[["sysname"]][[1]]
      paste( "_OS_", toupper(sysname) )   
      libname <- json$libname
      dynbind(libname, libsignature, envir=parent.frame(), callmode="cdecl")
    }
    
    dynport.json <- function(portname, envir=NULL, pos = 2, auto.attach=TRUE)
    {
      
    }
    
  }
}