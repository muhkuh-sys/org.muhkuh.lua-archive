cmake_minimum_required(VERSION 3.7)

PROJECT("com.github.brimworks-lua-archive")

# Get the VCS version for the jonchki configuration.
INCLUDE(cmake/version.cmake)
INCLUDE(cmake/platform.cmake)
MESSAGE("Building for: ${JONCHKI_PLATFORM}")

# Enable tests (see here for details: http://www.vtk.org/Wiki/CMake/Testing_With_CTest)
ENABLE_TESTING()

# Set some installation folders.
INCLUDE(cmake/muhkuh_installation_folders.cmake)

OPTION(BUILDCFG_ONLY_JONCHKI_CFG "Build only the jonchki configuration. This is used for the resolve phase. The default is OFF."
       "OFF")

#----------------------------------------------------------------------------
#
# Find all packages.
#

# Python is used for some test scripts.
FIND_PACKAGE(PythonInterp 2.7 REQUIRED)

FIND_PACKAGE(SWIG REQUIRED)

#----------------------------------------------------------------------------
#
# Include the projects in the subdirectories.
#
ADD_SUBDIRECTORY(lua-archive)

#----------------------------------------------------------------------------

