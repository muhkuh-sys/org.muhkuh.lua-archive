cmake_minimum_required(VERSION 3.2.3)

PROJECT("libarchive")

INCLUDE(ExternalProject)

# Python is used for some test scripts.
FIND_PACKAGE(PythonInterp 2.7 REQUIRED)

SET(VERSION_EXTERNAL "3.2.2")


#----------------------------------------------------------------------------
#
# Build the project.
#
IF(${CMAKE_CROSSCOMPILING})
	IF("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
		# Get the prefix of the compiler.
		GET_FILENAME_COMPONENT(GCC_BASENAME ${CMAKE_C_COMPILER} NAME)
		IF(${GCC_BASENAME} MATCHES "([^-]+-[^-]+-[^-]+)-gcc")
			SET(CONFIGURE_HOST "--host=${CMAKE_MATCH_1}")
		ELSE(${GCC_BASENAME} MATCHES "([^-]+-[^-]+-[^-]+)-gcc")
			MESSAGE(FATAL_ERROR "Failed to extract the compiler prefix from the C compiler ${CMAKE_C_COMPILER}")
		ENDIF(${GCC_BASENAME} MATCHES "([^-]+-[^-]+-[^-]+)-gcc")
	ELSE("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
		MESSAGE(FATAL_ERROR "Cross compiling detected, but not using GCC. This is currently not supported by the CMake wrapper for OpenSSL.")
	ENDIF("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
ELSE(${CMAKE_CROSSCOMPILING})
	SET(CONFIGURE_HOST "")
ENDIF(${CMAKE_CROSSCOMPILING})



# Get the includes and library for zlib.
MESSAGE("net.zlib-zlib_DIR: ${net.zlib-zlib_DIR}")
FIND_PACKAGE(net.zlib-zlib REQUIRED CONFIG)
GET_TARGET_PROPERTY(ZLIB_LIBRARIES net.zlib-zlib::zlibstatic LOCATION)
SET(ZLIB_INCLUDE_DIR ${net.zlib-zlib_INCLUDE_DIR})
MESSAGE("ZLIB_LIBRARIES: ${ZLIB_LIBRARIES}")
MESSAGE("ZLIB_INCLUDE_DIR: ${ZLIB_INCLUDE_DIR}")
SET(ZLIB_LIB_DIR ${ZLIB_INCLUDE_DIR}/../lib)
SET(ZLIB_LIB "z")

# Get the includes and libraries for bzip2
SET(BZIP2_LIB_DIR "${CMAKE_BINARY_DIR}/bzip2/install/lib")
SET(BZIP2_LIB "bzip2")
SET(BZIP2_INCLUDE_DIR "${CMAKE_BINARY_DIR}/bzip2/install/include")

# Get the includes and libraries for lzma.
SET(LZMA_LIB_DIR "${CMAKE_BINARY_DIR}/lzma/install/lib")
SET(LZMA_LIB "lzma")
SET(LZMA_INCLUDE_DIR "${CMAKE_BINARY_DIR}/lzma/install/include")

# Get the includes and libraries for lzo2.
SET(LZO2_LIB_DIR "${CMAKE_BINARY_DIR}/lzo/install/lib")
SET(LZO2_LIB "lzo2")
SET(LZO2_INCLUDE_DIR "${CMAKE_BINARY_DIR}/lzo/install/include")

# Get the includes and libraries for lz4.
SET(LZ4_LIB_DIR "${CMAKE_BINARY_DIR}/lz4/install/lib")
SET(LZ4_LIB "lz4")
SET(LZ4_INCLUDE_DIR "${CMAKE_BINARY_DIR}/lz4/install/include")


ExternalProject_Add(TARGET_libarchive
                    PREFIX ${CMAKE_CURRENT_BINARY_DIR}/libarchive-${VERSION_EXTERNAL}
                    URL ${CMAKE_CURRENT_SOURCE_DIR}/libarchive-${VERSION_EXTERNAL}.tar.gz
                    URL_HASH SHA1=ccf14e3b4ec7c6b242cf07062dd40e82a17485a5
                    CONFIGURE_COMMAND ${CMAKE_COMMAND} -E env "CPPFLAGS=-I${ZLIB_INCLUDE_DIR} -I${BZIP2_INCLUDE_DIR} -I${LZMA_INCLUDE_DIR} -I${LZO2_INCLUDE_DIR} -I${LZ4_INCLUDE_DIR}" "LDFLAGS=-L${ZLIB_LIB_DIR} -L${BZIP2_LIB_DIR} -L${LZMA_LIB_DIR} -L${LZO2_LIB_DIR} -L${LZ4_LIB_DIR}" "LIBS=-l${ZLIB_LIB} -l${BZIP2_LIB} -l${LZMA_LIB} -l${LZO2_LIB} -l${LZ4_LIB}" ${CMAKE_CURRENT_BINARY_DIR}/libarchive-${VERSION_EXTERNAL}/src/TARGET_libarchive/configure --prefix=${CMAKE_CURRENT_BINARY_DIR}/install --enable-shared=no --enable-static=yes --with-zlib --with-bz2lib --with-lz4 --with-lzma --with-lzo2 --without-nettle --without-openssl --without-xml2 --without-expat --with-pic ${CONFIGURE_HOST}
                    BUILD_COMMAND make
                    INSTALL_COMMAND make install
)
