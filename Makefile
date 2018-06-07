VERSION ?= v0.1.0
CACHE ?= --no-cache=1
FULLVERSION ?= v0.1.0
archs ?= amd64

.PHONY: build publish latest
build-docker:
	docker build -t femtopixel/builder:${VERSION} -f .Dockerfile ${CACHE} .
publish-docker:
	docker push femtopixel/builder
latest: build
	FULLVERSION=latest VERSION=${VERSION} make publish
