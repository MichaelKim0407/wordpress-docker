#!/bin/bash

set -e

if [ -z "${INSTALL_DIR}" ]; then
  exit 1
fi

SRC_DIR=$(dirname $(dirname $(realpath "$0")))
source "${SRC_DIR}/install/mac"

cd "${INSTALL_DIR}"

docker-compose up -d wp

mkdir -p wp
if ! [ -f ./wp/wp-config.php ]; then
  while true; do
    if ! docker-compose exec wp test -f /var/www/html/wp-config.php; then
      sleep 1
    else
      docker-compose cp wp:/var/www/html/wp-config.php ./wp/wp-config.php
      break
    fi
  done
fi

${SED} -i 's/#wpconfig#//' docker-compose.yml

docker-compose up -d wp
