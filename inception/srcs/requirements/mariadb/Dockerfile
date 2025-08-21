FROM debian:bookworm

USER root

RUN apt-get update && apt-get install -y \
    mariadb-server \
    mariadb-client && \
    rm -rf /var/lib/apt/lists/*

COPY ./tools/db_start.sh /usr/local/bin/db_start.sh
RUN chmod +x /usr/local/bin/db_start.sh

ENTRYPOINT ["/usr/local/bin/db_start.sh"]
