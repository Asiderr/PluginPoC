set(DATA_PROVIDER_BATTERY_DIR "${CMAKE_CURRENT_SOURCE_DIR}")
set(DATA_PROVIDER_BATTERY_BINARY "data-provider-battery.out")

file(GLOB DATA_PROVIDER_BATTERY_HEADER_LIST CONFIGURE_DEPENDS
    "${DATA_PROVIDER_BATTERY_DIR}/include/*/*.hpp"
    "${DATA_PROVIDER_BATTERY_DIR}/include/*.hpp"
)

file(GLOB DATA_PROVIDER_BATTERY_SRC_LIST CONFIGURE_DEPENDS
    "${DATA_PROVIDER_BATTERY_DIR}/src/*/*.cpp"
    "${DATA_PROVIDER_BATTERY_DIR}/src/*.cpp"
)

file(GLOB DATA_PROVIDER_BATTERY_APP_LIST CONFIGURE_DEPENDS
    "${DATA_PROVIDER_BATTERY_DIR}/app/*/*.cpp"
    "${DATA_PROVIDER_BATTERY_DIR}/app/*.cpp"
)

# Set the output directory for the binary
if("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${Board-Health-Monitor_SOURCE_DIR}/bin-debug/")
else()
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${Board-Health-Monitor_SOURCE_DIR}/bin/")
endif()

message(STATUS "Project source directory: ${Board-Health-Monitor_SOURCE_DIR}")
message(STATUS "Data-Provider-Battery directory: ${DATA_PROVIDER_BATTERY_DIR}")
message(STATUS "Data-Provider-Battery Header files: ${DATA_PROVIDER_BATTERY_HEADER_LIST}")
message(STATUS "Data-Provider-Battery Source files: ${DATA_PROVIDER_BATTERY_SRC_LIST}")
message(STATUS "Data-Provider-Battery App files: ${DATA_PROVIDER_BATTERY_APP_LIST}")

add_library(data_provider_battery_srccode ${DATA_PROVIDER_BATTERY_SRC_LIST} ${DATA_PROVIDER_BATTERY_HEADER_LIST})
target_include_directories(data_provider_battery_srccode PUBLIC "${DATA_PROVIDER_BATTERY_DIR}/include")

add_executable(${DATA_PROVIDER_BATTERY_BINARY} ${DATA_PROVIDER_BATTERY_APP_LIST})
target_link_libraries(${DATA_PROVIDER_BATTERY_BINARY} PRIVATE data_provider_battery_srccode)

target_include_directories(${DATA_PROVIDER_BATTERY_BINARY} PUBLIC "${DATA_PROVIDER_BATTERY_DIR}/include")
