# Dynport: glu
# Description: OpenGL Utility library
# Maintainer: dadler@uni-goettingen.de

if (.Platform$OS == "windows") {
  libname <- "GLU32"
} else if ( Sys.info()[["sysname"]] == "Darwin" ) {
  libname <- "OpenGL"
} else {
  libname <- "GLU"
}

dynbind(libname,"
  gluLookAt(ddddddddd)v;
  gluPerspective(dddd)v;
  gluErrorString(i)S;
",callmode="stdcall")

