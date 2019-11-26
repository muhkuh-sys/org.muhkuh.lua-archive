cmake_minimum_required(VERSION 3.2.3)

PROJECT("lz4")

INCLUDE(ExternalProject)

# Python is used for some test scripts.
FIND_PACKAGE(PythonInterp 2.7 REQUIRED)

SET(VERSION_EXTERNAL "1.9.2")


#----------------------------------------------------------------------------
#
# Build the project.
#
SET(PRJ_CMAKE_ARGS "")

LIST(APPEND PRJ_CMAKE_ARGS "-DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}")
LIST(APPEND PRJ_CMAKE_ARGS "-DPRJ_DIR=${PRJ_DIR}")
LIST(APPEND PRJ_CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX=${CMAKE_BINARY_DIR}/install")

LIST(APPEND PRJ_CMAKE_ARGS "-DBUILD_SHARED_LIBS=OFF")
LIST(APPEND PRJ_CMAKE_ARGS "-DBUILD_STATIC_LIBS=ON")
LIST(APPEND PRJ_CMAKE_ARGS "-DLZ4_POSITION_INDEPENDENT_LIB=ON")


ExternalProject_Add(TARGET_lz4
                    PREFIX ${CMAKE_CURRENT_BINARY_DIR}/lz4-${VERSION_EXTERNAL}
                    URL ${CMAKE_CURRENT_SOURCE_DIR}/lz4-${VERSION_EXTERNAL}.tar.gz
                    URL_HASH SHA1=4dc36f29d7b4e5b45b114be2674068200714abb3
                    SOURCE_SUBDIR contrib/cmake_unofficial
                    CMAKE_ARGS ${PRJ_CMAKE_ARGS}
                    INSTALL_COMMAND make install
)
