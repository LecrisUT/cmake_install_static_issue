cmake_minimum_required(VERSION 3.26...3.30)

project(libA)

option(LIBA_SHARED_LIBS "libA: Build as shared library" ${PROJECT_IS_TOP_LEVEL})
option(LIBA_INSTALL "libA: Install library" ${PROJECT_IS_TOP_LEVEL})

set(BUILD_SHARED_LIBS ${LIBA_SHARED_LIBS})
include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

add_library(libA)
add_library(libA::A ALIAS libA)

add_subdirectory(src)

if (LIBA_INSTALL)
    install(EXPORT libATargets
            FILE libATargets.cmake
            NAMESPACE libA::
            DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/libA
    )
    configure_package_config_file(
            cmake/libAConfig.cmake.in
            libAConfig.cmake
            INSTALL_DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/libA
    )
    install(FILES ${CMAKE_CURRENT_BINARY_DIR}/libAConfig.cmake
            DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/libA
    )
endif ()
