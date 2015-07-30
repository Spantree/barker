#!/usr/bin/env bash

set -o xtrace  # trace what gets executed
set -o errexit # exit when a command fails.
set -o nounset # exit when your script tries to use undeclared variables

VERSION=2.1.2
BASH_PROFILE="${HOME}/.bash_profile"
touch $BASH_PROFILE

mkdir -p /var/cache/install-flags/ruby
if [ ! -f "/var/cache/install-flags/ruby/${VERSION}" ]; then
 #    apt-get clean \
	# && mv /var/lib/apt/lists /var/lib/apt/lists.old_`date '+%Y%m%d_%H%M%S'` \
	# && mkdir -p /var/lib/apt/lists/partial \
 #    && apt-get clean \
	&& apt-get update \
	&& apt-get install -y git-core curl ruby-dev rbenv zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libpq-dev libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev
	
	rbenv install -v "${VERSION}" \
	&& rbenv global "${VERSION}" \
	&& touch "/var/cache/install-flags/ruby/${VERSION}"
fi

# skip installing gem documentation
echo 'gem: --no-rdoc --no-ri' >> "$HOME/.gemrc"