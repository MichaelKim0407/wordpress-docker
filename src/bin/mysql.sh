#!/bin/bash

source .env
docker-compose exec db mysql --user=${DB_USER} --password=${DB_PASSWORD} ${DB_NAME} "$@"
