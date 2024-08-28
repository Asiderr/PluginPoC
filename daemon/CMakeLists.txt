include (${Board-Health-Monitor_SOURCE_DIR}/cmake/project-settings.cmake)

# AWS SDK components
set(AWSSDK_ROOT_DIR, "/usr/")
set(SERVICE_COMPONENTS s3)
find_package(AWSSDK REQUIRED COMPONENTS ${SERVICE_COMPONENTS})
find_package(ZLIB REQUIRED)

# Set the output directory for the binary
if("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${Board-Health-Monitor_SOURCE_DIR}/bin-debug/")
else()
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${Board-Health-Monitor_SOURCE_DIR}/bin/")
endif()

message(STATUS "Project source directory: ${Board-Health-Monitor_SOURCE_DIR}")
message(STATUS "Daemon directory: ${DAEMON_DIR}")
message(STATUS "Daemon Header files: ${DAEMON_HEADER_LIST}")
message(STATUS "Daemon Source files: ${DAEMON_SRC_LIST}")
message(STATUS "Daemon App files: ${DAEMON_APP_LIST}")

add_library(daemon_srccode ${DAEMON_SRC_LIST} ${DAEMON_HEADER_LIST})
target_include_directories(daemon_srccode PUBLIC "${DAEMON_DIR}/include")

add_executable(${DAEMON_BINARY} ${DAEMON_APP_LIST})
target_link_libraries(${DAEMON_BINARY} PRIVATE daemon_srccode ${AWSSDK_LINK_LIBRARIES})

target_include_directories(${DAEMON_BINARY} PUBLIC "${DAEMON_DIR}/include")
