#!/bin/bash
set -e

# Variables attendues dans l'environnement
: "${DB_HOST:=mariadb}"
: "${MYSQL_USER:=root}"
: "${MYSQL_PASSWORD:=root}"
: "${MYSQL_DATABASE:=wordpress}"

echo "🔍 Test de connexion à MariaDB sur ${DB_HOST} avec l'utilisateur ${MYSQL_USER}"

# Vérifie si le client MySQL est installé
if ! command -v mysql &> /dev/null; then
    echo "⚠️ mysql client non trouvé, installation..."
    apt update && apt install -y mariadb-client
fi

# Test de connexion
if mysql -h "${MYSQL_DATABASE}" -u"${MYSQL_USER}" -p"${MYSQL_PASSWORD}" -e "USE ${MYSQL_DATABASE};"; then
    echo "✅ Connexion réussie à la base de données ${MYSQL_DATABASE}"
else
    echo "❌ Échec de connexion à MariaDB"
    exit 1
fi

