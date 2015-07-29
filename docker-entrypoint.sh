#!/bin/sh
set -e

if grep "/var/lib/postgresql" /etc/mtab | grep -q sdb; then
  touch /run/openrc/softlevel && \
  /etc/init.d/postgresql setup && \
  rm /run/openrc/softlevel
  chown postgres:postgres -R /var/lib/postgresql
fi

if [[ "$1" == -* ]]; then
  set -- gosu postgres /usr/bin/postgres $@
fi
    
if [ "$1" = "postgres" ]; then
  shift 1
  set -- gosu postgres /usr/bin/postgres --config-file=/etc/postgresql.conf -D /var/lib/postgresql/9.4/data $@
fi

exec "$@"

