#!/bin/bash

case "$1" in
  test-logstash)
    salt-master -d;
    retry=0
    until [ $retry -ge 5 ]; do
      salt-run salt.cmd log.error "executing $SALT_TAG" && break
      sleep 5
    done
    echo "Couldnt log message" >&2
    ;;
  *) exec "$@";;
esac
