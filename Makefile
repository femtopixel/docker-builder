VERSION ?= v0.2.0
CACHE ?= --no-cache=1
FULLVERSION ?= ${VERSION}
archs ?= amd64 arm64v8 arm32v6

.PHONY: all build publish latest
all: build publish latest
qemu-arm-static:
	cp /usr/bin/qemu-arm-static .
qemu-aarch64-static:
	cp /usr/bin/qemu-aarch64-static .
build: qemu-arm-static qemu-aarch64-static
	$(foreach arch,$(archs), \
		cat Dockerfile | sed "s/FROM docker/FROM ${arch}\/docker/g" > .Dockerfile; \
		docker build -t femtopixel/builder:${VERSION}-$(arch) -t ghcr.io/femtopixel/builder:${VERSION}-$(arch) -f .Dockerfile ${CACHE} .;\
	)
publish:
	docker push femtopixel/builder -a
	docker push ghcr.io/femtopixel/builder -a
	cat manifest.yml | sed "s/\$$VERSION/${VERSION}/g" > manifest.yaml
	cat manifest.yaml | sed "s/\$$FULLVERSION/${FULLVERSION}/g" > manifest2.yaml
	mv manifest2.yaml manifest.yaml
	manifest-tool push from-spec manifest.yaml
	cat manifest.yaml | sed "s/femtopixel/ghcr.io\/femtopixel/g" > manifest2.yaml
	mv manifest2.yaml manifest.yaml
	manifest-tool push from-spec manifest.yaml
latest:
	FULLVERSION=latest VERSION=${VERSION} make publish
