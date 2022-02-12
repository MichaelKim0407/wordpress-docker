#!/bin/bash

set -e

if [ -z "${INSTALL_DIR}" ]; then
  exit 1
fi

SRC_DIR=$(dirname $(dirname $(realpath "$0")))
source "${SRC_DIR}/install/mac"

TEMPLATE_FILE="${SRC_DIR}/bin"
INSTALL_FILE="${INSTALL_DIR}/bin"

cp -r "${TEMPLATE_FILE}" "${INSTALL_FILE}"
