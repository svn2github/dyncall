# Project: rdyncall
# File: R/dynports.R
# Description: repository for multi-platform bindings to binary components.
# Author: Daniel Adler <dadler@uni-goettingen.de> 
#         additional code copied from Luke Tierney's implementation for Name Spaces in R.

# Front-end:

dynport <- function(portname, portfile=NULL, repo=system.file("dynports", package="rdyncall"))
{
  # literate portname string
  portname <- as.character(substitute(portname))
  if (missing(portfile))
  {
    # search for portfile
    portfile <- file.path( repo, paste(portname,".R",sep="") )
    if ( !file.exists(portfile) ) portfile <- file.path( repo, paste(portname,".json",sep="") )        
    if ( !file.exists(portfile) ) stop("dynport '", portname, "' not found.")    
  }
  loadDynportNamespace(portname, portfile)  
}


# the following code is copied from 'loadNamespace' (from Luke Tierney):
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
  # .Internal(registerNamespace(name, env))
  env
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
  # register 
  .Internal(registerNamespace(name, env))
  # export all objects, expect '.' variables reserved for internal use
  namespaceExport(env, ls(env))
  # attach namespace
  if (do.attach) attachNamespace(env)
}

