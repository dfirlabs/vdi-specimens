#!/bin/bash
#
# Script to generate VDI test files
# Requires Linux with VBoxManage

source ./shared_linux.sh

assert_availability_binary VBoxManage

VERSION=$( VBoxManage --version | tail -n 1 | sed -E 's/^([0-9]+\.[0-9]+\.[0-9]+).*/\1/' )

SPECIMENS_PATH="specimens/VBoxManage-${VERSION}"

if test -d "${SPECIMENS_PATH}"
then
	echo "Specimens directory: ${SPECIMENS_PATH} already exists."

	exit ${EXIT_FAILURE}
fi

mkdir -p "${SPECIMENS_PATH}"

set -e

echo "Creating: dynamic-size disk image"
VBoxManage createmedium disk --filename "${SPECIMENS_PATH}/dynamic.vdi" --size 4096 --variant Standard

echo "Creating: fixed-size disk image"
VBoxManage createmedium disk --filename "${SPECIMENS_PATH}/fixed.vdi" --size 20480 --variant Fixed

echo "Creating: diferential disk image"
VBoxManage createmedium disk --filename "${SPECIMENS_PATH}/differential.vdi" --size 20480 --diffparent "${SPECIMENS_PATH}/dynamic.vdi"

exit ${EXIT_SUCCESS}
