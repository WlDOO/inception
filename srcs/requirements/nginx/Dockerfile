FROM debian:bullseye

RUN apt-get update && apt-get install -y \
	nginx \
	openssl

COPY ./conf/nginx.conf /etc/nginx/conf.d

RUN mkdir -p /etc/nginx/ssl

RUN chmod -R 755 /etc/nginx /var/www/html

RUN openssl req -x509 -newkey rsa:2048 -days 365 -nodes \
	-subj "/C=BE/ST=Bruxelles/O=19/CN=najeuneh.42.fr" \
	-out /etc/nginx/ssl/cert.crt \
	-keyout /etc/nginx/ssl/cert.key

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
