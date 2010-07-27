find_package(Lua51 REQUIRED)
find_package(DynLoad)
find_package(DynCall)
include_directories(${LUA_INCLUDE_DIR})

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
smartptr ldynload ldyncall 
# intutils ldynguess ldynstruct ldyntype
  LIBRARY DESTINATION .
)

install(FILES 
  dynload.lua dyncall.lua dynport.lua 
  #dynstruct.lua dyntype.lua 
  DESTINATION .
)

install(FILES
  SDL.dynport GL.dynport
  DESTINATION .
)

if(APPLE)
  set(CMAKE_MODULE_LINKER_FLAGS "-bundle -undefined dynamic_lookup")
  set(CMAKE_SHARED_MODULE_PREFIX "")
  add_library(cocoautil MODULE cocoautil.m)
endif(APPLE)

if(BOOST_FOUND)
endif(BOOST_FOUND)


