#!/bin/bash

set -e

function print_usage() {
  echo "INSTALL_DIR=<install dir> WP_HOSTNAME=<hostname> $0"
}

if [ -z "${INSTALL_DIR}" ] || [ -z "${WP_HOSTNAME}" ]; then
  print_usage
  exit 1
fi

if [ -f "${INSTALL_DIR}" ]; then
  echo "${INSTALL_DIR} is a file."
  select userinput in "Overwrite" "Cancel"; do
    case ${userinput} in
    Overwrite)
      rm "${INSTALL_DIR}"
      break
      ;;
    Cancel)
      exit 2
      ;;
    esac
  done
elif [ -d "${INSTALL_DIR}" ]; then
  echo "${INSTALL_DIR} already exists."
  select userinput in "Overwrite" "Cancel" "Proceed"; do
    case ${userinput} in
    Overwrite)
      rm -rf "${INSTALL_DIR}"
      break
      ;;
    Cancel)
      exit 2
      ;;
    Proceed)
      break
      ;;
    esac
  done
fi

mkdir -p "${INSTALL_DIR}"

SRC_DIR="$(dirname $(realpath "$0"))/src"
source "${SRC_DIR}/install/mac"

for script in $(ls "${SRC_DIR}/install" | ${GREP} -P "\.sh$"); do
  "${SRC_DIR}/install/${script}"
done
