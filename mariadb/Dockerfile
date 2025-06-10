FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y \
        mariadb-server \
        mariadb-client \
        && rm -rf /var/lib/apt/lists/*

COPY ./conf/conf.cnf /etc/mysql/maria.conf.f/50-server.cnf
COPY ./tools/script.sh /usr/local/bin/script.sh
RUN chmod 755 /usr/local/bin/script.sh

EXPOSE 3306

CMD ["/usr/local/bin/script.sh"]
