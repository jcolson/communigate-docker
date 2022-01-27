NAME=karmanet/communigate
IMAGE_VERSION=6.2
ALPINE_VERSION=3.15
DEBIAN_VERSION=11.2-slim
BASE=debian:$(DEBIAN_VERSION)
COMMUNIGATE_URL_amd64=https://www.communigate.com/pub/CommuniGatePro/CGatePro-Linux_amd64.deb
COMMUNIGATE_URL_i386=https://www.communigate.com/pub/CommuniGatePro/CGatePro-Linux_i386.deb
COMMUNIGATE_URL_arm=https://www.communigate.com/pub/CommuniGatePro/CGatePro-Linux_armhf.deb

.PHONY: all
all: push

.PHONY: build
build: build_i386 build_amd64 build_arm

.PHONY: build_amd64
build_amd64: Dockerfile
	docker buildx build \
		--platform linux/amd64 \
		--pull \
		-t $(NAME):$(IMAGE_VERSION) \
		--build-arg BASE=$(BASE) \
		--build-arg COMMUNIGATE_URL=$(COMMUNIGATE_URL_amd64) \
		.
	docker tag $(NAME):$(IMAGE_VERSION) $(NAME):latest

# --platform linux/arm/v7,linux/arm64/v8,linux/amd64

.PHONY: build_arm
build_arm: Dockerfile
	docker buildx build \
		--platform linux/arm64/v8 \
		--progress=plain \
		--pull \
		-t $(NAME):$(IMAGE_VERSION) \
		--build-arg BASE=$(BASE)\
		--build-arg COMMUNIGATE_URL=$(COMMUNIGATE_URL_arm) \
		.
	docker tag $(NAME):$(IMAGE_VERSION) $(NAME):latest

.PHONY: build_i386
build_i386: Dockerfile
	docker buildx build \
		--platform linux/i386 \
		--pull \
		-t $(NAME):$(IMAGE_VERSION) \
		--build-arg BASE=$(BASE) \
		--build-arg COMMUNIGATE_URL=$(COMMUNIGATE_URL_i386) \
		.
	docker tag $(NAME):$(IMAGE_VERSION) $(NAME):latest

.PHONY: push
push: push_i386 push_amd64 push_arm

.PHONY: push_i386
push_i386: build_i386
	docker push $(NAME):$(IMAGE_VERSION)
	docker push $(NAME):latest

.PHONY: push
push: push_arm

.PHONY: push_arm
push_arm: build_arm
	docker push $(NAME):$(IMAGE_VERSION)
	docker push $(NAME):latest

.PHONY: push
push: push_amd64

.PHONY: push_amd64
push_amd64: build_amd64
	docker push $(NAME):$(IMAGE_VERSION)
	docker push $(NAME):latest
