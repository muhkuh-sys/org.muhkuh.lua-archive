#! /bin/bash
set -e

# This is the name of the working container.
# FIXME: generate something unique to avoid collisions if more than one build is running.
CONTAINER=c0

# Get the project directory.
PRJDIR=`pwd`

# Make sure that the "build" folder exists.
# NOTE: do not remove it, maybe there are already components.
mkdir -p ${PRJDIR}/build

# Start the container and mount the project folder.
lxc init mbs-ubuntu-1710-x64 ${CONTAINER}
lxc config device add ${CONTAINER} projectDir disk source=${PRJDIR} path=/tmp/work
lxc start ${CONTAINER}

# Wait 4 seconds for the system to come up.
sleep 4

# Wait until the network is up and running.
WAIT_CNT=0
WAIT_MAX=30
echo "Waiting for the network to come up (maximum ${WAIT_MAX} seconds)"
while [ ${WAIT_CNT} -lt ${WAIT_MAX} ]; do
	NETWORK_STATUS=`lxc exec ${CONTAINER} -- systemctl show --property=ActiveState systemd-resolved-update-resolvconf.path`
	if [ "${NETWORK_STATUS}" = "ActiveState=active" ]; then
		echo "OK, the network is up."
		break
	else
		sleep 1
		let WAIT_CNT=WAIT_CNT+1
		echo "${WAIT_CNT}"
	fi
done
if [ ${WAIT_CNT} -ge ${WAIT_MAX} ]; then
	echo "The network did not come up!"
	lxc stop ${CONTAINER}
	lxc delete ${CONTAINER}
	exit -1
fi

# Prepare the build folder.
lxc exec ${CONTAINER} -- bash -c 'rm -rf /tmp/build'
lxc exec ${CONTAINER} -- bash -c 'mkdir /tmp/build'
lxc exec ${CONTAINER} -- bash -c 'mount --bind /tmp/build /tmp/work/build'

# Update the package list to prevent "not found" messages.
lxc exec ${CONTAINER} -- bash -c 'apt-get update --assume-yes'

# Install the project specific packages.
lxc exec ${CONTAINER} -- bash -c 'apt-get install --assume-yes libacl1-dev lua5.1 lua-filesystem lua-expat lua51-mhash lua-sql-sqlite3'

# Build the 64bit version.
lxc exec ${CONTAINER} -- bash -c 'cd /tmp/work && bash .build03_linux.sh'
lxc exec ${CONTAINER} -- bash -c 'tar --create --file /tmp/work/build/build_ubuntu_1710_x86_64_lua5.1.tar.gz --gzip --directory /tmp/work/build/linux/lua5.1/install .'
lxc exec ${CONTAINER} -- bash -c 'tar --create --file /tmp/work/build/build_ubuntu_1710_x86_64_lua5.2.tar.gz --gzip --directory /tmp/work/build/linux/lua5.2/install .'
lxc exec ${CONTAINER} -- bash -c 'tar --create --file /tmp/work/build/build_ubuntu_1710_x86_64_lua5.3.tar.gz --gzip --directory /tmp/work/build/linux/lua5.3/install .'
lxc file pull ${CONTAINER}/tmp/work/build/build_ubuntu_1710_x86_64_lua5.1.tar.gz build/
lxc file pull ${CONTAINER}/tmp/work/build/build_ubuntu_1710_x86_64_lua5.2.tar.gz build/
lxc file pull ${CONTAINER}/tmp/work/build/build_ubuntu_1710_x86_64_lua5.3.tar.gz build/

# Stop and remove the container.
lxc stop ${CONTAINER}
lxc delete ${CONTAINER}
