FROM ubuntu:24.04
MAINTAINER briandfoy@pobox.com
LABEL org.opencontainers.image.authors="briandfoy@pobox.com" \
	org.opencontainers.image.description="The base layer that includes everything common among the Perl docker images from The Perl Review" \
	org.opencontainers.image.title="Base image for https://github.com/perlreview/perl_docker_images" \
	org.opencontainers.image.licenses="Artistic-2.0" \
	org.opencontainers.image.url="https://github.com/perlreview/perl_docker_images" \
	org.opencontainers.image.source="https://github.com/perlreview/perl_docker_images/base/Dockerfile" \
	org.opencontainers.image.vendor="The Perl Review"

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		build-essential \
		bzip2 \
		curl \
		git \
		perl-doc \
		perl-modules \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* \
	&& groupadd -g 137 perlreview \
	&& useradd -r -u 137 -g perlreview perlreview \
	&& cpan -T Devel::PatchPerl

CMD ["bash"]
