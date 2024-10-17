target_sources(libB PRIVATE hi.cpp)
target_sources(libB PUBLIC
        FILE_SET libB_header TYPE HEADERS FILES
        hi.h
)
target_include_directories(libB PUBLIC
        "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>"
        "$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>"
)
target_link_libraries(libB PRIVATE $<BUILD_LOCAL_INTERFACE:libA::A>)
set_target_properties(libB PROPERTIES
        OUTPUT_NAME B
        EXPORT_NAME B
        POSITION_INDEPENDENT_CODE True
)

if (LIBB_INSTALL)
    install(TARGETS libB
            EXPORT libBTargets
            FILE_SET libB_header
    )
endif ()
