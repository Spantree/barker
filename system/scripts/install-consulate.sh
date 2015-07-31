#!/usr/bin/env bash

set -o xtrace  # trace what gets executed
set -o errexit # exit when a command fails.
set -o nounset # exit when your script tries to use undeclared variables

VERSION=0.6.0

if [ ! -f "/var/install-flags/consulate/${VERSION}" ]; then
	apt-get install -y python-pip
	pip install "consulate==${VERSION}"
	mkdir -p /var/install-flags/consulate
	touch "/var/install-flags/consulate/${VERSION}"
fi