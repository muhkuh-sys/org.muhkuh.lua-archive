cmake_minimum_required(VERSION 3.2.3)

PROJECT("bzip2")

INCLUDE(ExternalProject)

# Python is used for some test scripts.
FIND_PACKAGE(PythonInterp 2.7 REQUIRED)

SET(VERSION_EXTERNAL "1.0.6")


#----------------------------------------------------------------------------
#
# Build the project.
#
SET(PRJ_CMAKE_ARGS "")

LIST(APPEND PRJ_CMAKE_ARGS "-DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}")
#LIST(APPEND PRJ_CMAKE_ARGS "-DPRJ_DIR=${PRJ_DIR}")
LIST(APPEND PRJ_CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX=${CMAKE_BINARY_DIR}/install")
LIST(APPEND PRJ_CMAKE_ARGS "-DVERSION_EXTERNAL=${VERSION_EXTERNAL}")

ExternalProject_Add(TARGET_bzip2
                    PREFIX ${CMAKE_CURRENT_BINARY_DIR}/bzip2-${VERSION_EXTERNAL}
                    URL ${CMAKE_CURRENT_SOURCE_DIR}/bzip2-${VERSION_EXTERNAL}.tar.gz
                    URL_HASH SHA1=3f89f861209ce81a6bab1fd1998c0ef311712002
                    PATCH_COMMAND "${PYTHON_EXECUTABLE}" ${CMAKE_HOME_DIRECTORY}/cmake/tools/apply_patches.py --working-folder ${CMAKE_CURRENT_BINARY_DIR}/bzip2-${VERSION_EXTERNAL}/src/TARGET_bzip2 --copy-folder ${CMAKE_CURRENT_SOURCE_DIR}/copy_over
                    CMAKE_ARGS ${PRJ_CMAKE_ARGS}
                    INSTALL_COMMAND make install
)
