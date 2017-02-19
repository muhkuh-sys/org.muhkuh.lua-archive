# Do not call this script directly. It is included from the .build??_*.sh files.

echo "PRJ_DIR        = ${PRJ_DIR}"
echo "BUILD_DIR      = ${BUILD_DIR}"
echo "CMAKE_COMPILER = ${CMAKE_COMPILER}"
echo "JONCHKI        = ${JONCHKI}"
echo "JONCHKI_SYSTEM = ${JONCHKI_SYSTEM}"

# Create all folders.
rm -rf ${BUILD_DIR}
mkdir -p ${BUILD_DIR}
mkdir ${BUILD_DIR}/external
mkdir ${BUILD_DIR}/lua5.1
mkdir ${BUILD_DIR}/lua5.1/build_requirements
mkdir ${BUILD_DIR}/lua5.2
mkdir ${BUILD_DIR}/lua5.2/build_requirements
mkdir ${BUILD_DIR}/lua5.3
mkdir ${BUILD_DIR}/lua5.3/build_requirements

# Get the build requirements for the LUA5.1 version.
pushd ${BUILD_DIR}/lua5.1/build_requirements
cmake -DBUILDCFG_ONLY_JONCHKI_CFG="ON" -DBUILDCFG_LUA_VERSION="5.1" -DCMAKE_INSTALL_PREFIX="" ${CMAKE_COMPILER} ${PRJ_DIR}
make
lua5.1 ${JONCHKI} --verbose debug --syscfg ${PRJ_DIR}/jonchki/jonchkisys.cfg --prjcfg ${PRJ_DIR}/jonchki/jonchkicfg.xml ${JONCHKI_SYSTEM} --build-dependencies lua-archive/lua5.1-lua-archive-*.xml
popd

# Build the externals.
pushd ${BUILD_DIR}/external
cmake ${CMAKE_COMPILER} ${PRJ_DIR}/external
make
popd
LIBARCHIVE_LIBRARY="${BUILD_DIR}/external/libarchive/install/lib/libarchive.a"
LIBARCHIVE_INCLUDE_DIR="${BUILD_DIR}/external/libarchive/install/include"


# Build the LUA5.1 version.
pushd ${BUILD_DIR}/lua5.1
cmake -DBUILDCFG_LUA_USE_SYSTEM="OFF" -DBUILDCFG_LUA_VERSION="5.1" -DCMAKE_INSTALL_PREFIX="" -DLIBARCHIVE_LIBRARY=${LIBARCHIVE_LIBRARY} -DLIBARCHIVE_INCLUDE_DIR=${LIBARCHIVE_INCLUDE_DIR} ${CMAKE_COMPILER} ${PRJ_DIR}
make
popd


# Get the build requirements for the LUA5.2 version.
pushd ${BUILD_DIR}/lua5.2/build_requirements
cmake -DBUILDCFG_ONLY_JONCHKI_CFG="ON" -DBUILDCFG_LUA_VERSION="5.2" -DCMAKE_INSTALL_PREFIX="" ${CMAKE_COMPILER} ${PRJ_DIR}
make
lua5.1 ${JONCHKI} --verbose debug --syscfg ${PRJ_DIR}/jonchki/jonchkisys.cfg --prjcfg ${PRJ_DIR}/jonchki/jonchkicfg.xml ${JONCHKI_SYSTEM} --build-dependencies lua-archive/lua5.2-lua-archive-*.xml
popd

# Build the LUA5.2 version.
pushd ${BUILD_DIR}/lua5.2
cmake -DBUILDCFG_LUA_USE_SYSTEM="OFF" -DBUILDCFG_LUA_VERSION="5.2" -DCMAKE_INSTALL_PREFIX="" -DLIBARCHIVE_LIBRARY=${LIBARCHIVE_LIBRARY} -DLIBARCHIVE_INCLUDE_DIR=${LIBARCHIVE_INCLUDE_DIR} ${CMAKE_COMPILER} ${PRJ_DIR}
make
popd


# Get the build requirements for the LUA5.3 version.
pushd ${BUILD_DIR}/lua5.3/build_requirements
cmake -DBUILDCFG_ONLY_JONCHKI_CFG="ON" -DBUILDCFG_LUA_VERSION="5.3" -DCMAKE_INSTALL_PREFIX="" ${CMAKE_COMPILER} ${PRJ_DIR}
make
lua5.1 ${JONCHKI} --verbose debug --syscfg ${PRJ_DIR}/jonchki/jonchkisys.cfg --prjcfg ${PRJ_DIR}/jonchki/jonchkicfg.xml ${JONCHKI_SYSTEM} --build-dependencies lua-archive/lua5.3-lua-archive-*.xml
popd

# Build the LUA5.3 version.
pushd ${BUILD_DIR}/lua5.3
cmake -DBUILDCFG_LUA_USE_SYSTEM="OFF" -DBUILDCFG_LUA_VERSION="5.3" -DCMAKE_INSTALL_PREFIX="" -DLIBARCHIVE_LIBRARY=${LIBARCHIVE_LIBRARY} -DLIBARCHIVE_INCLUDE_DIR=${LIBARCHIVE_INCLUDE_DIR} ${CMAKE_COMPILER} ${PRJ_DIR}
make
popd
