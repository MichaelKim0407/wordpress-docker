#!/bin/bash

set -e

# MacOS (dev)
command -v ggrep >/dev/null && GREP=ggrep || GREP=grep
command -v gsed >/dev/null && SED=gsed || SED=sed

docker-compose up -d

mkdir -p wp
if ! [ -f ./wp/wp-config.php ]
then
  docker-compose cp wp:/var/www/html/wp-config.php ./wp/wp-config.php
fi

if ! ${GREP} -P '^COMPOSE_FILE=.*wp-config' .env >/dev/null
then
  ${SED} -i 's/\(COMPOSE_FILE=.*\)/\1:docker-compose.wp-config.yml/g' .env
fi

docker-compose up -d
