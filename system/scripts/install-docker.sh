#!/usr/bin/env bash

set -o xtrace  # trace what gets executed
set -o errexit # exit when a command fails.
set -o nounset # exit when your script tries to use undeclared variables

VERSION=1.7.0

if [ ! -f "/var/install-flags/docker/${VERSION}" ]; then
	wget -qO- https://get.docker.com/ | sed "s/lxc-docker/lxc-docker-${VERSION}/" | sh
	mkdir -p /var/install-flags/docker \
	touch "/var/install-flags/docker/${VERSION}"
fi