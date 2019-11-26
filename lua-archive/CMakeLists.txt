cmake_minimum_required(VERSION 3.2.3)

PROJECT("lua-archive")

INCLUDE(ExternalProject)

SET(VERSION_EXTERNAL "0.0.1")
SET(VERSION_PACKAGE  "6")
SET(PROJECT_VERSION  "${VERSION_EXTERNAL}.${VERSION_PACKAGE}")

# Get the VCS version for the jonchki configuration.
INCLUDE(${CMAKE_HOME_DIRECTORY}/cmake/version.cmake)

# Filter the jonchki configuration.
CONFIGURE_FILE(installer/lua${BUILDCFG_LUA_VERSION}/archive.xml
               ${CMAKE_BINARY_DIR}/lua${BUILDCFG_LUA_VERSION}-archive-${PROJECT_VERSION}.xml
               @ONLY)

OPTION(BUILDCFG_ONLY_JONCHKI_CFG "Build only the jonchki configuration. This is used for the resolve phase. The default is OFF."
       "OFF")

#----------------------------------------------------------------------------
#
# Build the project.
#

IF((${BUILDCFG_ONLY_JONCHKI_CFG} STREQUAL "OFF"))
	# Enable tests (see here for details: http://www.vtk.org/Wiki/CMake/Testing_With_CTest)
	ENABLE_TESTING()

	# Set some installation folders.
	INCLUDE(${CMAKE_HOME_DIRECTORY}/cmake/muhkuh_installation_folders.cmake)

	# Python is used for some test scripts.
	FIND_PACKAGE(PythonInterp 2.7 REQUIRED)

	FIND_PACKAGE(SWIG REQUIRED)

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

	IF(${CMAKE_SYSTEM_NAME} STREQUAL "Windows")
		# libarchive has the suffix "_static" on Windows.
		SET(LIBARCHIVE_LIBRARY ${EXTERNAL_LIB_DIR}/libarchive_static.a)
		# No ACL on Windows.
		SET(ACL_LIB "")
	ELSE(${CMAKE_SYSTEM_NAME} STREQUAL "Windows")
		SET(LIBARCHIVE_LIBRARY ${EXTERNAL_LIB_DIR}/libarchive.a)
		# ACL is part of the required packages in a standard Ubuntu system.
		SET(ACL_LIB "-lacl")
	ENDIF(${CMAKE_SYSTEM_NAME} STREQUAL "Windows")

	SET_SOURCE_FILES_PROPERTIES(archive.i PROPERTIES CPLUSPLUS ON)
	SET_SOURCE_FILES_PROPERTIES(archive.i PROPERTIES SWIG_FLAGS "")
	SWIG_ADD_MODULE(TARGET_archive lua archive.i wrapper.cpp)
	SWIG_LINK_LIBRARIES(TARGET_archive ${LUA_LIBRARIES} ${LIBARCHIVE_LIBRARY} ${ZLIB_LIBRARY} ${EXTERNAL_LIB_DIR}/libbzip2.a ${EXTERNAL_LIB_DIR}/liblz4.a ${EXTERNAL_LIB_DIR}/liblzma.a ${ACL_LIB})
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

	#----------------------------------------------------------------------------
	#
	# Build a package for the selected platform.
	#

	SET(CPACK_OUTPUT_FILE_PREFIX ${CMAKE_BINARY_DIR}/../../repository/org/muhkuh/lua/archive/${PROJECT_VERSION})
	SET(CPACK_INCLUDE_TOPLEVEL_DIRECTORY FALSE)
	SET(CPACK_PACKAGE_FILE_NAME "lua${BUILDCFG_LUA_VERSION}-archive-${PROJECT_VERSION}-${JONCHKI_PLATFORM}")

	SET(CPACK_GENERATOR "TXZ")
	INCLUDE(CPack)

	IF(${JONCHKI_PLATFORM_DIST_ID} STREQUAL "windows")
		# Package a windows build.

		# NOTE: Do not install the library again, there is an "INSTALL" already.

		CONFIGURE_FILE(installer/lua${BUILDCFG_LUA_VERSION}/install_windows.lua
		               ${CMAKE_CURRENT_BINARY_DIR}/package/install.lua
		               @ONLY)

		INSTALL(FILES ${CMAKE_CURRENT_BINARY_DIR}/package/install.lua
		        DESTINATION .)
	ELSE(${JONCHKI_PLATFORM_DIST_ID} STREQUAL "windows")
		# Package a linux build.

		# NOTE: Do not install the library again, there is an "INSTALL" already.

		CONFIGURE_FILE(installer/lua${BUILDCFG_LUA_VERSION}/install_linux.lua
		               ${CMAKE_CURRENT_BINARY_DIR}/package/install.lua
		               @ONLY)

		INSTALL(FILES ${CMAKE_CURRENT_BINARY_DIR}/package/install.lua
		        DESTINATION .)
	ENDIF(${JONCHKI_PLATFORM_DIST_ID} STREQUAL "windows")

	CONFIGURE_FILE(installer/lua${BUILDCFG_LUA_VERSION}/archive.xml
	               ${CPACK_OUTPUT_FILE_PREFIX}/lua${BUILDCFG_LUA_VERSION}-archive-${PROJECT_VERSION}-${JONCHKI_PLATFORM}.xml
	               @ONLY)


	#-----------------------------------------------------------------------------
	#
	# Create a custom target named "pack".
	# It builds the package and creates the hashes.
	#
	ADD_CUSTOM_TARGET(pack
	                  COMMAND ${CMAKE_MAKE_PROGRAM}
	                  COMMAND ${CMAKE_MAKE_PROGRAM} package
	                  COMMAND "${PYTHON_EXECUTABLE}" ${CMAKE_HOME_DIRECTORY}/cmake/tools/generate_hash.py ${CPACK_OUTPUT_FILE_PREFIX}/lua${BUILDCFG_LUA_VERSION}-archive-${PROJECT_VERSION}-${JONCHKI_PLATFORM}.xml
	                  COMMAND "${PYTHON_EXECUTABLE}" ${CMAKE_HOME_DIRECTORY}/cmake/tools/generate_hash.py ${CPACK_OUTPUT_FILE_PREFIX}/lua${BUILDCFG_LUA_VERSION}-archive-${PROJECT_VERSION}-${JONCHKI_PLATFORM}.tar.xz
	                  COMMENT "Pack the artifact and generate the hashes...")


	#-----------------------------------------------------------------------------
	#
	# Filter the pom.xml file.
	#
	SET(POM_ARTIFACT_ID  "lua${BUILDCFG_LUA_VERSION}-archive")
	SET(POM_GROUP_ID     "org.muhkuh.lua")
	SET(POM_VERSION      "${PROJECT_VERSION}")
	SET(POM_PACKAGING    "tar.xz")
	CONFIGURE_FILE(installer/lua${BUILDCFG_LUA_VERSION}/pom.xml
	               ${CPACK_OUTPUT_FILE_PREFIX}/lua${BUILDCFG_LUA_VERSION}-archive-${PROJECT_VERSION}.pom
	               @ONLY)
ENDIF((${BUILDCFG_ONLY_JONCHKI_CFG} STREQUAL "OFF"))
