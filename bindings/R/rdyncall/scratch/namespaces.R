
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

name <- "stdio"
ns   <- makeNamespace(name)
with(ns,{
dynbind("msvcrt","fopen(ZZ)p;fread(piip)i;")      
})
namespaceExport( ns, ls(ns) )
attach(ns, name="dynport:stdio")


unloadNamespace("stdio")
