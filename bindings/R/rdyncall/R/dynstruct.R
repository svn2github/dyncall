
# ----------------------------------------------------------------------------
# type info registry

.alignDefaults <- 4
# .typeMap <- new.env(parent=emptyenv())
.structInfos <- new.env()

registerStructInfo <- function(name, info) .structInfos[[name]] <- info
unregisterStructInfo <- function(name) rm( list=name, pos=.structInfos ) 
getStructInfo <- function(name) .structInfos[[name]]
showStructInfos <- function() ls(pos=.structInfos)

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

sizeof <- function(typeName)
{
  char1 <- substr(typeName, 1, 1)
  if ( char1 == "*" ) return(.Machine$sizeof.pointer)
  else if ( char1 == "<" ) {
    typeName <- substr(typeName, 2, nchar(typeName)-1 )
  }
  size <- unname(.typeSizes[typeName])
  if (!is.na(size)) return(size)
  structInfo <- .structInfos[[typeName]]
  if (is.null(structInfo)) return(NA_integer_)
  return(structInfo[".size", "offset"])
}

# ----------------------------------------------------------------------------
# alignof

alignof <- function(typeName)
{
  char1 <- substr(typeName, 1, 1)
  if ( char1 == "*" ) return(.Machine$sizeof.pointer)
  else if ( char1 == "<" ) {
    structName <- substr(typeName, 2, nchar(typeName)-1 )
    structInfo <- .structInfos[[structName]]    
    if (is.null(structInfo)) return(NA_integer_)
    return( alignof( structInfo[[".align", "offset"]] ) )
  } else {
    ans <- unname(.typeSizes[typeName])
    if (!is.na(ans)) return(ans)
    return(NA_integer_)
  }
}

align <- function(x, align)
{
  as.integer( as.integer( (x + align-1L) / align ) * align )
}

# ----------------------------------------------------------------------------
# parse structure signature

makeStructInfo <- function(structSignature, fieldNames)
{
  types    <- character(0L)
  offsets  <- integer(0L)
  offset   <- 0L
  n        <- nchar(structSignature)
  i        <- 1L
  start    <- i
  maxAlign <- 1L
  while(i <= n)
  {
    char  <- substr(structSignature,i,i)
    if (char == "*") {
      i <- i + 1L      
    } else if (char == "<") {
      i <- i + 1L
      while (i < n) {
        if ( substr(structSignature,i,i) == ">" ) break
        i <- i + 1L
      }      
      structName <- substr(structSignature, start, i)
      
      alignment <- alignof(structName)
      maxAlign  <- max(maxAlign, alignment)
      offset    <- align( offset, alignment )      
      
      types     <- c(types, structName)
      offsets   <- c(offsets, offset)
      
      offset    <- offset + sizeof(structName)
      i         <- i + 1L
      start     <- i
    } else {
      typeName  <- substr(structSignature, start, i)
      
      alignment <- alignof(typeName)
      maxAlign  <- max(maxAlign, alignment)
      offset    <- align( offset, alignment )
      
      types     <- c(types, typeName)
      offsets   <- c(offsets, offset)
      
      offset    <- offset + sizeof(typeName)
      i         <- i + 1L
      start     <- i
    }
  }
  size    <- align(offset, maxAlign)
  offsets <- c(offsets, size, maxAlign)
  types   <- c(types, "v", "v")  
  fields  <- data.frame(type=types, offset=offsets)  
  row.names(fields) <- c(fieldNames, ".size", ".align")
  fields
}

parseStructInfos <- function(sigs)
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
      # parse structure name
      name     <- sigs[[i]][[1]]
      name     <- gsub("[ \n\t]*","",name)
      # split struct signature and field names
      tail     <- unlist( strsplit(sigs[[i]][[2]], "[}]") )
      sig      <- tail[[1]]
      if (length(tail) == 2)
        fields   <- unlist( strsplit( tail[[2]], "[ \n\t]+" ) ) 
      else 
        fields   <- NULL      
      registerStructInfo( name, makeStructInfo(sig, fields) )
    }
  }  
}

# ----------------------------------------------------------------------------
# parse union signature

makeUnionInfo <- function(unionSignature, fieldNames)
{
  # answer:
  types   <- character(0L)
  # scan signature:
  n       <- nchar(unionSignature)
  i       <- 1L
  start   <- i
  size    <- 0L
  maxAlign <- 1L 
  while(i <= n)
  {
    char  <- substr(unionSignature,i,i)
    if (char == "*") {
      i <- i + 1L      
    } else if (char == "<") {
      i <- i + 1L
      while (i < n) {
        if ( substr(unionSignature,i,i) == ">" ) break
        i <- i + 1L
      }
      structName <- substr(unionSignature, start, i)
      size       <- max( size, sizeof(structName) )
      maxAlign   <- max(maxAlign, alignof(structName))
      types      <- c(types, structName)
      i          <- i + 1L
      start      <- i
    } else {
      typeName  <- substr(unionSignature, start, i)
      size      <- max( size, sizeof(typeName) )
      maxAlign  <- max(maxAlign, alignof(typeName))      
      types    <- c(types, typeName)
      i        <- i + 1L
      start    <- i
    }
  }
  offsets <- c( rep(0L, length(types)), size, maxAlign )
  types   <- c(types, "v", "v")  
  fields  <- data.frame(type=types, offset=offsets)  
  row.names(fields) <- c(fieldNames, ".size", ".align")
  return(fields)
}

parseUnionInfos <- function(sigs)
{
  # split functions at ';'
  sigs <- unlist( strsplit(sigs, ";") )  
  # split name/union signature at '|'
  sigs <- strsplit(sigs, "[|]")
  infos <- list()
  for (i in seq(along=sigs)) 
  {
    n <- length(sigs[[i]])
    if ( n == 2 ) {
      # parse structure name
      name     <- sigs[[i]][[1]]
      name     <- gsub("[ \n\t]*","",name)
      # split struct signature and field names
      tail     <- unlist( strsplit(sigs[[i]][[2]], "[}]") )
      sig      <- tail[[1]]
      if (length(tail) == 2)
        fields   <- unlist( strsplit( tail[[2]], "[ \n\t]+" ) ) 
      else 
        fields   <- NULL      
      registerStructInfo( name, makeUnionInfo(sig, fields) )
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
  type <- getStructInfo(name)
  if (is.null(type)) stop("unknown structure type")
  x <- raw( sizeof(name) )
  as.struct( x, name )
}

"$.struct" <- 
unpack.struct <- function(x, index)
{
  name <- attr(x, "struct")
  info <- getStructInfo(name)
  offset <- info[index,"offset"]
  if (is.na(offset)) stop("unknown field index '", index ,"'")
  typename   <- as.character(info[index,"type"])
  if (substr(typename, 1,1) == "<") {
    structname  <- substr(typename, 2, nchar(typename)-1 )
    size        <- sizeof(structname)
    as.struct( x[(offset+1):(offset+1+size-1)], struct=structname )
  } else
    .unpack1(x, offset, typename ) 
}

"$<-.struct" <- 
pack.struct <- function( x, index, value )
{
  name   <- attr(x, "struct")
  info   <- getStructInfo(name)
  offset <- info[index,"offset"]
  if (is.na(offset)) stop("unknown field index '", index ,"'")
  typename   <- as.character(info[index,"type"])
  if (substr(typename,1,1) == "<") {
    structname <- substr(typename,2,nchar(typename)-1)
    size <- sizeof(structname)
    x[(offset+1):(offset+1+size-1)] <- as.raw(value)    
  } else {
    .pack1( x, offset, typename, value )
  }
  return(x)
}

print.struct <- function(x, indent=0)
{
  name <- attr(x, "struct")
  info <- getStructInfo(name)
  names <- rownames(info)
  # print data without last
  cat( "struct ", name, " {\n")
  for (i in 1:(nrow(info)-1)) 
  { 
    cat( rep("  ", indent+1), names[[i]] , ":" )
    val <- unpack.struct(x,i)
    if (typeof(val) == "externalptr") val <- .addrval(val)        
    if (class(val) == "struct") { print.struct(val, indent=indent+1) }
    else cat( val, "\n" )
  }
  cat( rep("  ", indent), "}\n")
}

