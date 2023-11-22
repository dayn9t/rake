
# 添加一组示例程序程序，参数列表是依赖的内部库
function(cx_add_samples _prefix)

    file(GLOB_RECURSE cpps RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} *.cpp)

    foreach(cpp_file ${cpps})
        get_filename_component(cpp_name ${cpp_file} NAME_WE)
        set(_target "${_prefix}-sample-${cpp_name}")
        MESSAGE(STATUS "sample: " ${_target})
        add_executable(${_target} ${cpp_file})
        set_target_properties(${_target} PROPERTIES FOLDER samples)

        foreach(v IN LISTS ARGN)
            add_dependencies(${_target} ${v})
            target_link_libraries(${_target} ${v})
            #MESSAGE(STATUS "lib:" ${v})
        endforeach()

        #install(TARGETS ${_target} RUNTIME DESTINATION bin)
        if(MSVC)
            #install(FILES $<TARGET_PDB_FILE:${_target}> DESTINATION bin OPTIONAL)
        endif()
    endforeach()

endfunction()
