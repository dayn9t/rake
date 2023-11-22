
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

option(BUILD_EXAMPLES "Build examples applications." ON)
set(CMAKE_CONFIGURATION_TYPES "Debug;Release" CACHE PATH "Install path prefix" FORCE)
#init_by(CMAKE_DEBUG_POSTFIX "d")
if(MSVC)
    include(vc)
else()
    include(gcc)
endif()

set(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR}/bin)
set(LIBRARY_OUTPUT_PATH ${CMAKE_BINARY_DIR}/lib)

include_directories(${CX_LOCAL_INCLUDE})
link_directories(${LIBRARY_OUTPUT_PATH} ${CX_LOCAL_LIB})

include(dir)
include(module)
include(app)
include(sample)

cx_scan_include(${CMAKE_SOURCE_DIR}/modules)
cx_add_all_subdir(${CMAKE_SOURCE_DIR}/apps)
cx_add_all_subdir(${CMAKE_SOURCE_DIR}/modules)
cx_add_all_subdir(${CMAKE_SOURCE_DIR}/samples)

cx_install_bin("bin/*")

message(STATUS "CMAKE_CXX_FLAGS: " ${CMAKE_CXX_FLAGS})
message(STATUS "CMAKE_CXX_FLAGS_RELEASE: " ${CMAKE_CXX_FLAGS_RELEASE})
message(STATUS "CMAKE_CXX_FLAGS_DEBUG: " ${CMAKE_CXX_FLAGS_DEBUG})

message(STATUS "CMAKE_C_FLAGS: " ${CMAKE_C_FLAGS})
message(STATUS "CMAKE_C_FLAGS_RELEASE: " ${CMAKE_C_FLAGS_RELEASE})
message(STATUS "CMAKE_C_FLAGS_DEBUG: " ${CMAKE_C_FLAGS_DEBUG})

message(STATUS "CMAKE_INSTALL_PREFIX: " ${CMAKE_INSTALL_PREFIX})
message(STATUS "CX_LOCAL_INCLUDE: " ${CX_LOCAL_INCLUDE})
message(STATUS "CX_LOCAL_LIB: " ${CX_LOCAL_LIB})
message(STATUS "LIBRARY_OUTPUT_PATH: " ${LIBRARY_OUTPUT_PATH})

message(STATUS "CMAKE_HOST_SYSTEM_PROCESSOR: " ${CMAKE_HOST_SYSTEM_PROCESSOR})
message(STATUS "CMAKE_SYSTEM_PROCESSOR: " ${CMAKE_SYSTEM_PROCESSOR})
message(STATUS "CMAKE_C_COMPILER: " ${CMAKE_C_COMPILER})
message(STATUS "CMAKE_CXX_COMPILER: " ${CMAKE_CXX_COMPILER})
