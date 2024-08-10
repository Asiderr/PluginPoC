set(HEALTH_MONITOR_DIR "${CMAKE_CURRENT_SOURCE_DIR}")
set(HEALTH_MONITOR_BINARY "health-monitor.out")

file(GLOB HEALTH_MONITOR_HEADER_LIST CONFIGURE_DEPENDS
    "${HEALTH_MONITOR_DIR}/include/*/*.hpp"
    "${HEALTH_MONITOR_DIR}/include/*.hpp"
)

file(GLOB HEALTH_MONITOR_SRC_LIST CONFIGURE_DEPENDS
    "${HEALTH_MONITOR_DIR}/src/*/*.cpp"
    "${HEALTH_MONITOR_DIR}/src/*.cpp"
)

file(GLOB HEALTH_MONITOR_APP_LIST CONFIGURE_DEPENDS
    "${HEALTH_MONITOR_DIR}/app/*/*.cpp"
    "${HEALTH_MONITOR_DIR}/app/*.cpp"
)

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

add_executable(${HEALTH_MONITOR_BINARY} ${HEALTH_MONITOR_APP_LIST})
target_link_libraries(${HEALTH_MONITOR_BINARY} PRIVATE health_monitor_srccode)

target_include_directories(${HEALTH_MONITOR_BINARY} PUBLIC "${HEALTH_MONITOR_DIR}/include")
