include_directories(${LUA_INCLUDE_DIR})
include_directories(${DYNCALL_INCLUDE_DIR} ${DYNLOAD_INCLUDE_DIR})
# Lua:
set(CMAKE_SHARED_MODULE_PREFIX "")

# -fPIC and AMD64
if("${CMAKE_SYSTEM_PROCESSOR}" STREQUAL "x86_64")
add_definitions("-fPIC")
endif()

add_library(smartptr MODULE smartptr.c)
add_library(intutils MODULE intutils.cpp)
add_library(ldynload MODULE ldynload.c)
add_library(ldyncall MODULE ldyncall.c)
add_library(ldynguess MODULE ldynguess.c)
add_library(ldynstruct MODULE ldynstruct.c)
add_library(ldyntype MODULE ldyntype.c)
add_library(larray MODULE larray.c dyntype.c)
target_link_libraries(ldynload ${DYNLOAD_LIBRARIES})
target_link_libraries(ldyncall ${DYNCALL_LIBRARIES})


install(TARGETS 
smartptr ldynload 
ldyncall 
larray intutils ldynguess 
# ldynstruct ldyntype
  LIBRARY DESTINATION lib/lua
)

install(FILES 
  dynload.lua dyncall.lua dynport.lua array.lua
  #dynstruct.lua dyntype.lua 
  DESTINATION lib/lua
)

#install(FILES
#  SDL.dynport GL.dynport gl3.dynport SDL_image.dynport
#  DESTINATION share/dynport
#)

if(APPLE)
  set(CMAKE_MODULE_LINKER_FLAGS "-bundle -undefined dynamic_lookup")
  add_library(cocoautil MODULE cocoautil.m)
  install(FILES cocoautil.dynport DESTINATION share/dynport)
endif(APPLE)


