#!/bin/sh

COMMIT=$(git rev-parse HEAD)
DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
DOCKER_HUB_ACCOUNT=perlreview
NAME=base
VERSION=1.0.5
IMAGE_NAME=$DOCKER_HUB_ACCOUNT/$NAME
TAG=$IMAGE_NAME:$VERSION
LATEST_TAG=$IMAGE_NAME:latest
AUTHOR=briandfoy@pobox.com
USERNAME=perlreview
BASE_IMAGE=debian:bookworm-slim

# https://www.docker.com/blog/docker-best-practices-using-tags-and-labels-to-manage-docker-image-sprawl/
docker build . \
	-t $TAG \
	-t $LATEST_TAG \
	--progress=plain \
	--sbom=true \
	--label="org.opencontainers.image.revision=$COMMIT" \
	--label="org.opencontainers.image.created=$DATE" \
	--label="version=$VERSION" \
	--build-arg AUTHOR=${AUTHOR} \
	--build-arg MAINTAINER=${MAINTAINER} \
	--build-arg USERNAME=${USERNAME} \
	--build-arg VENDOR=${VENDOR} \
	--build-arg BASE_IMAGE=${BASE_IMAGE} \
	--push
