FROM debian:bullseye

RUN apt-get update && apt-get install -y \
	php php-fpm php-mysql php-curl php-xml php-mbstring \
	mariadb-client \
	curl wget unzip 

RUN mkdir -p /var/www/html \
    && curl -o wordpress.tar.gz https://wordpress.org/latest.tar.gz \
    && tar -xzf wordpress.tar.gz -C /var/www/html --strip-components=1 \
    && rm wordpress.tar.gz

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

copy ./conf/www.conf /etc/php/7.4/fpm/pool.d/

RUN mkdir -p /run/php

WORKDIR /var/www/wordpress/

COPY ./tools/wordpress.sh /usr/local/bin/wordpress.sh

RUN chmod +x /usr/local/bin/wordpress.sh

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/wordpress.sh"]
