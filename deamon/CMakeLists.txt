include (${Board-Health-Monitor_SOURCE_DIR}/cmake/project-settings.cmake)

# Set the output directory for the binary
if("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${Board-Health-Monitor_SOURCE_DIR}/bin-debug/")
else()
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${Board-Health-Monitor_SOURCE_DIR}/bin/")
endif()

message(STATUS "Project source directory: ${Board-Health-Monitor_SOURCE_DIR}")
message(STATUS "Deamon directory: ${DEAMON_DIR}")
message(STATUS "Deamon Header files: ${DEAMON_HEADER_LIST}")
message(STATUS "Deamon Source files: ${DEAMON_SRC_LIST}")
message(STATUS "Deamon App files: ${DEAMON_APP_LIST}")

add_library(deamon_srccode ${DEAMON_SRC_LIST} ${DEAMON_HEADER_LIST})
target_include_directories(deamon_srccode PUBLIC "${DEAMON_DIR}/include")

add_executable(${DEAMON_BINARY} ${DEAMON_APP_LIST})
target_link_libraries(${DEAMON_BINARY} PRIVATE deamon_srccode)

target_include_directories(${DEAMON_BINARY} PUBLIC "${DEAMON_DIR}/include")
