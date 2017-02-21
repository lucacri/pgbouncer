FROM phusion/baseimage

RUN apt-get update -qqy \
  && apt-get -qqy --no-install-recommends install \
    pgbouncer \
  	&& rm -rf /var/lib/apt/lists/* \
	&& apt-get autoremove -y \
	&& apt-get clean \
	&& apt-get autoclean \
	&& echo -n > /var/lib/apt/extended_states \
	&& rm -rf /var/lib/apt/lists/* \
	&& rm -rf /usr/share/man/?? \
	&& rm -rf /usr/share/man/??_* 

# ENV VALUE
ENV PG_PORT_5432_TCP_ADDR postgres
ENV PORT_RANGE 8081-8181

ENV PG_PORT_5432_TCP_ADDR postgres
ENV PG_PORT_5432_TCP_PORT 5432
ENV PG_ENV_POSTGRESQL_USER postgres
ENV PG_ENV_POSTGRESQL_PASS postgres
ENV PG_ENV_POSTGRESQL_MAX_CLIENT_CONN 10000
ENV PG_ENV_POSTGRESQL_DEFAULT_POOL_SIZE 400
ENV PG_ENV_POSTGRESQL_SERVER_IDLE_TIMEOUT 240

COPY rootfs /