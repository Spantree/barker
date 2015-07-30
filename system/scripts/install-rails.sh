#!/bin/bash

VERSION=4.2.3

GEM_HOME=/usr/local/bundle
PATH=$GEM_HOME/bin:$PATH
BUNDLE_APP_CONFIG=$GEM_HOME

mkdir -p /var/cache/install-flags/rails

if [ ! -f "/var/cache/install-flags/rails/${VERSION}b" ]; then
	apt-get clean \
	&& mv /var/lib/apt/lists /var/lib/apt/lists.old_`date '+%Y%m%d_%H%M%S'` \
	&& mkdir -p /var/lib/apt/lists/partial \
    && apt-get clean \
	&& apt-get update \
	&& apt-get install -y nodejs libpq-dev libsqlite3-dev --no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* \
	&& gem install rails --version "$VERSION" \
	&& gem install rails --version "$VERSION" \
	&& touch "/var/cache/install-flags/rails/${VERSION}b"
fi