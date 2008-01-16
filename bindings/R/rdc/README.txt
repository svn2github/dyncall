rdc package: dyncall R bindings
===============================
(C) 2007 Daniel Adler

Requirement
- dyncall 0.1 (url: http://dyncall.org)


Building
  
  1. build and install dyncall (see dyncall manual)
  2. run R CMD INSTALL with configure option --with-dc-prefix e.g.

  $ R CMD INSTALL --configure-args="--with-dc-prefix=/usr/local" rdc


Build on Windows platforms

  1. build and install dyncall (see dyncall manual) 
     e.g.
     > cd dyncall-src
     > .\configure.bat /install:c:\tmp\dyncall
     > sh ./configure --prefix c:/tmp/dyncall
     > make
     > make install

  2. set DC_PREFIX variable to installation prefix path 
     e.g.
     > set DC_PREFIX=c:\tmp\dyncall
     
  3. run R CMD INSTALL
     e.g.
     > R CMD INSTALL rdc

