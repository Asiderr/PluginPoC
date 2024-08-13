function (cppcheck_enable)
    find_program(CPPCHECK_BIN NAMES "cppcheck")
    if (CPPCHECK_BIN)
        message(STATUS "Found cppcheck: ${CPPCHECK_BIN}")

        # Read the cppcheck options from the config file
        # The file format is:
        # --enable=all
        # --enable=style
        # --enable=performance
        # Usually, the command line is separated by spaces, example:
        # cppcheck --enable=all --enable=style --enable=performance
        # But CMake needs a list of options in format:
        # cppcheck;--enable=all;--enable=style;--enable=performance
        file(READ "${CMAKE_SOURCE_DIR}/.config/.cppcheck.config" CPPCHECK_OPTIONS)
        string(STRIP "${CPPCHECK_OPTIONS}" CPPCHECK_OPTIONS)
        string(REPLACE "\n" ";" CPPCHECK_OPTIONS_LIST "${CPPCHECK_OPTIONS}")

        list(APPEND CPPCHECK_OPTIONS_LIST "--checkers-report=./cppcheck-report.txt")

        if (CMAKE_WERROR)
            message(STATUS "cppcheck: Treating warnings as errors")
            list(APPEND CPPCHECK_OPTIONS_LIST "--error-exitcode=1")
        endif()

        set(CMAKE_CXX_CPPCHECK "${CPPCHECK_BIN};${CPPCHECK_OPTIONS_LIST}" PARENT_SCOPE)

        message(STATUS "Cppcheck is enabled with options: ${CPPCHECK_OPTIONS_LIST}")
    else ()
        message(ERROR "cppcheck not found")
    endif ()
endfunction()
