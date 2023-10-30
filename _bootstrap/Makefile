.PHONY: all

arch:
	docker build -f Dockerfile.arch -t arch-dev .
	docker run -it --rm -v $(shell pwd):/home/developer arch-dev

debian:
	docker build -f Dockerfile.debian -t debian-dev .
	docker run -it --rm -v $(shell pwd):/home/developer debian-dev

install:
	./bootstrap.sh
