#!/usr/bin/env bash

set -o xtrace  # trace what gets executed
set -o errexit # exit when a command fails.
set -o nounset # exit when your script tries to use undeclared variables

source "${HOME}/.bash_profile"
GEM_HOME=/usr/local/bundle
PATH=$GEM_HOME/bin:$PATH
BUNDLE_APP_CONFIG=$GEM_HOME

cd /usr/src/app

mkdir -p /var/install-flags/app

GEMFILE_SHA256=$(sha256sum Gemfile | cut -f 1 -d " ")
GEMFILE_LOCK_SHA256=$(sha256sum Gemfile.lock | cut -f 1 -d " ")

GEMFILE_FLAG_PATH="/var/install-flags/app/Gemfile-${GEMFILE_SHA256}"
GEMFILE_LOCK_FLAG_PATH="/var/install-flags/app/Gemfile.lock-${GEMFILE_LOCK_SHA256}"

if [[ ! -f "${GEMFILE_FLAG_PATH}" ]] || [[ ! -f "{GEMFILE_LOCK_FLAG_PATH}" ]]; then
	bundle install \
	&& touch "${GEMFILE_FLAG_PATH}" \
	&& touch "${GEMFILE_LOCK_FLAG_PATH}"
fi