
# 搜索目录源文件列表
function(cx_scan_sources root_dir srcs)
    if(IS_ABSOLUTE ${root_dir})
        set(_path "${root_dir}")
    else()
        set(_path "${CMAKE_CURRENT_SOURCE_DIR}/${root_dir}")
    endif()

    if(WIN32)
        file(
            GLOB_RECURSE _srcs
            LIST_DIRECTORIES false
            "${_path}/*.c*"
            "${_path}/*.h*"
            "${_path}/*.md"
            "${_path}/*.def"
        )
    else()
        file(
            GLOB_RECURSE _srcs
            LIST_DIRECTORIES false
            "${_path}/*.c*"
            "${_path}/*.h*"
            "${_path}/*.md"
        )
    endif(WIN32)

    
    set(${srcs} ${_srcs} PARENT_SCOPE)
endfunction()


# 源程序按目录分组
function(cx_assign_source_group)
    foreach(_source IN ITEMS ${ARGN})
        if (IS_ABSOLUTE "${_source}")
            file(RELATIVE_PATH _source_rel "${CMAKE_CURRENT_SOURCE_DIR}" "${_source}")
        else()
            set(_source_rel "${_source}")
        endif()
        get_filename_component(_source_path "${_source_rel}" PATH)
        string(REPLACE "/" "\\" _group "${_source_path}")
        #message(STATUS "_group: " ${_group})
        #message(STATUS "_source: " ${_source})
        source_group("${_group}" FILES "${_source}")
    endforeach()
endfunction()
