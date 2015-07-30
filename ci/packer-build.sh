#!/bin/bash
ROOT_DIR=$(git rev-parse --show-toplevel)

set -x
set -e

cd "${ROOT_DIR}"

for t in *.json; do
  echo "${t%%.json}"
done
