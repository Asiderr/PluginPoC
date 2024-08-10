include (${Board-Health-Monitor_SOURCE_DIR}/common/settings.cmake)

set(DATA_PROVIDER_DISK_DIR "${CMAKE_CURRENT_SOURCE_DIR}")
set(DATA_PROVIDER_DISK_BINARY "data-provider-disk.out")

file(GLOB DATA_PROVIDER_DISK_HEADER_LIST CONFIGURE_DEPENDS
    "${DATA_PROVIDER_DISK_DIR}/include/*/*.hpp"
    "${DATA_PROVIDER_DISK_DIR}/include/*.hpp"
)

file(GLOB DATA_PROVIDER_DISK_SRC_LIST CONFIGURE_DEPENDS
    "${DATA_PROVIDER_DISK_DIR}/src/*/*.cpp"
    "${DATA_PROVIDER_DISK_DIR}/src/*.cpp"
)

file(GLOB DATA_PROVIDER_DISK_APP_LIST CONFIGURE_DEPENDS
    "${DATA_PROVIDER_DISK_DIR}/app/*/*.cpp"
    "${DATA_PROVIDER_DISK_DIR}/app/*.cpp"
)

# Set the output directory for the binary
if("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${Board-Health-Monitor_SOURCE_DIR}/bin-debug/")
else()
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${Board-Health-Monitor_SOURCE_DIR}/bin/")
endif()

message(STATUS "Project source directory: ${Board-Health-Monitor_SOURCE_DIR}")
message(STATUS "Data-Provider-Disk directory: ${DATA_PROVIDER_DISK_DIR}")
message(STATUS "Data-Provider-Disk Header files: ${DATA_PROVIDER_DISK_HEADER_LIST}")
message(STATUS "Data-Provider-Disk Source files: ${DATA_PROVIDER_DISK_SRC_LIST}")
message(STATUS "Data-Provider-Disk App files: ${DATA_PROVIDER_DISK_APP_LIST}")

add_library(data_provider_disk_srccode ${DATA_PROVIDER_DISK_SRC_LIST} ${DATA_PROVIDER_DISK_HEADER_LIST})
target_include_directories(data_provider_disk_srccode PUBLIC "${DATA_PROVIDER_DISK_DIR}/include")

add_executable(${DATA_PROVIDER_DISK_BINARY} ${DATA_PROVIDER_DISK_APP_LIST})
target_link_libraries(${DATA_PROVIDER_DISK_BINARY} PRIVATE data_provider_disk_srccode)

target_include_directories(${DATA_PROVIDER_DISK_BINARY} PUBLIC "${DATA_PROVIDER_DISK_DIR}/include")

# TEST TO INCLUDE COMMON CODE WITH SPECIFIC COMPILE OPTION (DEFINE)
# If we want to shared code without any compilation options, use common_srccode
# In other cases, like this below, when we need to override DEFINEs, we need to create (recompile) our own srcode from sources
add_library(common_srccode_data_provider_disk STATIC ${COMMON_SRC_LIST} ${COMMON_HEADER_LIST})
target_include_directories(common_srccode_data_provider_disk PUBLIC "${COMMON_DIR}/include")

target_link_libraries(${DATA_PROVIDER_DISK_BINARY} PRIVATE common_srccode_data_provider_disk)
target_compile_definitions(common_srccode_data_provider_disk PRIVATE -DCOMMON_TEST_DEFINE_1=1000 -DCOMMON_TEST_DEFINE_2=2000)
