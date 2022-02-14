#!/bin/bash

set -e

if [ -z "${INSTALL_DIR}" ]; then
  exit 1
fi

SRC_DIR=$(dirname $(dirname $(realpath "$0")))
source "${SRC_DIR}/install/mac"
source "${SRC_DIR}/install/project_name"

TEMPLATE_FILE="${SRC_DIR}/templates/.env"
INSTALL_FILE="${INSTALL_DIR}/.env"

if ! [ -f "${INSTALL_FILE}" ]; then
  cp "${TEMPLATE_FILE}" "${INSTALL_FILE}"
fi

${SED} -i "s/^COMPOSE_PROJECT_NAME=$/COMPOSE_PROJECT_NAME=${COMPOSE_PROJECT_NAME}/" "${INSTALL_FILE}"

while ${GREP} random_string "${INSTALL_FILE}" >/dev/null; do
  ${SED} -i "0,/random_string/s//$(echo $RANDOM | md5sum | head -c 16)/" "${INSTALL_FILE}"
done
