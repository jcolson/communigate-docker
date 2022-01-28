NAME=karmanet/communigate
IMAGE_VERSION=6.2
ALPINE_VERSION=3.15
DEBIAN_VERSION=11.2-slim
BASE=debian:$(DEBIAN_VERSION)
COMMUNIGATE_URL_amd64=https://www.communigate.com/pub/CommuniGatePro/CGatePro-Linux_amd64.deb
COMMUNIGATE_URL_i386=https://www.communigate.com/pub/CommuniGatePro/CGatePro-Linux_i386.deb
COMMUNIGATE_URL_arm=https://www.communigate.com/pub/CommuniGatePro/CGatePro-Linux_armhf.deb

.PHONY: all
all: push do_manifest

.PHONY: build
build: buildx_i386 buildx_amd64 buildx_arm

.PHONY: do_manifest
do_manifest:
	docker manifest create \
		$(NAME):$(IMAGE_VERSION) \
		--amend $(NAME):$(IMAGE_VERSION)-amd64 \
		--amend $(NAME):$(IMAGE_VERSION)-i386 \
		--amend $(NAME):$(IMAGE_VERSION)-arm64v8
	docker manifest push $(NAME):$(IMAGE_VERSION)
	docker manifest create \
		$(NAME):latest \
		--amend $(NAME):$(IMAGE_VERSION)-amd64 \
		--amend $(NAME):$(IMAGE_VERSION)-i386 \
		--amend $(NAME):$(IMAGE_VERSION)-arm64v8
	docker manifest push $(NAME):latest

.PHONY: buildx_amd64
buildx_amd64: Dockerfile
	docker buildx build \
		--platform linux/amd64 \
		--pull \
		-t $(NAME):$(IMAGE_VERSION)-amd64 \
		--build-arg BASE=$(BASE) \
		--build-arg COMMUNIGATE_URL=$(COMMUNIGATE_URL_amd64) \
		.

# --platform linux/arm/v7,linux/arm64/v8,linux/amd64

.PHONY: buildx_arm
buildx_arm: Dockerfile
	docker buildx build \
		--platform linux/arm64/v8 \
		--progress=plain \
		--pull \
		-t $(NAME):$(IMAGE_VERSION)-arm64v8 \
		--build-arg BASE=$(BASE)\
		--build-arg COMMUNIGATE_URL=$(COMMUNIGATE_URL_arm) \
		.

.PHONY: buildx_i386
buildx_i386: Dockerfile
	docker buildx build \
		--platform linux/i386 \
		--pull \
		-t $(NAME):$(IMAGE_VERSION)-i386 \
		--build-arg BASE=$(BASE) \
		--build-arg COMMUNIGATE_URL=$(COMMUNIGATE_URL_i386) \
		.

.PHONY: push
push: push_i386 push_amd64 push_arm

.PHONY: push_i386
push_i386: buildx_i386
	docker push $(NAME):$(IMAGE_VERSION)-i386

.PHONY: push
push: push_arm

.PHONY: push_arm
push_arm: buildx_arm
	docker push $(NAME):$(IMAGE_VERSION)-arm64v8

.PHONY: push
push: push_amd64

.PHONY: push_amd64
push_amd64: buildx_amd64
	docker push $(NAME):$(IMAGE_VERSION)-amd64
