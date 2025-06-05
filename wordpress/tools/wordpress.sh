#!/bin/bash
set -e


if [ ! -f "$WP_DIR/wp-config.php" ]; then
    echo "⚙️ Création de wp-config.php..."

    cp "$WP_DIR/wp-config-sample.php" "$WP_DIR/wp-config.php"

    sed -i "s/database_name_here/${MYSQL_DATABASE}/" "$WP_DIR/wp-config.php"
    sed -i "s/username_here/${MYSQL_USER}/" "$WP_DIR/wp-config.php"
    sed -i "s/password_here/${MYSQL_PASSWORD}/" "$WP_DIR/wp-config.php"
    sed -i "s/localhost/${DB_HOST}/" "$WP_DIR/wp-config.php"
fi

echo "⏳ Attente de la base de données..."
until mysqladmin ping -h"$DB_HOST" --silent; do
  sleep 2
done

if ! wp core is-installed --path=$WP_DIR; then
    echo "🚀 Installation WordPress..."

    wp core install \
        --url="${WP_URL}" \
        --title="${WP_TITLE}" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --path=$WP_DIR \
        --skip-email
fi

chown -R www-data:www-data "$WP_DIR"

exec /usr/sbin/php-fpm7.4 -F
