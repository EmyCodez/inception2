FROM debian:bookworm

USER root

RUN apt-get update && apt-get install -y \
    mariadb-server \
    mariadb-client && \
    rm -rf /var/lib/apt/lists/*

COPY ./requirements/mariadb/tools/db_start.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/db_start.sh

ENTRYPOINT ["/usr/local/bin/db_start.sh"]
