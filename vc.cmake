
set(CMAKE_INSTALL_PREFIX "D:/ws/local" CACHE PATH "Install path prefix" FORCE)

add_definitions(-D_CRT_SECURE_NO_WARNINGS)
add_definitions(-DNOMINMAX)
add_definitions(-D_WIN32_WINNT=0x0A01)
add_definitions(-wd4819)
add_definitions(/source-charset:utf-8)
#add_definitions(/std:c++latest)
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -Oi -arch:AVX2")

set(CX_LOCAL_INCLUDE "D:/ws/local/include" CACHE PATH "Local include dir")
set(CX_LOCAL_LIB "D:/ws/local/lib" CACHE PATH "Local lib dir")
