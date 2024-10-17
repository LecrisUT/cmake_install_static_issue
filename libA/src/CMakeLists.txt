target_sources(libA PRIVATE hello.cpp)
target_sources(libA PUBLIC
        FILE_SET libA_header TYPE HEADERS FILES
        hello.h
)
target_include_directories(libA PUBLIC
        "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>"
        "$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>"
)
set_target_properties(libA PROPERTIES
        OUTPUT_NAME A
        EXPORT_NAME A
        POSITION_INDEPENDENT_CODE True
)

if (LIBA_INSTALL)
    install(TARGETS libA
            EXPORT libATargets
            FILE_SET libA_header
    )
endif ()
