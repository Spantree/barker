#!/bin/bash

VERSION=1.3.3

mkdir -p /var/cache/install-flags/docker-compose

if [ ! -f "/var/cache/install-flags/docker-compose/${VERSION}" ]; then
	curl -L "https://github.com/docker/compose/releases/download/${VERSION}/docker-compose-`uname -s`-`uname -m`" > /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose \
	&& touch "/var/cache/install-flags/docker-compose/${VERSION}"
fi