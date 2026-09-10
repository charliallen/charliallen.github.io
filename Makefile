.PHONY: build deploy

build:
	guix build -f guix.scm

deploy:
	./dev/deploy-pages
