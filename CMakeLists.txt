cmake_minimum_required(VERSION 3.10)

project(
  Board-Health-Monitor
  VERSION 0.1.0
  DESCRIPTION "Board Health Monitor"
  LANGUAGES CXX
)

option(CMAKE_WERROR "Treat warnings as errors" ON)

# This will produce compile_commands.json file for clangd (vscode extension)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# C++ setup: standard, flags, compiler etc.
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)
set(CMAKE_CXX_EXTENSIONS OFF)

# For Debug target cmake -DCMAKE_BUILD_TYPE=Debug ..
add_compile_options(
  "$<$<CONFIG:DEBUG>:-O0;-g3;-ggdb>"
)

# For Release target (cmake -DCMAKE_BUILD_TYPE=Release ..)
add_compile_options(
  "$<$<CONFIG:RELEASE>:-O2>"
)

# For Development target (cmake -DCMAKE_BUILD_TYPE=Development ..)
add_compile_options(
  "$<$<CONFIG:DEVELOPMENT>:-O2>"
)

# Set a default build type if none was specified
set(default_build_type "Release")

if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
  message(STATUS "Setting build type to '${default_build_type}' as none was specified.")
  set(CMAKE_BUILD_TYPE "${default_build_type}" CACHE STRING "Choose the type of build." FORCE)
endif()

# add compiler option for specific compiler
if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
  message(STATUS "Configuring for Clang")
  add_compile_options("-Weverything" "-Wno-c++98-compat-pedantic")
elseif("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
  message(STATUS "Configuring for gcc")
  add_compile_options("-Wall" "-Wextra")
endif()

if (CMAKE_WERROR)
  add_compile_options("-Werror")
endif()

include(${CMAKE_SOURCE_DIR}/cmake/clang-tidy.cmake)
clang_tidy_enable()

include(${CMAKE_SOURCE_DIR}/cmake/cppcheck.cmake)
cppcheck_enable()

add_subdirectory(common)
add_subdirectory(daemon)
add_subdirectory(data-provider-battery)
add_subdirectory(data-provider-disk)
add_subdirectory(health-monitor)

install(TARGETS daemon.out health-monitor data-provider-battery.out data-provider-disk.out
  RUNTIME DESTINATION bin
  LIBRARY DESTINATION lib/${CMAKE_PROJECT_NAME}
  ARCHIVE DESTINATION lib/${CMAKE_PROJECT_NAME})

set(CPACK_PACKAGE_DESCRIPTION "Just another CPacke example")
set(CPACK_PACKAGE_VERSION "${CMAKE_PROJECT_VERSION}")
set(CPACK_PACKAGE_VENDOR "Infogain")
set(CPACK_PACKAGE_CONTACT "norbert.kaminski@infogain.com")
set(CPACK_PACKAGE_FILE_NAME "${CMAKE_PROJECT_NAME}-${CMAKE_PROJECT_VERSION}")
include (CPack)
