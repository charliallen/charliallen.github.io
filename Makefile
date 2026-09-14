.PHONY: build-guix deploy

build-haunt:
	make -C src/site/

serve:
	make -C src/site/ serve

build-guix:
	guix build -L env/guix -f env/guix/guix.scm

deploy:
	./dev/deploy-pages
