#!/bin/bash

set -e

PG_ADDRESS_HOST=${PG_ADDRESS_HOST:-}
PG_ADDRESS_PORT=${PG_ADDRESS_PORT:-}
PG_POSTGRES_USER=${PG_POSTGRES_USER:-}
PG_POSTGRES_PASS=${PG_POSTGRES_PASS:-}
PGBOUNCER_MAX_CLIENT_CONN=${PGBOUNCER_MAX_CLIENT_CONN:-}
PGBOUNCER_POOL_SIZE=${PGBOUNCER_POOL_SIZE:-}
PGBOUNCER_IDLE_TIMEOUT=${PGBOUNCER_IDLE_TIMEOUT:-}

if [ ! -f /etc/pgbouncer/pgbconf.ini ]
then
cat << EOF > /etc/pgbouncer/pgbconf.ini
[databases]
* = host=${PG_ADDRESS_HOST} port=${PG_ADDRESS_PORT}

[pgbouncer]
logfile = /var/log/postgresql/pgbouncer.log
pidfile = /var/run/postgresql/pgbouncer.pid
;listen_addr = *
listen_addr = 0.0.0.0
listen_port = 6432
unix_socket_dir = /var/run/postgresql
;auth_type = any
auth_type = trust
auth_file = /etc/pgbouncer/userlist.txt
pool_mode = session
server_reset_query = DISCARD ALL
max_client_conn = ${PGBOUNCER_MAX_CLIENT_CONN}
default_pool_size = ${PGBOUNCER_POOL_SIZE}
ignore_startup_parameters = extra_float_digits
server_idle_timeout = ${PGBOUNCER_IDLE_TIMEOUT}
EOF
fi

if [ ! -s /etc/pgbouncer/userlist.txt ]
then
        echo '"'"${PG_POSTGRES_USER}"'" "'"${PG_POSTGRES_PASS}"'"'  > /etc/pgbouncer/userlist.txt
fi

chown -R postgres:postgres /etc/pgbouncer
chown root:postgres /var/log/postgresql
chmod 1775 /var/log/postgresql
chmod 640 /etc/pgbouncer/userlist.txt