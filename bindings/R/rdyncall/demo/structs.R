library(rdyncall)

# here, a external pointer is created and additionally

.dynfind()



x$lpfnWndProc <- new.callback("iiii", function(a,b,c,d) { } )

dynport(rmalloc)

sizeof <- function(x) UseMethod("sizeof")

sizeof.cstruct <- function(cstruct) cstruct[[".end","offset"]]
print(sizeof(WNDCLASSEX))

wndclass <- malloc(sizeof(WNDCLASSEX))

mywndproc <- function(hwnd,umsg,wparam, lparam) {  
  
}

style <- CS_OWNDC
callback <- new.callback("iiii)i", mywndproc)

.pack1( wndclass, WNDCLASSEX[["cbSize","offset"]], WNDCLASSEX[["cbSize","type"]], sizeof(WNDCLASSEX) )
.pack1( wndclass, WNDCLASSEX[["style","offset"]], WNDCLASSEX[["style","type"]], style )
.pack1( wndclass, WNDCLASSEX[["lpfnWndProc","offset"]], WNDCLASSEX[["lpfnWndProc","offset"]], callback )


wndclass$cbClsExtra <- 0
wndclass$cbWndExtra <- 0
wndclass$hInstance <- NULL
wndclass$hIcon <- NULL
wndclass$hCursor <- NULL
wndclass$hbrBackground <- NULL
with(wndclass,{
  lpszMenuName <- NULL
  lpszClassName <- NULL
})

atom <- RegisterClassEx(callback)
ex_style <- WS_EX_APPWINDOW
classname <- atom
windowname <- new.cstring("Hi there")
CreateWindowEx(ex_style,classname,windowname,style,x,y,width,height,parent,menu,instance,param)
