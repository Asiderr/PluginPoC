include (${Board-Health-Monitor_SOURCE_DIR}/cmake/project-settings.cmake)

# Set the output directory for the binary
if("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${Board-Health-Monitor_SOURCE_DIR}/bin-debug/")
else()
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${Board-Health-Monitor_SOURCE_DIR}/bin/")
endif()

# Debug messages
message(STATUS "Project source directory: ${Board-Health-Monitor_SOURCE_DIR}")
message(STATUS "Health-Monitor directory: ${HEALTH_MONITOR_DIR}")
message(STATUS "Health-Monitor Header files: ${HEALTH_MONITOR_HEADER_LIST}")
message(STATUS "Health-Monitor Source files: ${HEALTH_MONITOR_SRC_LIST}")
message(STATUS "Health-Monitor App files: ${HEALTH_MONITOR_APP_LIST}")

add_library(health_monitor_srccode ${HEALTH_MONITOR_SRC_LIST} ${HEALTH_MONITOR_HEADER_LIST})
target_include_directories(health_monitor_srccode PUBLIC "${HEALTH_MONITOR_DIR}/include")

add_library(${HEALTH_MONITOR_LIBRARY} SHARED ${HEALTH_MONITOR_APP_LIST})
target_link_libraries(${HEALTH_MONITOR_LIBRARY} PRIVATE health_monitor_srccode)

target_include_directories(${HEALTH_MONITOR_LIBRARY} PUBLIC "${HEALTH_MONITOR_DIR}/include")
