#!/usr/bin/env bash

set -o xtrace  # trace what gets executed
set -o errexit # exit when a command fails.
set -o nounset # exit when your script tries to use undeclared variables

VERSION=1.10.6

GEM_HOME=/usr/local/bundle
BUNDLE_APP_CONFIG=$GEM_HOME
source "${HOME}/.bash_profile"

if [ ! -f "/var/install-flags/bundler/${VERSION}" ]; then
	gem install bundler --version "${VERSION}" \
	&& bundle config --global path "${GEM_HOME}" \
	&& bundle config --global bin "${GEM_HOME}/bin" \
	&& mkdir -p /var/install-flags/bundler \
	&& touch "/var/install-flags/bundler/${VERSION}"
fi

# don't create ".bundle" in all our apps
BUNDLE_APP_CONFIG=$GEM_HOME