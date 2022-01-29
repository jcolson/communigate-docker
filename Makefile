NAME=karmanet/communigate
IMAGE_VERSION=7.1.1
DEBIAN_VERSION=11.2-slim
BASE=debian:$(DEBIAN_VERSION)
COMMUNIGATE_URL_amd64=CGatePro-Linux-7.1-1-x86_64.deb

.PHONY: all
all: push do_manifest

.PHONY: build
build: buildx_amd64

.PHONY: do_manifest
do_manifest:
	-docker manifest rm $(NAME):$(IMAGE_VERSION)
	docker manifest create \
		$(NAME):$(IMAGE_VERSION) \
		--amend $(NAME):$(IMAGE_VERSION)-amd64
	docker manifest push $(NAME):$(IMAGE_VERSION)
	-docker manifest rm $(NAME):latest
	docker manifest create \
		$(NAME):latest \
		--amend $(NAME):$(IMAGE_VERSION)-amd64
	docker manifest push $(NAME):latest

.PHONY: buildx_amd64
buildx_amd64: Dockerfile
	docker buildx build \
		--no-cache \
		--platform linux/amd64 \
		--pull \
		-t $(NAME):$(IMAGE_VERSION)-amd64 \
		--build-arg BASE=$(BASE) \
		--build-arg COMMUNIGATE_URL=$(COMMUNIGATE_URL_amd64) \
		.

.PHONY: push
push: push_amd64

.PHONY: push_amd64
push_amd64: buildx_amd64
	docker push $(NAME):$(IMAGE_VERSION)-amd64
