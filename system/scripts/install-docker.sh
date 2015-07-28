#!/bin/bash

DOCKER_VERSION=1.7.0

mkdir -p /var/cache/install-flags/docker

if [ ! -f "/var/cache/install-flags/docker/${DOCKER_VERSION}" ]; then
	wget -qO- https://get.docker.com/ | sed "s/lxc-docker/lxc-docker-${DOCKER_VERSION}/" | sh \
	&& touch "/var/cache/install-flags/docker/${DOCKER_VERSION}"
fi