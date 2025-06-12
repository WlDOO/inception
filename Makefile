COMPOSE = srcs/docker-compose.yml

all:
	mkdir -p /home/najeuneh/data/mariadb
	mkdir -p /home/najeuneh/data/wordpress
	docker compose -f $(COMPOSE) up --build -d

clean:
	docker compose -f $(COMPOSE) down -v

fclean: clean
	sudo rm -rf /home/najeuneh/data

re:fclean all
