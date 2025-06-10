FROM debian:bullseye

# Installer MariaDB
RUN apt-get update && \
    apt-get install -y mariadb-server mariadb-client && \
    rm -rf /var/lib/apt/lists/*

# Créer le répertoire pour le socket
RUN mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld

# Copier le script d'initialisation
COPY ./tools/script.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/script.sh

# Port exposé
EXPOSE 3306

CMD ["/usr/local/bin/script.sh"]
