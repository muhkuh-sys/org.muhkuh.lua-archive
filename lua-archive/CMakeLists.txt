cmake_minimum_required(VERSION 3.2.3)

PROJECT("lua-archive")

INCLUDE(ExternalProject)

SET(VERSION_EXTERNAL "0.0.0")
SET(VERSION_PACKAGE  "1")
SET(PROJECT_VERSION  "${VERSION_EXTERNAL}.${VERSION_PACKAGE}")

# Get the VCS version for the jonchki configuration.
INCLUDE(${CMAKE_HOME_DIRECTORY}/cmake/version.cmake)

# Filter the jonchki configuration.
CONFIGURE_FILE(installer/lua${BUILDCFG_LUA_VERSION}/lua-archive.xml
               ${CMAKE_CURRENT_BINARY_DIR}/lua${BUILDCFG_LUA_VERSION}-lua-archive-${PROJECT_VERSION}.xml
               @ONLY)


#----------------------------------------------------------------------------
#
# Build the project.
#

IF((${BUILDCFG_ONLY_JONCHKI_CFG} STREQUAL "OFF"))


	SET(LIBARCHIVE_INCLUDE_DIR "/home/baccy/workspace/com.github.libarchive-libarchive/build/linux/external/libarchive/install/include")
	SET(LIBARCHIVE_LIBRARY "/home/baccy/workspace/com.github.libarchive-libarchive/build/linux/external/libarchive/install/lib/libarchive.a")

	SET(ZLIB_LIBRARY "/home/baccy/workspace/com.github.libarchive-libarchive/build/linux/lua5.1/build_requirements/jonchki/install/dev/lib/libz.a")
	SET(BZIP2_LIBRARY "/home/baccy/workspace/com.github.libarchive-libarchive/build/linux/external/bzip2/install/lib/libbzip2.a")
	SET(LZMA_LIBRARY "/home/baccy/workspace/com.github.libarchive-libarchive/build/linux/external/lzma/install/lib/liblzma.a")
	SET(LZ4_LIBRARY "/home/baccy/workspace/com.github.libarchive-libarchive/build/linux/external/lz4/install/lib/liblz4.a")
	SET(LZO_LIBRARY "/home/baccy/workspace/com.github.libarchive-libarchive/build/linux/external/lzo/install/lib/liblzo2.a")


	# Select the LUA version.
	INCLUDE(${CMAKE_HOME_DIRECTORY}/cmake/muhkuh_lua.cmake)

	FIND_PACKAGE(SWIG REQUIRED)

	INCLUDE(${SWIG_USE_FILE})

	INCLUDE_DIRECTORIES(${LUA_INCLUDE_DIR})
	INCLUDE_DIRECTORIES(${CMAKE_CURRENT_SOURCE_DIR})
	INCLUDE_DIRECTORIES(${LIBARCHIVE_INCLUDE_DIR})

	SET_SOURCE_FILES_PROPERTIES(archive.i PROPERTIES CPLUSPLUS ON)
	SET_SOURCE_FILES_PROPERTIES(archive.i PROPERTIES SWIG_FLAGS "")
	SWIG_ADD_MODULE(TARGET_archive lua archive.i wrapper.cpp)
	SWIG_LINK_LIBRARIES(TARGET_archive ${LUA_LIBRARIES} ${LIBARCHIVE_LIBRARY} ${ZLIB_LIBRARY} ${BZIP2_LIBRARY} ${LZMA_LIBRARY} ${LZ4_LIBRARY} ${LZO_LIBRARY})

	# Set the name of the output file to "archive".
	SET_TARGET_PROPERTIES(TARGET_archive PROPERTIES PREFIX "" OUTPUT_NAME "archive")

	# On mingw link all compiler libraries static.
	IF((${CMAKE_SYSTEM_NAME} STREQUAL "Windows") AND (${CMAKE_COMPILER_IS_GNUCC}))
		SET_PROPERTY(TARGET TARGET_archive PROPERTY LINK_FLAGS "-static-libgcc -static-libstdc++")
	ENDIF((${CMAKE_SYSTEM_NAME} STREQUAL "Windows") AND (${CMAKE_COMPILER_IS_GNUCC}))


	# Install the lua module.
	INSTALL(TARGETS TARGET_archive DESTINATION ${INSTALL_DIR_LUA_MODULES})


	# Add tests for this module.
	IF((${CMAKE_SYSTEM_NAME} STREQUAL "Windows") AND (${CMAKE_COMPILER_IS_GNUCC}))
		# Here are the MinGW specific tests.
		ADD_TEST(NAME archive_MinGW_DLL_dependencies
		         COMMAND "${PYTHON_EXECUTABLE}" ${CMAKE_HOME_DIRECTORY}/cmake/tests/mingw_dll_dependencies.py -u lua5.1 $<TARGET_FILE:TARGET_archive>)
	ENDIF((${CMAKE_SYSTEM_NAME} STREQUAL "Windows") AND (${CMAKE_COMPILER_IS_GNUCC}))


	# Write a version file.
	FILE(WRITE ${CMAKE_CURRENT_BINARY_DIR}/install/com.github.brimworks-lua-archive.version "SET(com.github.brimworks-lua-archive_VERSION ${VERSION_EXTERNAL}.${VERSION_PACKAGE})")
ENDIF((${BUILDCFG_ONLY_JONCHKI_CFG} STREQUAL "OFF"))
