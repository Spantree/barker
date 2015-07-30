#!/bin/bash

API_HOST=consul.barker.internal

consulate --api-host "${API_HOST}" register -s postgres -a 172.51.1.101 -p 5432 postgres no-check
consulate --api-host "${API_HOST}" register -s logstash -a 172.51.1.101 -p 3333 logstash no-check

consulate --api-host "${API_HOST}" kv set barker/development/postgres/username postgres
consulate --api-host "${API_HOST}" kv set barker/development/postgres/password insecurepassword
consulate --api-host "${API_HOST}" kv set barker/production/postgres/username postgres
consulate --api-host "${API_HOST}" kv set barker/production/postgres/password insecurepassword