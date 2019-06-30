IMAGE := yowcow/yacc-flex

all: build-image

build-image:
	docker pull ubuntu
	docker build -t $(IMAGE) .

debug:
	docker run --rm -it -v $$(pwd):/app -w /app $(IMAGE) bash

.PHONY: all build-image debug
