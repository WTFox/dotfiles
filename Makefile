.PHONY: all

arch:
	docker build -f _bootstrap/Dockerfile.arch -t arch-dev .
	docker run -it --rm -v $(shell pwd):/home/developer arch-dev

debian:
	docker build -f _bootstrap/Dockerfile.debian -t debian-dev .
	docker run -it --rm -v $(shell pwd):/home/developer debian-dev

install:
	./bootstrap.sh

push:
	@git add . && git commit -m "updates" && git push origin main

update:
	@git pull origin main
	@nvim --headless "+Lazy! restore" +qa

