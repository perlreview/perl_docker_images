ARG BASE_IMAGE=debian:bookworm-slim
FROM ${BASE_IMAGE}

ARG AUTHOR
ARG USERNAME
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

# Do I need to install the
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		build-essential \
		bzip2 \
		ca-certificates \
		curl \
		dpkg-dev \
		git \
		libssl-dev \
		perl-modules \
	&& apt-get clean \
	&& rm -rf /var/cache/apt/* /var/lib/apt/lists/* \
	&& groupadd -g 137 $USERNAME \
	&& useradd -D \
	&& useradd -m -r -u 137 -g $USERNAME $USERNAME \
	&& /usr/bin/cpan -v \
	&& /usr/bin/perl -pi -e "s/'m(?:ake|build)pl_arg' => \Kq\[.*?\],/q[],/" /root/.cpan/CPAN/MyConfig.pm \
	&& /usr/bin/perl /usr/bin/cpan -T Module::Runtime \
	&& /usr/bin/perl /usr/bin/cpan -T Devel::PatchPerl

RUN rm -rf ${WORKDIR}/*

USER $USERNAME

CMD ["bash"]
