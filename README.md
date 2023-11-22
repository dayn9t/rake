# RAKE 说明

本项目利用CMake为C++项目提供了一种类Rust项目的组织模式，大幅减少了复杂项目繁琐的CMake配置工作。

- 适用平台: 
  - Linux/GCC
  - Windows/VC++, 早年曾有过测试
  - 其他CMake适应平台, 未测试
- 适合用户: 对CMake有所了解的用户
- 项目依赖: GTest

项目在内部使用多年, 但无力完善文档等内容, 拿出来抛砖引玉, 希望对有需求的朋友有所裨益.

## 安装方法

- 通过建立把本项目链接到目标项目cmake目录下，例如：
```
mklink /D target\project\dir\cmake this\project\dir # for Windows
sudo ln -s this/project/dir target/project/dir/cmake # for Linux
```

## 名词解释

- 应用程序: 项目生成的可执行程序
- 功能模块, 简称模块. 包括三者: 核心库, 及其单元/性能测试程序
  - 静态模块: 核心库是静态库
  - 动态模块: 核心库是动态库
- 示例程序, 用于演示功能模块或其他用途的示例程序


## 项目目录结构

遵循 "约定胜于配置" 的指导思想, 依照以下目录组织管理项目.

```txt
├── apps                    # 应用程序集合
│   ├── app1                # 一个应用程序
│   │   ├── ...             # 应用程序的其他文件
│   │   └── CMakeLists.txt  # 2. 应用程序CMake文件
│   └── ...                 # 其他应用程序                 
├── cmake                   # 本项目的副本或链接
├── modules                 # 模块集合, 模块: 动态库/静态库及其测试
│   ├── module1             # 一个功能模块
│   │   ├── bench           # 模块性能测试目录
│   │   ├── include         # 模块的头文件
│   │   ├── src             # 模块源程序
│   │   ├── test            # 模块单元测试
│   │   └── CMakeLists.txt  # 3. 模块CMake文件
│   └── ...                 # 其他模块
├── samples                 # 示例程序集合
│   ├── sample1             # 一个示例
│   │   ├── ...             # 示例的其他文件
│   │   └── CMakeLists.txt  # 4. 示例CMake文件
│   └── ...                 # 其他示例
└── CMakeLists.txt          # 1. 项目主CMake文件
```

以下四个CMake文件, 都有专有的格式:

1. 项目主CMake文件
```cmake
cmake_minimum_required(VERSION 3.5)
project(project1)

# 用户全局搜索路径举例
SET(CMAKE_PREFIX_PATH /home/ws/stage)
# 用户全局包含目录设置举例
include_directories(/home/ws/cx/include)
# 用户全局包含目录设置举例
add_definitions(-DBOOST_ALL_DYN_LINK)
# 用户全局包依赖举例
find_package(Boost COMPONENTS regex log thread REQUIRED)
# 用户全局链接库举例
link_libraries(jemalloc)

SET(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)
include(main)

```

2. 应用程序CMake文件
```cmake
# 添加应用程序app1, 依赖module1模块
cx_add_app(app1 module1)
```

3. 功能模块CMake文件
```cmake
# 添加静态模块module1, 名字空间为ns1
cx_add_mod(module1 ns1)
# 或者: 添加动态模块module1
cx_add_so_mod(module1 ns1)
```

4. 示例程序CMake文件
```cmake
# 添加示例sample1, 依赖module1模块
cx_add_samples(sample1 module1)
```

注意: 2/3/4三种CMake文件中都可以添加私有的变量/搜索路径/依赖包等条目.
