#!/bin/sh

COMMIT=$(git rev-parse HEAD)
DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

docker build . -t perlreview/base:1.0 \
	--label="org.opencontainers.image.revision=$COMMIT" \
	--label="org.opencontainers.image.created=$DATE"
