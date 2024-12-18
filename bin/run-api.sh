#!/bin/bash

set -e

NODE_ENV=${NODE_ENV:-development}
COMMAND=${API_RUN_COMMAND:-nginx}

PASSENGER_INSTANCE_COUNT=20; # for production
if [ "$NODE_ENV" == 'development' ]; then
  PASSENGER_INSTANCE_COUNT=2
fi

cd /app/src/

# Placeholder for checking anything before running the app
# /sbin/setuser app /app/src/bin/check

if [ "$COMMAND" == "nginx" ]; then
  echo "Running API"
  # nginx does not have native support for environment variables. To avoid writing a Lua/Perl script
  # in nginx config to read this, just replace it in the conf dynamically:
  sed -i -e "s/__REPLACED_NODE_ENV__/${NODE_ENV}/g" /etc/nginx/sites-enabled/default
  sed -i -e "s/__REPLACED_PASSENGER_INSTANCE_COUNT__/${PASSENGER_INSTANCE_COUNT}/g" /etc/nginx/sites-enabled/default

  # Note: it is important that nginx is configured to not daemonize itself for this init script to
  # work correctly. See: https://github.com/phusion/baseimage-docker#adding-additional-daemons
  exec nginx -g 'daemon off;'
elif [ "$COMMAND" == "something" ]; then
  echo "Running Something"
  exec something 2>&1
else
  echo "Unknown command: ${COMMAND}"
  exit 1
fi
