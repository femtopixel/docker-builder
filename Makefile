VERSION ?= v0.2.0
CACHE ?= --no-cache=1
FULLVERSION ?= ${VERSION}
archs ?= s390x amd64 i386 arm64v8 arm32v6

.PHONY: all build publish latest
all: build publish latest
build:
	$(foreach arch,$(archs), \
		cat Dockerfile | sed "s/FROM docker/FROM ${arch}\/docker/g" > .Dockerfile; \
		docker build -t femtopixel/builder:${VERSION}-$(arch) -f .Dockerfile ${CACHE} .;\
	)
publish:
	docker push femtopixel/builder
	cat manifest.yml | sed "s/\$$VERSION/${VERSION}/g" > manifest.yaml
	cat manifest.yaml | sed "s/\$$FULLVERSION/${FULLVERSION}/g" > manifest2.yaml
	mv manifest2.yaml manifest.yaml
	manifest-tool push from-spec manifest.yaml
latest: build
	FULLVERSION=latest VERSION=${VERSION} make publish
