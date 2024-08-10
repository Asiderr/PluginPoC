include (${Board-Health-Monitor_SOURCE_DIR}/common/settings.cmake)

message(STATUS "Project source directory: ${Board-Health-Monitor_SOURCE_DIR}")
message(STATUS "Common directory: ${COMMON_DIR}")
message(STATUS "Common Header files: ${COMMON_HEADER_LIST}")
message(STATUS "Common Source files: ${COMMON_SRC_LIST}")

add_library(common_srccode STATIC ${COMMON_SRC_LIST} ${COMMON_HEADER_LIST})
target_include_directories(common_srccode PUBLIC "${COMMON_DIR}/include")

