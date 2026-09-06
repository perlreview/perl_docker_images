ARG BASE_IMAGE=debian:trixie-slim
FROM ${BASE_IMAGE}

RUN apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
		build-essential \
		bzip2 \
		ca-certificates \
		curl \
		dpkg-dev \
		git \
		gzip \
		jq \
		libdevel-patchperl-perl \
		libssl-dev \
		make \
		netbase \
		tar \
		xz-utils \
		zlib1g-dev \
	&& curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg --output /usr/share/keyrings/githubcli-archive-keyring.gpg \
	&& chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && DEBIAN_FRONTEND=noninteractive apt update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install gh \
	&& DEBIAN_FRONTEND=noninteractive apt-get clean \
	&& DEBIAN_FRONTEND=noninteractive apt-get autoclean \
	&& DEBIAN_FRONTEND=noninteractive apt-get autoremove \
	&& rm -rf /var/cache/apt/* /var/lib/apt/lists/*
