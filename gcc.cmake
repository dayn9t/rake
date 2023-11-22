
set(CX_FLAGS "-fPIC -Wall -Wno-unused-variable -Wno-unknown-pragmas")
set(CMAKE_CXX_FLAGS "${CX_FLAGS} -std=c++17 -fconcepts")
set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -rdynamic")
set(CMAKE_C_FLAGS "${CX_FLAGS} -std=c11 -Werror-implicit-function-declaration")
set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -rdynamic")

#target_link_options("--no-copy-dt-needed-entries")


#set(CMAKE_INSTALL_PREFIX "/usr/local")

#init_by(CX_LOCAL_INCLUDE "D:/msys32/usr/local/include" CACHE PATH "Local include dir")
#init_by(CX_LOCAL_LIB "D:/msys32/usr/local/lib" CACHE PATH "Local lib dir")