cmake_minimum_required (VERSION 2.8)
project(LuaDynCall)
find_package(Lua51 REQUIRED)
add_subdirectory(dyncall)
add_subdirectory(src)
install(DIRECTORY share/dynport/ DESTINATION share/dynport )

