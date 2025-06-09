FROM debian:bullseye

RUN apt-get update && apt-get install -y \
	php php-fpm php-mysql php-curl php-xml php-mbstring \
	mariadb-client \
	curl wget unzip \
	&& apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/html \
    && curl -o wordpress.tar.gz https://wordpress.org/latest.tar.gz \
    && tar -xzf wordpress.tar.gz -C /var/www/html --strip-components=1 \
    && rm wordpress.tar.gz

WORKDIR /var/www/html

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

COPY tools/wordpress.sh /usr/local/bin/wordpress.sh
RUN chmod +x /usr/local/bin/wordpress.sh

COPY tools/test_db.sh /usr/local/bin/test_db.sh
RUN chmod +x /usr/local/bin/test_db.sh

EXPOSE 9000

ENTRYPOINT ["wordpress.sh"]
