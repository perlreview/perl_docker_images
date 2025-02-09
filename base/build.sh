#!/bin/sh

COMMIT=$(git rev-parse HEAD)
DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
NAME=base
VERSION=1.0.3
TAG=perlreview/$NAME:$VERSION

# https://www.docker.com/blog/docker-best-practices-using-tags-and-labels-to-manage-docker-image-sprawl/
docker build . -t $TAG \
	--label="org.opencontainers.image.revision=$COMMIT" \
	--label="org.opencontainers.image.created=$DATE" \
	--label="version=$VERSION" \
	&& docker push $TAG
