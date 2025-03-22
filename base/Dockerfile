FROM ubuntu:24.04

ARG MAINTAINER
ARG USERNAME
ARG VENDOR

MAINTAINER ${MAINTAINER}
LABEL org.opencontainers.image.authors="${AUTHOR}" \
	org.opencontainers.image.description="The base layer that includes everything common among the Perl docker images from The Perl Review" \
	org.opencontainers.image.title="Base image for https://github.com/perlreview/perl_docker_images" \
	org.opencontainers.image.licenses="Artistic-2.0" \
	org.opencontainers.image.url="https://github.com/perlreview/perl_docker_images" \
	org.opencontainers.image.source="https://github.com/perlreview/perl_docker_images/base/Dockerfile" \
	org.opencontainers.image.vendor="${VENDOR}"

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		build-essential \
		bzip2 \
		ca-certificates \
		curl \
		dpkg-dev \
		git \
		libssl-dev \
		perl-doc \
		perl-modules \
	&& apt-get clean \
	&& rm -rf /var/cache/apt/* /var/lib/apt/lists/* \
	&& echo USERNAME $USERNAME \
	&& groupadd -g 137 $USERNAME \
	&& useradd -r -u 137 -g $USERNAME $USERNAME \
	&& cpan -T Devel::PatchPerl

CMD ["bash"]
