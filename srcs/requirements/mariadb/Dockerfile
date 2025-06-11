FROM debian:bullseye

# Installer MariaDB
RUN apt-get update && \
    apt-get install -y mariadb-server mariadb-client

COPY ./conf/conf.cnf /etc/mysql/mariadb.conf.d/conf.cnf
COPY ./tools/script.sh /usr/local/bin/script.sh 
RUN chmod +x /usr/local/bin/script.sh
RUN chmod +x /etc/mysql/mariadb.conf.d/conf.cnf

# Port exposé
EXPOSE 3306

CMD ["/usr/local/bin/script.sh"]
