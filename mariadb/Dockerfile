FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    mariadb-server \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*


EXPOSE 3306

COPY conf/mysql.cnf /etc/mysql/mysql.cnf

RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld \
    && mkdir -p /var/lib/mysql && chown -R mysql:mysql /var/lib/mysql

COPY tools/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
