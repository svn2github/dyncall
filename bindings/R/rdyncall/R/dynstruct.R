
# ----------------------------------------------------------------------------
# type info registry

.alignDefaults <- 4
# .typeMap <- new.env(parent=emptyenv())
.typeMap <- new.env()

registerType <- function(name, info) .typeMap[[name]] <- info
unregisterType <- function(name) rm( list=name, pos=.typeMap ) 
getType <- function(name) .typeMap[[name]]
showTypes <- function() ls(pos=.typeMap)

# ----------------------------------------------------------------------------
# sizes and sizeof

.typeSizes <- c(
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

sizeof <- function(typename)
{
  char1 <- substr(typename, 1, 1)
  if ( char1 == "*" ) return(.Machine$sizeof.pointer)
  else if ( char1 == "<" ) {
    typename <- substr(typename, 2, nchar(typename)-1 )
  }
  ans <- unname(.typeSizes[typename])
  if (!is.na(ans)) return(ans)
  typeinfo <- .typeMap[[typename]]
  if (is.null(typeinfo)) return(NA_integer_)
  return(typeinfo[".size", "offset"])
}

# ----------------------------------------------------------------------------
# alignof

alignof <- function(typename)
{
  char1 <- substr(typename, 1, 1)
  if ( char1 == "*" ) return(.Machine$sizeof.pointer)
  else if ( char1 == "<" ) {
    typename <- substr(typename, 2, nchar(typename)-1 )
    typeinfo <- .typeMap[[typename]]    
    if (is.null(typeinfo)) return(NA_integer_)
    return( alignof( typeinfo[[1, "type"]] ) )
  } else {
    ans <- unname(.typeSizes[typename])
    if (!is.na(ans)) return(ans)
    return(NA_integer_)
  }
}

# ----------------------------------------------------------------------------
# parse structure signature

computeFieldInfo <- function(structsig)
{
  # answer:
  types   <- character(0L)
  offsets <- integer(0L)
  # scan signature:
  offset  <- 0L
  n       <- nchar(structsig)
  i       <- 1L
  start   <- i
  while(i <= n)
  {
    char  <- substr(structsig,i,i)
    if (char == "*") {
      i <- i + 1L      
    } else if (char == "<") {
      i <- i + 1L
      while (i < n) {
        if ( substr(structsig,i,i) == ">" )
        {
          typename <- substr(structsig, start, i)
          size <- sizeof(typename)
          offsets <- c(offsets, offset)
          types   <- c(types, typename)
          offset <- offset + size
          i <- i + 1L
          start <- i
          break
        }
        i <- i + 1L
      }
    } else {
      typename <- substr(structsig, start, i)
      align <- alignof(typename)
      offset <- as.integer( as.integer( (offset + align-1L) / align ) * align )
      types   <- c(types, typename)
      offsets <- c(offsets, offset)
      offset  <- offset + sizeof(typename)
      i     <- i + 1L
      start <- i
    }
  }
  offsets <- c(offsets, offset)
  types   <- c(types, "v")  
  data.frame(type=types, offset=offsets)  
}

makeStructInfo <- function(sig, fieldnames)
{  
  fields <- computeFieldInfo(sig)
  row.names(fields) <- c(fieldnames, ".sizeof")
  return(fields)
}

registerStructInfo <- function(name, sig, fieldnames)
{
  registerType( name, makeStructInfo(sig, fieldnames) )
}

registerStructInfos <- function(sigs)
{
  # split functions at ';'
  sigs <- unlist( strsplit(sigs, ";") )  
  # split name/struct signature at '('
  sigs <- strsplit(sigs, "[{]")
  infos <- list()
  for (i in seq(along=sigs)) 
  {
    n <- length(sigs[[i]])
    if ( n == 2 ) {
      name     <- sigs[[i]][[1]]
      name     <- gsub("[ \n\t]*","",name)
      tail     <- unlist( strsplit(sigs[[i]][[2]], "\\}") )
      sig      <- tail[[1]]
      if (length(tail) == 2)
        fields   <- unlist( strsplit( tail[[2]], "[ \n\t]+" ) ) 
      else 
        fields   <- NULL      
      registerStructInfo(name, sig, fields)        
    }
  }  
}

# ----------------------------------------------------------------------------
# struct class

as.struct <- function(x, struct)
{
  attr(x, "struct") <- struct
  class(x) <- "struct"
  return(x)
}

new.struct <- function(name)
{
  type <- getType(name)
  if (is.null(type)) stop("unknown structure type")
  x <- raw( sizeof(name) )
  as.struct( x, name )
}

"$.struct" <- 
unpack.struct <- function(x, index)
{
  name <- attr(x, "struct")
  info <- getType(name)
  offset <- info[index,"offset"]
  if (is.na(offset)) stop("unknown field index '", index ,"'")
  type   <- as.character(info[index,"type"])
  char1 <- substr(type, 1,1)
  if (char1 == "<") {
    type      <- substr(type, 2, nchar(type)-1 )
    substruct <- getType(type)
    subsize   <- substruct[[".sizeof", "offset"]]
    as.struct( x[offset:(offset+subsize)], struct=type )
  } else
    .unpack1(x, offset, type ) 
}

"$<-.struct" <- 
    pack.struct <- function( x, index, value )
{
  name   <- attr(x, "struct")
  info   <- getType(name)
  offset <- info[index,"offset"]
  if (is.na(offset)) stop("unknown field index '", index ,"'")
  type   <- as.character(info[index,"type"])
  .pack1( x, offset, type, value )
  return(x)
}

str.struct <- function(x)
{
  name <- attr(x, "struct")
  info <- getType(name)
  names <- rownames(info)
  # print data without last
  cat("struct ", name, " {\n")
  for (i in 1:(nrow(info)-1)) 
  {    
    val <- unpack.struct(x,i)
    if (typeof(val) == "externalptr") val <- .addrval(val)
    
    if (class(val) == "struct") str(val)
    else cat( "\t", names[[i]] , "\t", val, "\n" )
  }
  cat("}\n")
}

