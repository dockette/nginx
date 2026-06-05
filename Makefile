DOCKER_IMAGE=dockette/nginx
DOCKER_TAG?=latest
DOCKER_PLATFORMS?=linux/amd64,linux/arm64

.PHONY: build
build:
	docker buildx build --platform ${DOCKER_PLATFORMS} -t ${DOCKER_IMAGE}:${DOCKER_TAG} .

.PHONY: test
test:
	docker run --rm ${DOCKER_IMAGE}:${DOCKER_TAG} nginx -v
	docker run --rm ${DOCKER_IMAGE}:${DOCKER_TAG} sh -lc 'mkdir -p /etc/nginx/user.conf.d && nginx -t'

.PHONY: run
run:
	docker run --rm -it -p 80:80 -p 443:443 ${DOCKER_IMAGE}:${DOCKER_TAG}
