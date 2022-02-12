#!/bin/bash

set -e

if [ -z "${INSTALL_DIR}" ]; then
  exit 1
fi

SRC_DIR=$(dirname $(dirname $(realpath "$0")))
source "${SRC_DIR}/install/mac"

TEMPLATE_FILE="${SRC_DIR}/templates/docker-compose.yml"
INSTALL_FILE="${INSTALL_DIR}/docker-compose.yml"

if ! [ -f "${INSTALL_FILE}" ]; then
  cp "${TEMPLATE_FILE}" "${INSTALL_FILE}"
fi
