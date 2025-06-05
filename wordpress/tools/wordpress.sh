#!/bin/bash
set -e

WP_DIR="/var/www/html"

if [ ! -f "$WP_DIR/wp-config.php" ]; then
    echo "⚙️ Création de wp-config.php..."

    cp "$WP_DIR/wp-config-sample.php" "$WP_DIR/wp-config.php"

    sed -i "s/database_name_here/${MYSQL_DATABASE}/" "$WP_DIR/wp-config.php"
    sed -i "s/username_here/${MYSQL_USER}/" "$WP_DIR/wp-config.php"
    sed -i "s/password_here/${MYSQL_PASSWORD}/" "$WP_DIR/wp-config.php"
    sed -i "s/localhost/${DB_HOST}/" "$WP_DIR/wp-config.php"
fi

until mysql -h mariadb -u"${MYSQL_USER}" -p"${MYSQL_PASSWORD}" -e "SELECT 1;" "${MYSQL_DATABASE}" --silent > /dev/null 2>&1; do
	echo "wait"
	sleep 2
done
echo "ici"
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

echo "j arrive la"

exec /usr/sbin/php-fpm7.4 -F
