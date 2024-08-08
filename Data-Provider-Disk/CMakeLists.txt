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
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${Board-Health-Monitor_SOURCE_DIR}/bin/")

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
