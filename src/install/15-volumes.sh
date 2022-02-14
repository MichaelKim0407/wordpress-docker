#!/bin/bash

set -e

if [ -n "${TEST_INSTALL}" ]; then
  exit 0
fi

if [ -z "${INSTALL_DIR}" ]; then
  exit 1
fi

SRC_DIR=$(dirname $(dirname $(realpath "$0")))
source "${SRC_DIR}/install/mac"

cd "${INSTALL_DIR}"

${SED} -i 's/#externalvols#//' docker-compose.yml
