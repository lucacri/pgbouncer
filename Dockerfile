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

COPY rootfs /

ENV PG_ADDRESS_HOST postgres
ENV PG_ADDRESS_PORT 5432
ENV PG_POSTGRES_USER postgres
ENV PG_POSTGRES_PASS postgres
ENV PGBOUNCER_MAX_CLIENT_CONN 10000
ENV PGBOUNCER_POOL_SIZE 400
ENV PGBOUNCER_IDLE_TIMEOUT 240

