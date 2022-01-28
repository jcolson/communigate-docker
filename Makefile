NAME=karmanet/communigate
IMAGE_VERSION=6.2.14
DEBIAN_VERSION=11.2-slim
BASE=debian:$(DEBIAN_VERSION)
COMMUNIGATE_URL_amd64=https://www.communigate.com/pub/CommuniGatePro/6.2/CGatePro-Linux_6.2-14_amd64.deb
COMMUNIGATE_URL_i386=https://www.communigate.com/pub/CommuniGatePro/6.2/CGatePro-Linux_6.2-14_i386.deb
COMMUNIGATE_URL_arm=https://www.communigate.com/pub/CommuniGatePro/6.2/CGatePro-Linux_6.2-14_armhf.deb

.PHONY: all
all: push do_manifest

.PHONY: build
build: buildx_i386 buildx_amd64 buildx_armhf

.PHONY: do_manifest
do_manifest:
	-docker manifest rm $(NAME):$(IMAGE_VERSION)
	docker manifest create \
		$(NAME):$(IMAGE_VERSION) \
		--amend $(NAME):$(IMAGE_VERSION)-amd64 \
		--amend $(NAME):$(IMAGE_VERSION)-i386 \
		--amend $(NAME):$(IMAGE_VERSION)-armhf
#		--amend $(NAME):$(IMAGE_VERSION)-arm64v8
	docker manifest push $(NAME):$(IMAGE_VERSION)
	-docker manifest rm $(NAME):latest
	docker manifest create \
		$(NAME):latest \
		--amend $(NAME):$(IMAGE_VERSION)-amd64 \
		--amend $(NAME):$(IMAGE_VERSION)-i386 \
		--amend $(NAME):$(IMAGE_VERSION)-armhf
#		--amend $(NAME):$(IMAGE_VERSION)-arm64v8
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

.PHONY: buildx_arm64v8
buildx_arm64v8: Dockerfile
	docker buildx build \
		--platform linux/arm64/v8 \
		--progress=plain \
		--pull \
		-t $(NAME):$(IMAGE_VERSION)-arm64v8 \
		--build-arg BASE=$(BASE)\
		--build-arg COMMUNIGATE_URL=$(COMMUNIGATE_URL_arm) \
		.

.PHONY: buildx_armhf
buildx_armhf: Dockerfile
	docker buildx build \
		--platform linux/armhf \
		--progress=plain \
		--pull \
		-t $(NAME):$(IMAGE_VERSION)-armhf \
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
push: push_i386 push_amd64 push_armhf

.PHONY: push_i386
push_i386: buildx_i386
	docker push $(NAME):$(IMAGE_VERSION)-i386

.PHONY:push_armhf
push_armhf: buildx_armhf
	docker push $(NAME):$(IMAGE_VERSION)-armhf

.PHONY: push_arm64v8
push_arm64v8: buildx_arm64v8
	docker push $(NAME):$(IMAGE_VERSION)-arm64v8

.PHONY: push_amd64
push_amd64: buildx_amd64
	docker push $(NAME):$(IMAGE_VERSION)-amd64
