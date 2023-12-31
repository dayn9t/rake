# 递归添加子目录
function(cx_add_all_subdir root_dir)
    file(GLOB _subs ${root_dir}/*)
    #message(STATUS "_subs: " ${_subs})
    foreach(_sub ${_subs})
        if (IS_DIRECTORY ${_sub})
            if (EXISTS ${_sub}/CMakeLists.txt)
                add_subdirectory(${_sub})
                #message(STATUS "add_child subdirectory: " ${_sub})
            else()
                cx_add_all_subdir(${_sub})
            endif()
        endif()
    endforeach()
endfunction()


# 尝试添加目录
function(cx_add_dir _dir)
    if (EXISTS ${_dir}/CMakeLists.txt)
        add_subdirectory(${_dir})
        #message(STATUS "add_child dir: " ${_dir})
    endif()
endfunction()


# 递归遍历目录寻找头文件
function(cx_scan_include root_dir)
    file(GLOB _subs ${root_dir}/*)
    foreach(_sub ${_subs})
        if (IS_DIRECTORY ${_sub})
            if(${_sub} MATCHES "/include")
                include_directories(BEFORE ${_sub})
                message(STATUS "add include: " ${_sub})
            else()
                cx_scan_include(${_sub})
            endif()
        endif()
    endforeach()
endfunction()
