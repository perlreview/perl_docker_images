#!/bin/bash
set -euox pipefail

find_up() {
  local target="$1"
  local max_levels="${2:-10}"
  local dir="$PWD"
  local level=0

  while [[ "$dir" != "/" && "$level" -le "$max_levels" ]]; do
    if [[ -e "$dir/$target" ]]; then
      echo "$dir/$target"
      return 0
    fi
    if [[ -e "$dir/.git" ]]; then
      return 1
    fi
    dir="$(dirname "$dir")"
    ((level++))
  done
  return 1
}

SETTINGS_FILE=settings.json
SETTINGS_PATH=$(find_up "$SETTINGS_FILE" 5)
echo Settings Path "<$SETTINGS_PATH>"

if [[ ! -f "$SETTINGS_PATH" ]]; then
  echo "File not found: $SETTINGS_FILE" >&2
  exit 1
fi
SECTION=base

AUTHORS=$(jq -re .authors "$SETTINGS_PATH")
BASE_IMAGE=$(jq -re --arg s "$SECTION" '.[$s].image' "$SETTINGS_PATH")
COMMIT=$(git rev-parse HEAD)
DESCRIPTION=$(jq -re --arg s "$SECTION" '.[$s].description' "$SETTINGS_PATH")
DATE=$(date -u +"%Y%m%d.%H%M%S")
GITHUB_ORG_ACCOUNT=$(jq -re .github_org_account "$SETTINGS_PATH")
GITHUB_USERNAME=$(jq -re .github_username "$SETTINGS_PATH")
LICENSES=$(jq -re .licenses "$SETTINGS_PATH")
NAME=$(jq -re --arg s "$SECTION" '.[$s].name' "$SETTINGS_PATH")
REGISTRY=$(jq -re .registry "$SETTINGS_PATH")
REPO=$(jq -re .repo_dir "$SETTINGS_PATH")
REPO_RAW_BASE="$REPO/blob/$COMMIT"
SOURCE="$REPO_RAW_BASE/layers/base/Dockerfile"
TITLE=$(jq -re --arg s "$SECTION" '.[$s].title' "$SETTINGS_PATH")
URL=https://github.com/orgs/$GITHUB_ORG_ACCOUNT/packages/container/package/base
VENDOR=$(jq -re .vendor "$SETTINGS_PATH")
VERSION=$DATE

echo Commit "<$COMMIT>"

IMAGE_NAME="$REGISTRY/$GITHUB_ORG_ACCOUNT/$NAME"
LATEST_TAG=$IMAGE_NAME:latest
README_URL="$REPO_RAW_BASE/README.md"
TAG=$IMAGE_NAME:$VERSION

echo Image name "<$IMAGE_NAME>"

# https://www.docker.com/blog/docker-best-practices-using-tags-and-labels-to-manage-docker-image-sprawl/
docker buildx build . \
	-t "$TAG" \
	-t "$LATEST_TAG" \
	--platform linux/amd64,linux/arm64,linux/386 \
	--progress plain \
	--sbom true \
	--label "org.opencontainers.image.authors=$AUTHORS" \
	--label "org.opencontainers.image.created=$DATE" \
	--label "org.opencontainers.image.description=$DESCRIPTION" \
	--label "org.opencontainers.image.documentation=$README_URL" \
	--label "org.opencontainers.image.licenses=$LICENSES" \
	--label "org.opencontainers.image.revision=$COMMIT" \
	--label "org.opencontainers.image.source=$SOURCE" \
	--label "org.opencontainers.image.title=$TITLE" \
	--label "org.opencontainers.image.url=$URL" \
	--label "org.opencontainers.image.vendor=$VENDOR" \
	--label "org.opencontainers.image.version=$VERSION" \
	--annotation "index:org.opencontainers.image.authors=$AUTHORS" \
	--annotation "index:org.opencontainers.image.created=$DATE" \
	--annotation "index:org.opencontainers.image.description=$DESCRIPTION" \
	--annotation "index:org.opencontainers.image.documentation=$README_URL" \
	--annotation "index:org.opencontainers.image.licenses=$LICENSES" \
	--annotation "index:org.opencontainers.image.revision=$COMMIT" \
	--annotation "index:org.opencontainers.image.source=$SOURCE" \
	--annotation "index:org.opencontainers.image.title=$TITLE" \
	--annotation "index:org.opencontainers.image.url=$URL" \
	--annotation "index:org.opencontainers.image.vendor=$VENDOR" \
	--annotation "index:org.opencontainers.image.version=$VERSION" \
	--build-arg "BASE_IMAGE=${BASE_IMAGE}" \
	--push
