#!/bin/bash

set -e

if [ -z "${INSTALL_DIR}" ] || [ -z "${WP_HOSTNAME}" ]; then
  exit 1
fi

SRC_DIR=$(dirname $(dirname $(realpath "$0")))
source "${SRC_DIR}/install/mac"

TEMPLATE_FILE="${SRC_DIR}/templates/le.conf"
INSTALL_FILE="${INSTALL_DIR}/nginx-conf/le.conf"

mkdir -p "${INSTALL_DIR}/nginx-conf"
if ! [ -f "${INSTALL_FILE}" ]; then
  cp "${TEMPLATE_FILE}" "${INSTALL_FILE}"
fi

${SED} -i "s/www.example.org/${WP_HOSTNAME}/" "${INSTALL_FILE}"

cd "${INSTALL_DIR}"

docker-compose up -d nginx
docker-compose run --rm certbot certonly --webroot --webroot-path /var/www/certbot/ -d "${WP_HOSTNAME}"
