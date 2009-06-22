# File: rdyncall/R/struct.R
# Description: handling of aggregate low-level structures

old <- function()
{

.sigsizes <- c(
B=.Machine$sizeof.long,
c=1L,
C=1L,
s=2L,
S=2L,
i=.Machine$sizeof.long,
I=.Machine$sizeof.long,
j=.Machine$sizeof.long,
J=.Machine$sizeof.long,
l=.Machine$sizeof.longlong,
L=.Machine$sizeof.longlong,
f=4L,
d=8L,
p=.Machine$sizeof.pointer,
x=.Machine$sizeof.pointer,
Z=.Machine$sizeof.pointer,
v=0L
)

typemap.C <- c(
UINT='i',
WNDPROC='p',
int='i',
HINSTANCE='p',
HICON='p',
HCURSOR='p',
HBRUSH='p',
LPCTSTR='Z',
LPCTSTR='Z',
void='v'
)

structinfo <- function( x , ... ) UseMethod("structinfo")

structinfo.struct    <- function(struct) attr( struct, "structinfo" )
structinfo.character <- function(string, typemap=typemap.C, sizemap=.sigsizes) {
  
  # split at whitespace and ';'
  
  tab <- strsplit(string,'[; \t\n]+')[[1]]
  if (tab[1] == "") tab <- tab[-1]
  n <- length(tab)
  even <- seq(1,n,by=2)
  odd  <- seq(2,n,by=2)
  types   <- tab[even]
  ids     <- tab[odd]
  types   <- typemap[types]
  sizes   <- sizemap[types]   
  offsets <- c(0,cumsum(sizes))
  ids     <- c(ids,".end")
  types   <- c(types, "v" )
  sizes   <- c(sizes, 0 )
  x <- data.frame(id=ids,type=types,size=sizes,offset=offsets,row.names=1)
  class(x) <- c("structinfo", class(x) )
  return(x)
  # signature = paste( x, collapse="" )
}

# ----------------------------------------------------------------------------
# sizeof operator in R for structs, unions and multi-precision integers 

sizeof <- function(x) UseMethod("sizeof")

sizeof.structinfo <- function(structinfo) structinfo[[".end","offset"]]
sizeof.struct     <- function(struct) { sizeof(structinfo(struct)) }

new.struct <- function(structinfo)
{
  stopifnot(inherits(structinfo, "structinfo") )
  x <- raw( sizeof(structinfo) )
  class(x) <- "struct"
  attr(x,"structinfo") <- structinfo
  return(x)
}

as.structptr <- function(structinfo, x)
{
  stopifnot(inherits(structinfo, "structinfo") )
  class(x) <- c("struct", class(x) )
  attr(x,"structinfo") <- structinfo
  return(x)
}


"$<-.struct" <- 
pack.struct <- function( x, index, value )
{
  info <- attr(x, "struct")
  .pack1( x, info[[index,"offset"]], as.character(info[index,"type"]), value )
  return(x)
}

"$.struct" <- 
unpack.struct <- function(x, index)
{
  info <- attr(x, "struct")
  .unpack1(x, info[[index,"offset"]], as.character(info[index,"type"]) )  
}

"str.struct" <- function(x)
{
  info <- structinfo(x)
  name <- rownames(info)
  # print data without last
  cat("struct {\n")
  for (i in 1:(nrow(info)-1)) 
  {
    val <- unpack.struct(x,i)
    if (typeof(val) == "externalptr") val <- .addrval(val)
    cat( name[[i]] , " ", val, "\n" )
  }
  cat("}\n")
}

}
