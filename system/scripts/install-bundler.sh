#!/bin/bash

BUNDLER_VERSION=1.10.6

GEM_HOME=/usr/local/bundle
PATH=$GEM_HOME/bin:$PATH

mkdir -p /var/cache/install-flags/bundler

if [ ! -f "/var/cache/install-flags/bundler/${BUNDLER_VERSION}" ]; then
	gem install bundler --version "$BUNDLER_VERSION" \
	&& bundle config --global path "$GEM_HOME" \
	&& bundle config --global bin "$GEM_HOME/bin" \
	&& touch "/var/cache/install-flags/bundler/${BUNDLER_VERSION}"
fi

# don't create ".bundle" in all our apps
BUNDLE_APP_CONFIG=$GEM_HOME