RELEASE_VER   := $(shell git rev-parse --short HEAD)

build:
	RELEASE_VER=$(RELEASE_VER) docker-compose build	

run: build
	docker-compose up -d

stop:
	docker-compose stop

stats:
	docker stats

clean:
	docker-compose rm -f

%:
	curl -w "Total Time: %{time_total}" http://localhost:8080/$@


.PHONY: build run clean stop stats
