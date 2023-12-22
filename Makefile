.PHONY: all build-arch run-arch build-debian run-debian install-local clean test lint update shell

all: build-arch build-debian

build-arch:
	docker build -f _bootstrap/Dockerfile.arch -t arch-dev .

build-debian:
	docker build -f _bootstrap/Dockerfile.debian -t debian-dev .

run-arch:
	docker run -it --rm -v $(shell pwd):/home/developer arch-dev /usr/bin/zsh

run-debian:
	docker run -it --rm -v $(shell pwd):/home/developer debian-dev /usr/bin/zsh

install-local:
	./bootstrap.sh

clean:
	docker rmi arch-dev debian-dev

