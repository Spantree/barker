#!/usr/bin/env bash

set -o xtrace  # trace what gets executed
set -o errexit # exit when a command fails.
set -o nounset # exit when your script tries to use undeclared variables

# this is a temporary workaround
if [ -d /var/lib/cloud ]; then
    while [ ! -f /var/lib/cloud/instance/boot-finished ]; do
        sleep 1
        echo "sleeping for 10 seconds while cloud-init is running"
    done
    while sudo fuser /var/lib/dpkg/lock >/dev/null 2>&1; do
        sleep 1
        echo "Waiting while apt is ran by cloud-init"
    done
fi