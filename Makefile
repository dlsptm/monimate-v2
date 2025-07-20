# Executables (local)
DOCKER_COMP = docker compose

# Docker containers
PHP_CONT = $(DOCKER_COMP) exec php
DATABASE_CONT = $(DOCKER_COMP) exec database

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
	@$(DOCKER_COMP) --env-file .env.local up --detach

start: build up ## Build and start the containers

down: ## Stop the docker hub
	@$(DOCKER_COMP) down --remove-orphans

reset:
	@$(DOCKER_COMP) down --volumes --rmi all

logs: ## Show live logs
	@$(DOCKER_COMP) logs --tail=0 --follow

psh: ## Connect to the PHP container
	@$(PHP_CONT) sh

dsh: ## Connect to the DATABASE container
	@$(DATABASE_CONT) sh

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

cc: ## Clear the cache
	@$(SYMFONY-CLI) c:c


phpcs: ## Run PHP CS Fixer to automatically fix coding standards issues
	PHP_CS_FIXER_IGNORE_ENV=1 ./vendor/bin/php-cs-fixer fix \
	--verbose \
	--show-progress=dots \
	--config=.php-cs-fixer.dist.php \
	--allow-risky=yes

phpstan: ## Run PHPStan static analysis with specified config and memory limit
	@$(PHP) vendor/bin/phpstan analyse -c phpstan.dist.neon --memory-limit=1G

dump: ## Run var-dump-check to verify dumps and exclude specific directories
	@$(PHP) vendor/bin/var-dump-check --no-colors --symfony --exclude bin --exclude config --exclude libraries --exclude public --exclude var --exclude vendor .

db-drop: ## Drop the database forcefully
	@$(SYMFONY-CLI) doctrine:database:drop --force

db-create: ## Create the database
	@$(SYMFONY-CLI) doctrine:database:create

db-diff: ## Generate a new migration by comparing current schema to mapping
	@$(SYMFONY-CLI) doctrine:migration:diff

db-migrate: ## Execute database migrations
	@$(SYMFONY-CLI) doctrine:migration:migrate

entity: ## Generate a new Doctrine entity
	@$(eval c ?=)
	@$(SYMFONY-CLI) make:entity $(c)

form: ## Generate a new form class
	@$(eval c ?=)
	@$(SYMFONY-CLI) make:form $(c)

controller: ## Generate a new controller class
	@$(eval c ?=)
	@$(SYMFONY-CLI) make:controller $(c)

## —— Git 🔧 ———————————————————————————————————————————————————————————————
pre-commit: ## Run checks before committing: dump verification, code style fix, and static analysis
	make dump
	make phpcs
	make phpstan

commit: ## Commit and push changes to all remotes
ifndef c
	$(error Please provide a commit message using c="your message")
endif
	git add .
	git commit -m "$(c)"
	git push all

fetch: ## Fetch latest changes from origin and github remotes
	git fetch origin
	git fetch github
