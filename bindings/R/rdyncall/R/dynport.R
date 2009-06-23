# File: rdyncall/R/dynports.R
# Description: repository for multi-platform bindings to binary components.

# the following code is copied from 'loadNamespace':
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

# deprecated package-based container:
loadDynportPackage  <- function(portname, filename, envir=NULL, pos = 2, use.namespace=FALSE, auto.attach=FALSE)
{
  # setup dynport environment search name  
  envname <- paste("dynport",portname,sep=":")            
  # check if dynport already loaded  
  if ( envname %in% search() ) return()
  if (missing(envir))
  {
    env <- new.env(parent=baseenv())
    attr(env, "name") <- envname
  }
}

# new namespace-based container:
loadDynportNamespace <- function(name, portfile, do.attach=TRUE)
{ 
  # check if dynport namespace already loaded  
  if ( name %in% loadedNamespaces() ) return()
  # create namespace  
  env <- makeNamespace(name)
  # process portfile
  sys.source(portfile, envir=env)  
  # export all objects, expect '.' variables reserved for internal use
  namespaceExport(env, ls(env))
  # attach namespace
  if (do.attach) attachNamespace(env)
}

# Front-end:

dynport <- function(portname, filename=NULL, repo=system.file("dynports", package="rdyncall"))
{
  # literate portname as string
  portname <- as.character(substitute(portname))
  if (missing(filename))
  {
    # search for filename
    filename <- file.path( repo, paste(portname,".R",sep="") )
    if ( !file.exists(filename) ) filename <- file.path( repo, paste(portname,".json",sep="") )        
    if ( !file.exists(filename) ) stop("dynport '", portname, "' not found.")    
  }
  loadDynportNamespace(portname, filename)  
}

dynport.unload <- function(portname)
{
  unloadNamespace(portname)
}

#dynport.unload <- function(portname)
#{
#  portname <- as.character(substitute(portname))
#  envname <- paste("dynport",portname,sep=":")
#  detach( name=envname )
#}

#dynport.require <- function(portname)
#{
#  
#}


future.json.format <- function() 
{
  
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
