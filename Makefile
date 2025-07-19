# Executables (local)
DOCKER_COMP = docker compose

# Docker containers
PHP_CONT = $(DOCKER_COMP) exec php

# Executables
PHP      = $(PHP_CONT) php
SYMFONY  = $(PHP_CONT) symfony
SYMFONY-CLI  = $(SYMFONY) console
PHP-CONSOLE  = $(PHP) bin/console
COMPOSER = $(PHP_CONT) composer

# Misc
.DEFAULT_GOAL = help
.PHONY        : help build up start down logs sh composer vendor sf cc test


## —— 🎵 🐳 The Symfony Docker Makefile 🐳 🎵 ——————————————————————————————————

help: ## Outputs this help screen
	@grep -E '(^[a-zA-Z0-9\./_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}{printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

## —— Docker 🐳 ————————————————————————————————————————————————————————————————
build: ## Builds the Docker images
	@$(DOCKER_COMP) build --pull --no-cache

psa: ## See All containers
	@$(DOCKER_COMP) ps -a

ps: ## See running containers
	@$(DOCKER_COMP) ps

up: ## Start the docker hub in detached mode (no logs)
	@$(DOCKER_COMP) up --detach

start: build up ## Build and start the containers

down: ## Stop the docker hub
	@$(DOCKER_COMP) down --remove-orphans

logs: ## Show live logs
	@$(DOCKER_COMP) logs --tail=0 --follow

sh: ## Connect to the FrankenPHP container
	@$(PHP_CONT) sh

bash: ## Connect to the FrankenPHP container via bash so up and down arrows go to previous commands
	@$(PHP_CONT) bash

test: ## Start tests with phpunit, pass the parameter "c=" to add options to phpunit, example: make test c="--group e2e --stop-on-failure"
	@$(eval c ?=)
	@$(DOCKER_COMP) exec -e APP_ENV=test php bin/phpunit $(c)


## —— Composer 🧙 ——————————————————————————————————————————————————————————————
composer: ## Run composer, pass the parameter "c=" to run a given command, example: make composer c='req symfony/orm-pack'
	@$(eval c ?=)
	@$(COMPOSER) $(c)

vendor: ## Install vendors according to the current composer.lock file
vendor: c=install --prefer-dist --no-dev --no-progress --no-scripts --no-interaction
vendor: composer

## —— Symfony 🎵 ———————————————————————————————————————————————————————————————
sf: ## List all Symfony commands or pass the parameter "c=" to run a given command, example: make sf c=about
	@$(eval c ?=)
	@$(SYMFONY-CLI) $(c)

cc: c=c:c ## Clear the cache


phpcs:
	PHP_CS_FIXER_IGNORE_ENV=1 ./vendor/bin/php-cs-fixer fix \
	--verbose \
	--show-progress=dots \
	--config=.php-cs-fixer.dist.php \
	--allow-risky=yes

phpstan:
	@$(PHP) vendor/bin/phpstan analyse -c phpstan.dist.neon --memory-limit=1G

dump:
	@$(PHP) vendor/bin/var-dump-check --no-colors --symfony --exclude bin --exclude config --exclude libraries --exclude public --exclude var --exclude vendor .

db-drop:
	@$(SYMFONY-CLI) doctrine:database:drop --force

db-create:
	@$(SYMFONY-CLI) doctrine:database:create

db-diff:
	@$(SYMFONY-CLI) doctrine:migration:diff

db-migrate:
	@$(SYMFONY-CLI) doctrine:migration:migrate

entity:
	@$(SYMFONY-CLI) make:entity

form:
	@$(SYMFONY-CLI) make:form

controller:
	@$(SYMFONY-CLI) make:controller

pre-commit:
	make dump
	make phpcs
	make phpstan

commit:
ifndef e
	$(error Veuillez passer un message de commit avec e="votre message")
endif
	git add .
	git commit -m "$(e)"
	git push all

fetch:
	git fetch origin
	git fetch github
