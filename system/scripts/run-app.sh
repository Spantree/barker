#!/bin/bash

GEM_HOME=/usr/local/bundle
PATH=$GEM_HOME/bin:$PATH
BUNDLE_APP_CONFIG=$GEM_HOME

cd /usr/src/app
rails server -b 0.0.0.0