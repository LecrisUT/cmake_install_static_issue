cmake_minimum_required(VERSION 3.26...3.30)

project(libB)

option(LIBB_SHARED_LIBS "libB: Build as shared library" ${PROJECT_IS_TOP_LEVEL})
option(LIBB_INSTALL "libB: Install library" ${PROJECT_IS_TOP_LEVEL})

if (LIBB_INSTALL AND NOT LIBB_SHARED_LIBS)
    # In order to install libB static library, all dependencies must be installed as well
    option(LIBA_INSTALL "libB: Override" ON)
endif ()
add_subdirectory(third_party/libA)

set(BUILD_SHARED_LIBS ${LIBB_SHARED_LIBS})
include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

add_library(libB)
add_library(libB::B ALIAS libB)

add_subdirectory(src)

if (LIBB_INSTALL)
    install(EXPORT libBTargets
            FILE libBTargets.cmake
            NAMESPACE libB::
            DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/libB
    )
    configure_package_config_file(
            cmake/libBConfig.cmake.in
            libBConfig.cmake
            INSTALL_DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/libB
    )
    install(FILES ${CMAKE_CURRENT_BINARY_DIR}/libBConfig.cmake
            DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/libB
    )
endif ()
