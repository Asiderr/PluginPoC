function (clang_tidy_enable)
    find_program(CLANG_TIDY_BIN NAMES "clang-tidy")
    if (CLANG_TIDY_BIN)
        message(STATUS "Found clang-tidy: " ${CLANG_TIDY_BIN})

        set(CLANG_TIDY_OPTIONS "--config-file=${CMAKE_SOURCE_DIR}/.config/.clang-tidy.config")
        message("clang-tidy options: " ${CLANG_TIDY_OPTIONS})

        if (CMAKE_WERROR)
            message(STATUS "clang-tidy: Treating warnings as errors")
            set(CLANG_TIDY_OPTIONS "${CLANG_TIDY_OPTIONS};-warnings-as-errors=*")
        endif()

        # CMake has clang-tidy support built-in since version 3.6
        # https://cmake.org/cmake/help/v3.6/variable/CMAKE_LANG_CLANG_TIDY.html
        # The format is: "<path-to-clang-tidy>;<options>"
        set(CMAKE_CXX_CLANG_TIDY "${CLANG_TIDY_BIN};${CLANG_TIDY_OPTIONS}" PARENT_SCOPE)

        message(STATUS "clang-tidy enabled: " ${CMAKE_CXX_CLANG_TIDY})

    else()
        message(ERROR "clang-tidy not found")
    endif()
endfunction()
