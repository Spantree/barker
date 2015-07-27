#!/bin/bash

RAILS_VERSION=4.2.3

GEM_HOME=/usr/local/bundle
PATH=$GEM_HOME/bin:$PATH
BUNDLE_APP_CONFIG=$GEM_HOME

mkdir -p /var/cache/install-flags/rails

if [ ! -f "/var/cache/install-flags/rails/${RAILS_VERSION}" ]; then
	apt-get update \
	&& apt-get install -y nodejs postgresql-client libsqlite3-dev --no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* \
	&& gem install rails --version "$RAILS_VERSION" \
	&& touch "/var/cache/install-flags/rails/${RAILS_VERSION}"
fi