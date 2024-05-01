VERSION ?= v0.2.1
CACHE ?= --no-cache=1

.PHONY: all build publish
all: build publish
build:
	docker buildx build --platform linux/arm/v7,linux/arm64/v8,linux/amd64 ${PUSH} --tag femtopixel/builder --tag femtopixel/builder:${VERSION} ${CACHE} . 
publish:
	PUSH=--push	CACHE= make build
