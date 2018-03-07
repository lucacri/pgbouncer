FROM lucacri/alpine-base:3.7.1
MAINTAINER "Luca Critelli" <lucacri@gmail.com>


RUN apk --no-cache add \
curl \
nano \
bzip2 \
bash \
pgbouncer 

ADD rootfs /

ENV PG_ADDRESS_HOST postgres
ENV PG_ADDRESS_PORT 5432
ENV PG_POSTGRES_USER postgres
ENV PG_POSTGRES_PASS postgres
ENV PGBOUNCER_MAX_CLIENT_CONN 10000
ENV PGBOUNCER_POOL_SIZE 400
ENV PGBOUNCER_IDLE_TIMEOUT 240