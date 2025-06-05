FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    php php-mysql php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip wget unzip mariadb-client \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN wget https://wordpress.org/latest.zip -O /tmp/wordpress.zip \
    && unzip /tmp/wordpress.zip -d /var/www/html/ \
    && rm /tmp/wordpress.zip \
    && mv /var/www/html/wordpress/* /var/www/html/ \
    && rmdir /var/www/html/wordpress

WORKDIR /var/www/html

COPY tools/wordpress.sh /usr/local/bin/wordpress.sh

RUN chmod +x /usr/local/bin/wordpress.sh

EXPOSE 9000

ENTRYPOINT ["wordpress.sh"]
