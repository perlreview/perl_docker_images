#!/bin/sh

COMMIT=$(git rev-parse HEAD)
DATE=$(date -u +"%Y%m%d.%H%M%S")
DOCKER_HUB_ACCOUNT=perlreview
NAME=base
VERSION=$DATE
IMAGE_NAME=$DOCKER_HUB_ACCOUNT/$NAME
TAG=$IMAGE_NAME:$VERSION
LATEST_TAG=$IMAGE_NAME:latest
AUTHOR=briandfoy@pobox.com
USERNAME=perlreview
BASE_IMAGE=debian:bookworm-slim
CURRENT_BUILD_DIGEST_FILE=/tmp/$0-$$.digest
PRIOR_BUILD_DIGEST_FILE=.digest.txt
DIGEST_FILES="build.sh Dockerfile"

sha256sum $DIGEST_FILES > $CURRENT_BUILD_DIGEST_FILE

if [ -e $PRIOR_BUILD_DIGEST_FILE ]; then
	if cmp -s $PRIOR_BUILD_DIGEST_FILE $CURRENT_BUILD_DIGEST_FILE; then
	  echo "Digests are identical: no need to rebuild."
	  exit 1
	else
	  echo "Digests differ: rebuilding"
	fi
fi

# https://www.docker.com/blog/docker-best-practices-using-tags-and-labels-to-manage-docker-image-sprawl/
docker buildx build . \
	-t $TAG \
	-t $LATEST_TAG \
	--platform linux/amd64,linux/arm64,linux/386 \
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

sha256sum $DIGEST_FILES > $PRIOR_BUILD_DIGEST_FILE
