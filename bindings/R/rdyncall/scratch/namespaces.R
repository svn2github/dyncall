
x <- new.env()
attr(x, "name") <- "foo"
attach(x, name="package:bar")

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

e <- makeNamespace("hallo")
e$x <- 23
hallo:::x
namespaceExport(e, "x") 

