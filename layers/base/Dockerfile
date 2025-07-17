ARG BASE_IMAGE=debian:bookworm-slim
FROM ${BASE_IMAGE}

ARG AUTHOR
ARG VENDOR
ARG WORKDIR=/tmp

LABEL org.opencontainers.image.authors="${AUTHOR}" \
	org.opencontainers.image.description="The base layer that includes everything common among the Perl docker images from The Perl Review" \
	org.opencontainers.image.title="Base image for https://github.com/perlreview/perl_docker_images" \
	org.opencontainers.image.licenses="Artistic-2.0" \
	org.opencontainers.image.url="https://github.com/perlreview/perl_docker_images" \
	org.opencontainers.image.source="https://github.com/perlreview/perl_docker_images/base/Dockerfile" \
	org.opencontainers.image.vendor="${VENDOR}"

WORKDIR ${WORKDIR}

RUN apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
		build-essential \
		bzip2 \
		ca-certificates \
		curl \
		dpkg-dev \
		git \
		jq \
		libdevel-patchperl-perl \
		libssl-dev \
	&& curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg --output /usr/share/keyrings/githubcli-archive-keyring.gpg \
	&& chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && DEBIAN_FRONTEND=noninteractive apt update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install gh \
	&& DEBIAN_FRONTEND=noninteractive apt-get clean \
	&& rm -rf /var/cache/apt/* /var/lib/apt/lists/*

RUN rm -rf ${WORKDIR}/*
