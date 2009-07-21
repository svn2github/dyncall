# File: rdyncall/R/dynstruct.R
# Description: handling of aggregate low-level C structure and union types.
# ----------------------------------------------------------------------------
# dynport basetype sizes

.basetypeSizes <- c(
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

# ----------------------------------------------------------------------------
# dynport type information
#

TypeInfo <- function(...) 
{
  x <- list(...)
  class(x) <- "typeinfo"
  return(x)
}

getTypeInfo <- function(typeName, envir=parent.frame())
{
  char1 <- substr(typeName, 1, 1)
  switch(char1,
    "*"=TypeInfo(type="pointer", size=.Machine$sizeof.pointer, align=.Machine$sizeof.pointer, basetype=substr(typeName,2,nchar(typeName)), signature=typeName),
    "<"={ 
      x <- getTypeInfo(substr(typeName, 2,nchar(typeName)-1), envir=envir) 
      if (!is.null(x)) 
        return(x) 
      else 
        return(TypeInfo(type="struct"))
    },
    {
      # try as basetype
      basetypeSize <- unname(.basetypeSizes[typeName])
      if ( !is.na(basetypeSize) ) return(TypeInfo(type="base", size=basetypeSize, align=basetypeSize, signature=typeName))
      # try lookup symbol
      else if (exists(typeName,envir=envir) ) {
        info <- get(typeName,envir=envir)
        if (!inherits(info, "typeinfo")) stop("not a type information symbol")
        return(info)
      }
      # otherwise fail
      else NULL
      # else stop("unknown type info: ",typeName)
    }
  )
}

# ----------------------------------------------------------------------------
# align C offsets

align <- function(offset, alignment)
{
  as.integer( as.integer( (offset + alignment-1L) / alignment ) * alignment )
}

# ----------------------------------------------------------------------------
# field information (structures and unions)

makeFieldInfo <- function(fieldNames, types, offsets)
{  
  data.frame(type=I(types), offset=offsets, row.names=fieldNames)  
}

# ----------------------------------------------------------------------------
# parse structure signature

makeStructInfo <- function(structSignature, fieldNames, envir=parent.frame())
{
  # computations:
  types    <- character()
  offsets  <- integer()
  offset   <- 0L
  maxAlign <- 1L
  # scan variables:
  n        <- nchar(structSignature)
  i        <- 1L
  start    <- i
  while(i <= n)
  {
    char  <- substr(structSignature,i,i)
    if (char == "*") { 
      i <- i + 1L ; next
    } else if (char == "<") {
      i <- i + 1L
      while (i < n) {
        if ( substr(structSignature,i,i) == ">" ) break
        i <- i + 1L
      }    
    } 
    typeName  <- substr(structSignature, start, i)
    types     <- c(types, typeName)
    typeInfo  <- getTypeInfo(typeName, envir=envir)
    alignment <- typeInfo$align
    maxAlign  <- max(maxAlign, alignment)
    offset    <- align( offset, alignment )
    offsets   <- c(offsets, offset)
    
    # increment offset by size
    offset    <- offset + typeInfo$size

    # next token
    i         <- i + 1L
    start     <- i
  } 
  # align the structure size (compiler-specific?)
  size    <- align(offset, maxAlign)
  # build field information
  fields  <- makeFieldInfo(fieldNames, types, offsets)
  TypeInfo(type="struct",size=size,align=maxAlign,fields=fields)
}

parseStructInfos <- function(sigs, envir=parent.frame())
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
      assign(name, makeStructInfo(sig, fields, envir=envir), envir=envir)
    }
  }  
}

# ----------------------------------------------------------------------------
# parse union signature

makeUnionInfo <- function(unionSignature, fieldNames, envir=parent.frame())
{
  # computations:
  types    <- character()
  maxSize  <- 0L
  maxAlign <- 1L 
  # scan variables:
  i       <- 1L
  start   <- i
  n       <- nchar(unionSignature)
  while(i <= n) {
    char  <- substr(unionSignature,i,i)
    if (char == "*") {
      i <- i + 1L ; next
    } else if (char == "<") {
      i <- i + 1L
      while (i < n) {
        if ( substr(unionSignature,i,i) == ">" ) break
        i <- i + 1L
      }
    } 
    typeName <- substr(unionSignature,start,i)
    types    <- c(types, typeName)
    typeInfo <- getTypeInfo(typeName, envir)
    maxSize  <- max( maxSize, typeInfo$size )
    maxAlign <- max( maxAlign, typeInfo$align )
    # next token
    i        <- i + 1L
    start    <- i
  }
  offsets <- rep(0L, length(types) )
  fields  <- makeFieldInfo(fieldNames, types, offsets)  
  TypeInfo(type="union", fields=fields, size=maxSize, align=maxAlign)
}

parseUnionInfos <- function(sigs, envir=parent.frame())
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
      # parse union name
      name     <- sigs[[i]][[1]]
      name     <- gsub("[ \n\t]*","",name)
      # split union signature and field names
      tail     <- unlist( strsplit(sigs[[i]][[2]], "[}]") )
      sig      <- tail[[1]]
      if (length(tail) == 2)
        fields   <- unlist( strsplit( tail[[2]], "[ \n\t]+" ) ) 
      else 
        fields   <- NULL
      assign( name, makeUnionInfo(sig, fields, envir=envir), envir=envir )
    }
  }  
}


# ----------------------------------------------------------------------------
# raw backed struct's (S3 Class)

as.struct <- function(x, structName)
{
  attr(x, "struct") <- structName
  class(x) <- "struct"
  return(x)
}

new.struct <- function(structName)
{
  info <- getTypeInfo(structName)
  if (! info$type %in% c("struct","union") ) stop("no structure type")
  x <- raw( info$size )
  attr(x, "struct") <- structName
  class(x) <- "struct"
  return(x)
}

"$.struct" <- 
unpack.struct <- function(x, index)
{
  structName <- attr(x, "struct")
  structInfo <- getTypeInfo(structName)
  fieldInfos <- structInfo$fields
  offset <- fieldInfos[index,"offset"]
  if (is.na(offset)) stop("unknown field index '", index ,"'")
  fieldTypeName   <- as.character(fieldInfos[[index,"type"]])
  fieldTypeInfo   <- getTypeInfo(fieldTypeName)
  if (fieldTypeInfo$type %in% c("base","pointer")) {
    .unpack1(x, offset, fieldTypeInfo$signature)
  } else if ( !is.null(fieldTypeInfo$fields) ) {
    if (is.raw(x)) {
      size <- fieldTypeInfo$size
      as.struct( x[(offset+1):(offset+1+size-1)], structName=fieldTypeName)
    } else if (is.externalptr(x)) {
      as.struct( offsetPtr(x, offset), structName=fieldTypeName) 
    }
  } else {
    stop("invalid field type '", fieldTypeName,"' at field '", index )
  }
}

"$<-.struct" <- 
pack.struct <- function( x, index, value )
{
  structName   <- attr(x, "struct")
  structInfo   <- getTypeInfo(structName)
  fieldInfos   <- structInfo$fields
  offset <- fieldInfos[index,"offset"]
  if (is.na(offset)) stop("unknown field index '", index ,"'")
  fieldTypeName <- as.character(fieldInfos[index,"type"])
  fieldTypeInfo <- getTypeInfo(fieldTypeName)
  if (fieldTypeInfo$type == "base") {
    .pack1( x, offset, fieldTypeInfo$signature, value )
  }
  else if ( !is.null(fieldTypeInfo$fields) ) {
    size <- fieldTypeInfo$size
    x[(offset+1):(offset+1+size-1)] <- as.raw(value)
  }
  else {
    stop("invalid field type '", fieldTypeName,"' at field '", index )
  }
  return(x)
}

print.struct <- function(x, indent=0)
{
  structName <- attr(x, "struct")
  structInfo <- getTypeInfo(structName)
  fieldInfos <- structInfo$fields
  fieldNames <- rownames(fieldInfos)
  # print data without last
  cat( "struct ", structName, " {\n")
  for (i in seq(along=fieldNames)) 
  { 
    cat( rep("  ", indent+1), fieldNames[[i]] , ":" )
    val <- unpack.struct(x, fieldNames[[i]])
    if (typeof(val) == "externalptr") val <- .addrval(val)        
    if (class(val) == "struct") { print.struct(val, indent=indent+1) }
    else cat( val, "\n" )
  }
  cat( rep("  ", indent), "}\n")
}

