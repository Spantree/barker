#!/bin/bash

DOCKER_COMPOSE_VERSION=1.3.3

mkdir -p /var/cache/install-flags/docker-compose

if [ ! -f "/var/cache/install-flags/docker-compose/${DOCKER_COMPOSE_VERSION}" ]; then
	curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m`" > /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose \
	&& touch "/var/cache/install-flags/docker-compose/${DOCKER_COMPOSE_VERSION}"
fi