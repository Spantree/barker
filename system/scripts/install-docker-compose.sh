#!/usr/bin/env bash

set -o xtrace  # trace what gets executed
set -o errexit # exit when a command fails.
set -o nounset # exit when your script tries to use undeclared variables

VERSION=1.3.3

if [ ! -f "/var/install-flags/docker-compose/${VERSION}" ]; then
	curl -L "https://github.com/docker/compose/releases/download/${VERSION}/docker-compose-`uname -s`-`uname -m`" > /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose \
    && mkdir -p /var/install-flags/docker-compose \
	&& touch "/var/install-flags/docker-compose/${VERSION}"
fi