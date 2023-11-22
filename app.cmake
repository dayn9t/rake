include(src)

# 递归搜索目录，并安装到bin
function(cx_install_bin _path)
    file(GLOB_RECURSE _shs LIST_DIRECTORIES false ${_path})
    #MESSAGE(STATUS "_shs:" ${_shs})
    install(PROGRAMS ${_shs} DESTINATION bin OPTIONAL)
endfunction()


# 添加一个应用程序，额外参数列表是依赖的内部库
function(cx_add_app _target)
    MESSAGE(STATUS "app: " ${_target})
    cx_scan_sources(${CMAKE_CURRENT_SOURCE_DIR} _srcs)
    cx_assign_source_group(${_srcs})
    add_executable(${_target} ${_srcs})
    set_target_properties(${_target} PROPERTIES FOLDER "apps")

    foreach(v IN LISTS ARGN)
        add_dependencies(${_target} ${v})
        target_link_libraries(${_target} ${v})
        #MESSAGE(STATUS "lib:" ${v})
    endforeach()

    install(TARGETS ${_target} RUNTIME DESTINATION bin)

    if(MSVC)
        install(FILES $<TARGET_PDB_FILE:${_target}> DESTINATION bin OPTIONAL)
    endif()

    cx_install_bin("*.sh")
endfunction()
