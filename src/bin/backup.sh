#!/bin/bash

if [[ $UID != 0 ]]; then
  echo "Please run this script with sudo"
  exit 1
fi

if [ -z "$1" ]; then
  echo "Please specify s3 bucket"
  exit 1
else
  bucket_name="$1"
fi

set -e

source .env

t=$(date +%Y%m%d%H%M%S)
backup_name="${COMPOSE_PROJECT_NAME}-backup-${t}"
backup_file="/tmp/${backup_name}.tar.gz"

compose_dir=$(realpath .)
volumes=$(ls -d /var/lib/docker/volumes/* | grep "${COMPOSE_PROJECT_NAME}_")
tar czf ${backup_file} ${compose_dir} ${volumes}

aws s3 cp ${backup_file} s3://${bucket_name}/${COMPOSE_PROJECT_NAME}/
