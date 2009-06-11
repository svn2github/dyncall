# TODO: Add comment
# 
# Author: dadler
###############################################################################


dynport(expat)

parser <- XML_ParserCreate(NULL)
#XML_StartElementHandler <- callback("pSp)v")
#XML_EndElementHandler   <- callback("pS)v")

onstart <- function(user,tag,attr)
{
  cat("begin", tag, "\n")  
}

onstop <- function(user,tag)
{
  cat("end",tag)  
}

cb.onstart <- new.callback("pSp)v", onstart )
cb.onstop  <- new.callback("pS)v",  onstop )

XML_SetElementHandler( parser, cb.onstart, cb.onstop ) 

text <- "
<hello>
  <world>
  </world>
</hello>
"

XML_Parse( parser, text, nchar(text), 1)
