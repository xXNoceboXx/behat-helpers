.PHONY: app-composer-validate app-cs-check app-cs-fix app-install app-security-check app-test app-test-with-code-coverage

default: help

help:
	@grep -E '^[a-zA-Z_-]+:.*?##.*$$' $(MAKEFILE_LIST) | sort | awk '{split($$0, a, ":"); printf "\033[36m%-30s\033[0m %-30s %s\n", a[1], a[2], a[3]}'

app-composer-validate: ## to validate composer config
	composer validate

app-cs-check: ## to show files that need to be fixed
	vendor/bin/php-cs-fixer fix --dry-run --diff --verbose

app-cs-fix: ## to fix files that need to be fixed
	vendor/bin/php-cs-fixer fix --verbose

app-install: ## to install app
	COMPOSER_MEMORY_LIMIT=-1 composer install --prefer-dist

app-security-check: ## to check if any security issues in the PHP dependencies
	vendor/bin/security-checker security:check --end-point=http://security.sensiolabs.org/check_lock

app-test: ## to run unit tests
	vendor/bin/phpunit

app-test-with-code-coverage: ## to run unit tests with code-coverage
	vendor/bin/phpunit --coverage-text --coverage-clover=build/phpunit/clover.xml --log-junit=build/phpunit/junit.xml --colors=never
