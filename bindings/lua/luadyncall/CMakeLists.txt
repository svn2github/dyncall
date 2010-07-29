cmake_minimum_required (VERSION 2.6)
project(luadyncall)
find_package(Lua51 REQUIRED)
set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/buildsys/cmake/Modules)
find_package(DynLoad REQUIRED)
find_package(DynCall REQUIRED)
add_subdirectory(src)


