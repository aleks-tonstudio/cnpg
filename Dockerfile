# add extensions to cnpg postgresql image: timescaledb, pg_cron
ARG POSTGRESQL_VERSION=17


FROM ghcr.io/cloudnative-pg/postgresql:${POSTGRESQL_VERSION}
ARG EXTENSIONS
ENV EXTENSIONS=${EXTENSIONS}
#ARG TIMESCALEDB_VERSION
#ENV TIMESCALEDB_VERSION=${TIMESCALEDB_VERSION}

# switch to root user to install extensions
USER root
RUN apt-get update && \
    apt-get install -y postgresql-common && \
    sh /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh -y && \
    apt-get update && \
    apt-get install -y postgresql-17-pglogical && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
# switch back to the postgres user
USER postgres