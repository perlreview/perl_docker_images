#!/bin/sh

BASE_TAG=$(grep ^VERSION ../base/build.sh | xargs perl -le 'print +(split/=/,$ARGV[0])[-1]')
COMMIT=$(git rev-parse HEAD)
DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
PERL_VERSION=5.42.0
NAME=perl-$PERL_VERSION
VERSION=1.0.2
TAG=perlreview/$NAME:$VERSION
REPO_DIR=$( dirname $0 | xargs readlink -f | xargs basename )

# https://www.docker.com/blog/docker-best-practices-using-tags-and-labels-to-manage-docker-image-sprawl/
docker build . -t $TAG \
	--label="org.opencontainers.image.description='Perl $PERL_VERSION with extras'" \
	--label="org.opencontainers.image.revision=$COMMIT" \
	--label="org.opencontainers.image.created=$DATE" \
	--label="version=$VERSION" \
	--build-arg BASE_TAG=$BASE_TAG \
	--build-arg PERL_VERSION=$PERL_VERSION \
	--build-arg REPO_DIR=$REPO_DIR \
	&& docker push $TAG
