RELEASE_VER   := $(shell git rev-parse --short HEAD)

build:
	RELEASE_VER=$(RELEASE_VER) docker-compose build	

run:
	docker-compose up

stop:
	docker-compose stop

stats:
	docker stats

clean:
	docker-compose rm -f


.PHONY: build run clean  stop stats