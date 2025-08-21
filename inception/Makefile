DATA_DIR = /home/$(USER)/data

all: build up

up:
	@echo "Creating data directories at $(DATA_DIR)..."
	mkdir -p $(DATA_DIR)/mariadb_data $(DATA_DIR)/wordpress
	@echo "Starting containers..."
	cd srcs && docker-compose up -d

down:
	@echo "Stopping containers..."
	cd srcs && docker-compose down

build:
	@echo "Building images..."
	cd srcs && docker-compose build

clean: down
	@echo "Removing all project-related Docker images..."	
	-docker rmi -f nginx:v1.0 wordpress:v1.0 mariadb:v1.0 2>/dev/null || true

re: clean build up

fclean:
	@echo "Removing project containers..."
	@CONTAINERS=$$(docker ps -a -q -f name=nginx -f name=wordpress -f name=mariadb); \
	if [ -n "$$CONTAINERS" ]; then docker rm -f $$CONTAINERS; fi
	@echo "Removing volumes mariadb_data and wordpress..."
	-docker volume rm mariadb_data wordpress 2>/dev/null || true
	@echo "Deleting data directory $(DATA_DIR)..."
	-rm -rf $(DATA_DIR)
	@echo "Pruning unused Docker objects (images, containers, volumes)..."
	docker system prune -af --volumes

.PHONY: all up down build clean fclean re
