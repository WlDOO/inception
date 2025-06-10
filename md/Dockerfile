FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    mariadb-server \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

COPY conf/my.cnf /etc/mysql/my.cnf

RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld \
    && mkdir -p /var/lib/mysql && chown -R mysql:mysql /var/lib/mysql

COPY tools/db_script.sh /usr/local/bin/db_script.sh
RUN chmod +x /usr/local/bin/db_script.sh

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/db_script.sh"]

