#!/usr/bin/env bash

set -o xtrace  # trace what gets executed
set -o errexit # exit when a command fails.
set -o nounset # exit when your script tries to use undeclared variables

VERSION=4.2.3

GEM_HOME=/usr/local/bundle
BUNDLE_APP_CONFIG=$GEM_HOME
source "${HOME}/.bash_profile"

mkdir -p /var/install-flags/rails
if [ ! -f "/var/install-flags/rails/${VERSION}" ]; then
	apt-get install -y nodejs --no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* \
	&& gem install rails --version "$VERSION" \
	&& gem install rails --version "$VERSION" \
	&& touch "/var/install-flags/rails/${VERSION}"
fi