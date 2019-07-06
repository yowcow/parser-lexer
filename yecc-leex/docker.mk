DOCKER_RUN := docker run --rm -it -v `pwd`:/app -w /app erlang

all:
	docker pull erlang

test:
	$(DOCKER_RUN) sh -c 'make clean all test'

debug:
	 $(DOCKER_RUN) bash

.PHONY: all test debug
