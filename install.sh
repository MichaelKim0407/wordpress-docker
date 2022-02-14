#!/bin/bash

set -e

SRC_DIR="$(dirname $(realpath "$0"))/src"
source "${SRC_DIR}/install/prep"

for script in $(ls "${SRC_DIR}/install" | ${GREP} -P "\.sh$"); do
  "${SRC_DIR}/install/${script}"
done
