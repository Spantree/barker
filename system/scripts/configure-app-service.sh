#!/usr/bin/env bash

set -o xtrace  # trace what gets executed
set -o errexit # exit when a command fails.
set -o nounset # exit when your script tries to use undeclared variables

source "${HOME}/.bash_profile"
cp -f /usr/src/app/etc/init/barker-app.conf /etc/init/barker-app.conf
cp -f /usr/src/app/etc/default/barker-app /etc/default/barker-app