#!/usr/bin/make

SHELL = /bin/sh

init: build-base
	docker-compose up -d

build: build-base
	docker-compose up -d --build

migrate:
	docker-compose exec app php artisan migrate

test-back-end:
	docker-compose exec -T app composer test

build-base:
	chmod +x ./setup/build-image-base.sh
	./setup/build-image-base.sh
