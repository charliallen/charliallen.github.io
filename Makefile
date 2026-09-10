.PHONY: build deploy

build:
	guix build -L env/guix -f env/guix/guix.scm

deploy:
	./dev/deploy-pages
