CMAKE_MINIMUM_REQUIRED(VERSION 3.0)

PROJECT("com.github.keplerproject-luafilesystem")

INCLUDE(../../../cmake/version.cmake)

SET(INSTALL_WIN32              "${CMAKE_CURRENT_SOURCE_DIR}/../../../build/lua5.1/windows_x86")
SET(INSTALL_WIN64              "${CMAKE_CURRENT_SOURCE_DIR}/../../../build/lua5.1/windows_x86_64")
SET(INSTALL_UBUNTU_1204_X86    "${CMAKE_CURRENT_SOURCE_DIR}/../../../build/lua5.1/ubuntu_1204_x86")
SET(INSTALL_UBUNTU_1204_X86_64 "${CMAKE_CURRENT_SOURCE_DIR}/../../../build/lua5.1/ubuntu_1204_x86_64")
SET(INSTALL_UBUNTU_1404_X86    "${CMAKE_CURRENT_SOURCE_DIR}/../../../build/lua5.1/ubuntu_1404_x86")
SET(INSTALL_UBUNTU_1404_X86_64 "${CMAKE_CURRENT_SOURCE_DIR}/../../../build/lua5.1/ubuntu_1404_x86_64")
SET(INSTALL_UBUNTU_1604_X86    "${CMAKE_CURRENT_SOURCE_DIR}/../../../build/lua5.1/ubuntu_1604_x86")
SET(INSTALL_UBUNTU_1604_X86_64 "${CMAKE_CURRENT_SOURCE_DIR}/../../../build/lua5.1/ubuntu_1604_x86_64")
SET(INSTALL_UBUNTU_1610_X86    "${CMAKE_CURRENT_SOURCE_DIR}/../../../build/lua5.1/ubuntu_1610_x86")
SET(INSTALL_UBUNTU_1610_X86_64 "${CMAKE_CURRENT_SOURCE_DIR}/../../../build/lua5.1/ubuntu_1610_x86_64")

# Get the project version. Both the WIN32 and the WIN64 folder have the same version file.
INCLUDE(${INSTALL_WIN32}/com.github.keplerproject-luafilesystem.version)
SET(PROJECT_VERSION ${com.github.keplerproject-luafilesystem_VERSION})

SET(CPACK_OUTPUT_FILE_PREFIX targets/jonchki/repository/com/github/keplerproject/luafilesystem/${PROJECT_VERSION})
SET(CPACK_INCLUDE_TOPLEVEL_DIRECTORY FALSE)
SET(CPACK_PACKAGE_FILE_NAME "lua5.1-luafilesystem-${PROJECT_VERSION}")

SET(CPACK_GENERATOR "ZIP")
INCLUDE(CPack)


#-----------------------------------------------------------------------------
#
# Install the 32bit files.
#
INSTALL(FILES ${INSTALL_WIN32}/lib/lfs.dll
        DESTINATION windows_x86/lua_plugins)

INSTALL(FILES ${INSTALL_UBUNTU_1204_X86}/lib/lfs.so
        DESTINATION ubuntu_1204_x86/lua_plugins)

INSTALL(FILES ${INSTALL_UBUNTU_1404_X86}/lib/lfs.so
        DESTINATION ubuntu_1404_x86/lua_plugins)

INSTALL(FILES ${INSTALL_UBUNTU_1604_X86}/lib/lfs.so
        DESTINATION ubuntu_1604_x86/lua_plugins)

INSTALL(FILES ${INSTALL_UBUNTU_1610_X86}/lib/lfs.so
        DESTINATION ubuntu_1610_x86/lua_plugins)


#-----------------------------------------------------------------------------
#
# Install the 64bit files.
#
INSTALL(FILES ${INSTALL_WIN64}/lib/lfs.dll
        DESTINATION windows_x64/lua_plugins)

INSTALL(FILES ${INSTALL_UBUNTU_1204_X86_64}/lib/lfs.so
        DESTINATION ubuntu_1204_x86_64/lua_plugins)

INSTALL(FILES ${INSTALL_UBUNTU_1404_X86_64}/lib/lfs.so
        DESTINATION ubuntu_1404_x86_64/lua_plugins)

INSTALL(FILES ${INSTALL_UBUNTU_1604_X86_64}/lib/lfs.so
        DESTINATION ubuntu_1604_x86_64/lua_plugins)

INSTALL(FILES ${INSTALL_UBUNTU_1610_X86_64}/lib/lfs.so
        DESTINATION ubuntu_1610_x86_64/lua_plugins)


#-----------------------------------------------------------------------------

INSTALL(FILES install.lua
        DESTINATION .)


CONFIGURE_FILE(luafilesystem.xml
               ${CPACK_OUTPUT_FILE_PREFIX}/lua5.1-luafilesystem-${PROJECT_VERSION}.xml
               @ONLY)

#-----------------------------------------------------------------------------
#
# Filter the pom.xml file.
#
SET(POM_ARTIFACT_ID  "lua5.1-luafilesystem")
SET(POM_GROUP_ID     "com.github.keplerproject")
SET(POM_VERSION      "${PROJECT_VERSION}")
SET(POM_PACKAGING    "zip")
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/pom.xml ${CPACK_OUTPUT_FILE_PREFIX}/pom.xml)
