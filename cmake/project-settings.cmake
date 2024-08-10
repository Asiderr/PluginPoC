################################### COMMON ####################################

set(COMMON_DIR "${Board-Health-Monitor_SOURCE_DIR}/common/")

file(GLOB COMMON_HEADER_LIST CONFIGURE_DEPENDS
    "${COMMON_DIR}/include/*/*.hpp"
    "${COMMON_DIR}/include/*.hpp"
)

file(GLOB COMMON_SRC_LIST CONFIGURE_DEPENDS
    "${COMMON_DIR}/src/*/*.cpp"
    "${COMMON_DIR}/src/*.cpp"
)


################################### DEAMON ####################################

set(DEAMON_DIR "${CMAKE_CURRENT_SOURCE_DIR}")
set(DEAMON_BINARY "deamon.out")

file(GLOB DEAMON_HEADER_LIST CONFIGURE_DEPENDS
    "${DEAMON_DIR}/include/*/*.hpp"
    "${DEAMON_DIR}/include/*.hpp"
)

file(GLOB DEAMON_SRC_LIST CONFIGURE_DEPENDS
    "${DEAMON_DIR}/src/*/*.cpp"
    "${DEAMON_DIR}/src/*.cpp"
)

file(GLOB DEAMON_APP_LIST CONFIGURE_DEPENDS
    "${DEAMON_DIR}/app/*/*.cpp"
    "${DEAMON_DIR}/app/*.cpp"
)

############################### HEALTH MONITOR ################################

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

############################ DATA_PROVIDER_BATTERY ############################

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

############################ DISK_PROVIDER_BATTERY ############################

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
