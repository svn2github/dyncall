# Dynport: glu
# Description: OpenGL Utility library
# Maintainer: dadler@uni-goettingen.de

if (.Platform$OS == "windows") {
  .libname <- "GLU32"
  .callmode <- "stdcall"
} else {
  .callmode <- "cdecl"
  if ( Sys.info()[["sysname"]] == "Darwin" ) {
    .libname <- "OpenGL"
  } else {
    .libname <- c("GLU","GLU.so.1")
  }
}

dynbind(.libname,"
  gluLookAt(ddddddddd)v;
  gluPerspective(dddd)v;
  gluErrorString(i)S;
",callmode=.callmode)

