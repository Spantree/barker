#!/bin/bash

RUBY_MAJOR=2.1
RUBY_VERSION=2.1.2
RUBY_DOWNLOAD_SHA256=f22a6447811a81f3c808d1c2a5ce3b5f5f0955c68c9a749182feb425589e6635

mkdir -p /var/cache/install-flags/ruby
if [ ! -f "/var/cache/install-flags/ruby/${RUBY_VERSION}" ]; then
	apt-get update \
	&& apt-get install -y bison libgdbm-dev ruby autoconf zlib1g-dev libreadline-dev libssl-dev \
	&& rm -rf /var/lib/apt/lists/* \
	&& mkdir -p /usr/src/ruby \
	&& curl -fSL -o ruby.tar.gz "http://cache.ruby-lang.org/pub/ruby/$RUBY_MAJOR/ruby-$RUBY_VERSION.tar.gz" \
	&& echo "$RUBY_DOWNLOAD_SHA256 *ruby.tar.gz" | sha256sum -c - \
	&& tar -xzf ruby.tar.gz -C /usr/src/ruby --strip-components=1 \
	&& rm ruby.tar.gz \
	&& cd /usr/src/ruby \
	&& autoconf \
	&& ./configure --disable-install-doc \
	&& make -j"$(nproc)" \
	&& make install \
	&& apt-get purge -y --auto-remove bison ruby autoconf \
	&& rm -r /usr/src/ruby \
	&& touch "/var/cache/install-flags/ruby/${RUBY_VERSION}"
fi

# skip installing gem documentation
echo 'gem: --no-rdoc --no-ri' >> "$HOME/.gemrc"