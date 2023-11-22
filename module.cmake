include(src)

# 添加一个模块库组件
function(cx_add_lib _target _folder _namespace)
    cx_scan_sources(src _srcs)
    cx_scan_sources(include _incs)
    cx_assign_source_group(${_srcs} ${_incs})
    add_library("${_target}" ${_srcs} ${_incs})
    set_target_properties(${_target} PROPERTIES FOLDER ${_folder})
    #target_include_directories(${_target} PRIVATE  "inc")
    install(TARGETS ${_target} ARCHIVE DESTINATION lib)
    
    install(DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/include/${_namespace}" DESTINATION "include")
endfunction()


# 添加一个模块可执行组件
function(cx_add_bin _target _dir _folder)
    cx_scan_sources(${_dir} _srcs)
    cx_assign_source_group(${_srcs})
    add_executable("${_target}" ${_srcs})
    set_target_properties(${_target} PROPERTIES FOLDER ${_folder})
    #install(TARGETS ${_target} RUNTIME DESTINATION bin)
    #if(MSVC)
    #    install(FILES $<TARGET_PDB_FILE:${_target}> DESTINATION bin OPTIONAL)
    #endif()
endfunction()


# 添加一个so组件
function(cx_add_so _target _folder _namespace)
    cx_scan_sources(src _srcs)
    cx_scan_sources(include _incs)
    cx_assign_source_group(${_srcs} ${_incs})
    add_library("${_target}" SHARED ${_srcs} ${_incs})
    set_target_properties(${_target} PROPERTIES FOLDER ${_folder})
    install(TARGETS ${_target} 
        RUNTIME DESTINATION bin
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib)
    install(DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/include/${_namespace}" DESTINATION "include")
    if(MSVC)
        install(FILES $<TARGET_PDB_FILE:${_target}> DESTINATION bin OPTIONAL)
    endif()
    if(WIN32)
        SET_TARGET_PROPERTIES(${_target} PROPERTIES LINK_FLAGS /DEF:interface.def)
    endif(WIN32)
endfunction()


# 添加一个模块
function(cx_add_modx _target _namespace _so)
    MESSAGE(STATUS "module: " ${_target})
    if(${_so})
        cx_add_so(${_target} modules ${_namespace})
    else()
        cx_add_lib(${_target} modules ${_namespace})
    endif()
    cx_add_bin("${_target}-test" test modules)
    cx_add_bin("${_target}-bench" bench modules)

    foreach(v IN LISTS ARGN)
        add_dependencies(${_target} ${v})
        target_link_libraries(${_target} ${v})
        #MESSAGE(STATUS "lib:" ${v})
    endforeach()

    find_package(GTest REQUIRED)

    add_dependencies("${_target}-test" ${_target})
    add_dependencies("${_target}-bench" ${_target})
    target_link_libraries("${_target}-test" ${_target} ${GTEST_BOTH_LIBRARIES})
    target_link_libraries("${_target}-bench" ${_target})
endfunction()


# 添加一个模块-静态库
function(cx_add_mod _target _namespace)
    cx_add_modx(${_target} ${_namespace} False)
endfunction()


# 添加一个模块-动态库
function(cx_add_so_mod _target _namespace)
    cx_add_modx(${_target} ${_namespace} True)
endfunction()
