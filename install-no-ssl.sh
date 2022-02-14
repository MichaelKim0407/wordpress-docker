#!/bin/bash

set -e

SRC_DIR="$(dirname $(realpath "$0"))/src"
source "${SRC_DIR}/install/prep"

for script in $(ls "${SRC_DIR}/install" | ${GREP} -P '\.sh$' | ${GREP} -vP '^2\d'); do
  "${SRC_DIR}/install/${script}"
done
"${SRC_DIR}/install/21-alt-setup-nginx-no-ssl"
