# Package: rdyncall
# File: R/libLibpath.R
# Description: utilities to search for shared libraries in the system

# ----------------------------------------------------------------------------
# global: .sysLibPath
# description: contains a list of common paths
.sysLibPaths <- if (.Platform$OS == "windows") { # windows
  # TODO: windows
} else { # unix
	local({
		commons <- c("/usr/local/lib", "/usr/lib", "/lib")
		paths <- c(commons, pathsFromEnv("LD_LIBRARY_PATH") )
    if ( Sys.info()[["sysname"]] == "Darwin" ) {
      # TODO: darwin
      paths <- c(paths, pathsFromEnv("DYLD_LIBRARY_PATH") )    
    }
    paths <- unique(paths)
    paths[ paths != "" ]	
	})
}

# ----------------------------------------------------------------------------
# function: findLibPath
# search shared library in common places (all platforms)

findLibPath <- function(name, paths=.sysLibPaths)
{
	for(i in paths) {
		path <- file.path(i, paste("lib", name,.Platform$dynlib.ext,sep="") )    
		if ( file.exists(path) ) return(path)
	}
	NA
}

# ----------------------------------------------------------------------------
# function: findFrameworkPath
# search shared library in frameworks for darwin

.sysFrameworkPaths <- c("/Library/Frameworks", "/System/Library/Frameworks")

findFrameworkLibPath <- function(name, paths=.sysFrameworkPaths)
{
  # TODO: darwin    
  for (i in paths) {
    path <- file.path( i, paste(name, ".framework", sep=""), name)
    if (file.exists(path)) return(path)
  }
  NA
}

# ----------------------------------------------------------------------------
# generic extension component search (currently shared libraries supported)

findComponentPath <- function(name)
{
  if (Sys.info()[["sysname"]] == "Darwin") {
    x <- findFrameworkLibPath()
    if (!is.na(x)) return(x)
  }
  findLibPath(name)
}
