#!/bin/bash

# Démarrer MariaDB en arrière-plan
mysqld_safe &

# Attendre que le serveur soit prêt
while ! mysqladmin ping -u root --silent; do
    sleep 1
done

# Créer la base de données et l'utilisateur avec les bonnes permissions
mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'localhost';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

# Donner l'accès au socket pour l'utilisateur
chown -R mysql:mysql /var/run/mysqld/
chmod 755 /var/run/mysqld/

# Arrêter proprement
mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown

exec mysqld_safe
