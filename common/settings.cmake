set(COMMON_DIR "${Board-Health-Monitor_SOURCE_DIR}/common/")

file(GLOB COMMON_HEADER_LIST CONFIGURE_DEPENDS
    "${COMMON_DIR}/include/*/*.hpp"
    "${COMMON_DIR}/include/*.hpp"
)

file(GLOB COMMON_SRC_LIST CONFIGURE_DEPENDS
    "${COMMON_DIR}/src/*/*.cpp"
    "${COMMON_DIR}/src/*.cpp"
)
