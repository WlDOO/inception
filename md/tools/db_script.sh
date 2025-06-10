#!/bin/bash

set -e

DB_DIR="/var/lib/mysql/mysql"

mysqld_safe &

echo "Attente que MariaDB démarre..."
until mysqladmin ping --silent; do
    sleep 1
done

echo "MariaDB est prêt"


mysql -u root -p"${MYSQL_ROOT_PASSWORD}" <<EOF
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

echo "Base créée et utilisateur configuré."

mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown

echo "Lancement de MariaDB"
exec mysqld_safe
