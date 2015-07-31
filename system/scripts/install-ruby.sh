#!/usr/bin/env bash

set -o xtrace  # trace what gets executed
set -o errexit # exit when a command fails.
set -o nounset # exit when your script tries to use undeclared variables

VERSION=2.1.2

mkdir -p /var/install-flags/ruby
if [ ! -f "/var/install-flags/ruby/${VERSION}" ]; then
	touch ~/.bash_profile \
	&& apt-get update \
	&& apt-get install -y git-core curl ruby-dev zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libpq-dev libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev \
	&& git clone https://github.com/sstephenson/rbenv.git ~/.rbenv \
	&& echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile \
	&& echo 'eval "$(rbenv init -)"' >> ~/.bash_profile \
	&& git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build \
	&& ~/.rbenv/bin/rbenv install -v "${VERSION}" \
	&& ~/.rbenv/bin/rbenv global "${VERSION}" \
	&& touch "/var/install-flags/ruby/${VERSION}"
fi

# skip installing gem documentation
echo 'gem: --no-rdoc --no-ri' >> "$HOME/.gemrc"