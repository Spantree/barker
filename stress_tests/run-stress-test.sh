#!/bin/bash

set -o xtrace  # trace what gets executed
set -o errexit # exit when a command fails.
set -o nounset # exit when your script tries to use undeclared variables


REBUILD=${REBUILD:-false}

if [ "$REBUILD" -eq "true" ]; then
  git pull
  mvn dependency:copy-dependencies
  mvn package
fi

RAMP_UP_SECONDS=${RAMP_UP_SECONDS:-20}
USERS=${USERS:-20}

ulimit -n
java -Djava.net.preferIPv4Stack=true -Djava.net.preferIPv6Addresses=false -DrampUpSeconds=$RAMP_UP_SECONDS -Dusers=$USERS -DbaseUrl="http://barkerapp.com" -cp "target/dependency/*:target/barker-stress-tests-1.0.0-SNAPSHOT.jar" Engine
