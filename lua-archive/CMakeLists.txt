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
	MESSAGE("EXTERNAL_INCLUDE_DIR = ${EXTERNAL_INCLUDE_DIR}")
	MESSAGE("EXTERNAL_LIB_DIR = ${EXTERNAL_LIB_DIR}")

	# Get the includes and library for zlib.
	MESSAGE("net.zlib-zlib_DIR: ${net.zlib-zlib_DIR}")
	FIND_PACKAGE(net.zlib-zlib REQUIRED CONFIG)
	GET_TARGET_PROPERTY(ZLIB_LIBRARY net.zlib-zlib::zlibstatic LOCATION)

	# Add a custom target for the swig runtime for LUA.
	INCLUDE(${CMAKE_HOME_DIRECTORY}/cmake/muhkuh_swig_lua_runtime.cmake)

	# Select the LUA version.
	INCLUDE(${CMAKE_HOME_DIRECTORY}/cmake/muhkuh_lua.cmake)

	INCLUDE(${SWIG_USE_FILE})

	INCLUDE_DIRECTORIES(${LUA_INCLUDE_DIR})
	INCLUDE_DIRECTORIES(${CMAKE_BINARY_DIR}/swig_runtime)
	INCLUDE_DIRECTORIES(${CMAKE_CURRENT_SOURCE_DIR})
	INCLUDE_DIRECTORIES(${EXTERNAL_INCLUDE_DIR})

	SET_SOURCE_FILES_PROPERTIES(archive.i PROPERTIES CPLUSPLUS ON)
	SET_SOURCE_FILES_PROPERTIES(archive.i PROPERTIES SWIG_FLAGS "")
	SWIG_ADD_MODULE(TARGET_archive lua archive.i wrapper.cpp)
	SWIG_LINK_LIBRARIES(TARGET_archive ${LUA_LIBRARIES} ${EXTERNAL_LIB_DIR}/libarchive.a ${ZLIB_LIBRARY} ${EXTERNAL_LIB_DIR}/libbzip2.a ${EXTERNAL_LIB_DIR}/liblz4.a ${EXTERNAL_LIB_DIR}/liblzma.a ${EXTERNAL_LIB_DIR}/liblzo2.a)
	ADD_DEPENDENCIES(TARGET_archive TARGET_swigluarun)

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
	FILE(WRITE ${CMAKE_CURRENT_BINARY_DIR}/install/org.muhkuh.lua-archive.version "SET(org.muhkuh.lua-archive_VERSION ${VERSION_EXTERNAL}.${VERSION_PACKAGE})")
ENDIF((${BUILDCFG_ONLY_JONCHKI_CFG} STREQUAL "OFF"))
