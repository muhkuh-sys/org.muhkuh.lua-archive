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
lua5.1 ${JONCHKI} --verbose debug --syscfg ${PRJ_DIR}/jonchki/jonchkisys.cfg --prjcfg ${PRJ_DIR}/jonchki/jonchkicfg.xml ${JONCHKI_SYSTEM} --build-dependencies lua-archive/lua5.1-archive-*.xml
popd
NET_ZLIB_ZLIB_DIR=${BUILD_DIR}/lua5.1/build_requirements/jonchki/install/dev/cmake

# Build the externals.
pushd ${BUILD_DIR}/external
cmake ${CMAKE_COMPILER} -Dnet.zlib-zlib_DIR=${NET_ZLIB_ZLIB_DIR} ${PRJ_DIR}/external
make
popd
EXTERNAL_LIB_DIR="${BUILD_DIR}/external/install/lib"
EXTERNAL_INCLUDE_DIR="${BUILD_DIR}/external/install/include"


# Build the LUA5.1 version.
pushd ${BUILD_DIR}/lua5.1
cmake -DBUILDCFG_LUA_USE_SYSTEM="OFF" -DBUILDCFG_LUA_VERSION="5.1" -DCMAKE_INSTALL_PREFIX="" -DEXTERNAL_LIB_DIR=${EXTERNAL_LIB_DIR} -DEXTERNAL_INCLUDE_DIR=${EXTERNAL_INCLUDE_DIR} -Dnet.zlib-zlib_DIR=${NET_ZLIB_ZLIB_DIR} ${CMAKE_COMPILER} ${PRJ_DIR}
make
make install DESTDIR=${BUILD_DIR}/lua5.1/install
popd


# Get the build requirements for the LUA5.2 version.
pushd ${BUILD_DIR}/lua5.2/build_requirements
cmake -DBUILDCFG_ONLY_JONCHKI_CFG="ON" -DBUILDCFG_LUA_VERSION="5.2" -DCMAKE_INSTALL_PREFIX="" ${CMAKE_COMPILER} ${PRJ_DIR}
make
lua5.1 ${JONCHKI} --verbose debug --syscfg ${PRJ_DIR}/jonchki/jonchkisys.cfg --prjcfg ${PRJ_DIR}/jonchki/jonchkicfg.xml ${JONCHKI_SYSTEM} --build-dependencies lua-archive/lua5.2-archive-*.xml
popd

# Build the LUA5.2 version.
pushd ${BUILD_DIR}/lua5.2
cmake -DBUILDCFG_LUA_USE_SYSTEM="OFF" -DBUILDCFG_LUA_VERSION="5.2" -DCMAKE_INSTALL_PREFIX="" -DEXTERNAL_LIB_DIR=${EXTERNAL_LIB_DIR} -DEXTERNAL_INCLUDE_DIR=${EXTERNAL_INCLUDE_DIR} -Dnet.zlib-zlib_DIR=${NET_ZLIB_ZLIB_DIR} ${CMAKE_COMPILER} ${PRJ_DIR}
make
make install DESTDIR=${BUILD_DIR}/lua5.2/install
popd


# Get the build requirements for the LUA5.3 version.
pushd ${BUILD_DIR}/lua5.3/build_requirements
cmake -DBUILDCFG_ONLY_JONCHKI_CFG="ON" -DBUILDCFG_LUA_VERSION="5.3" -DCMAKE_INSTALL_PREFIX="" ${CMAKE_COMPILER} ${PRJ_DIR}
make
lua5.1 ${JONCHKI} --verbose debug --syscfg ${PRJ_DIR}/jonchki/jonchkisys.cfg --prjcfg ${PRJ_DIR}/jonchki/jonchkicfg.xml ${JONCHKI_SYSTEM} --build-dependencies lua-archive/lua5.3-archive-*.xml
popd

# Build the LUA5.3 version.
pushd ${BUILD_DIR}/lua5.3
cmake -DBUILDCFG_LUA_USE_SYSTEM="OFF" -DBUILDCFG_LUA_VERSION="5.3" -DCMAKE_INSTALL_PREFIX="" -DEXTERNAL_LIB_DIR=${EXTERNAL_LIB_DIR} -DEXTERNAL_INCLUDE_DIR=${EXTERNAL_INCLUDE_DIR} -Dnet.zlib-zlib_DIR=${NET_ZLIB_ZLIB_DIR} ${CMAKE_COMPILER} ${PRJ_DIR}
make
make install DESTDIR=${BUILD_DIR}/lua5.3/install
popd
