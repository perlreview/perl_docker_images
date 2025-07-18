ARG BASE_NAME=base
ARG BASE_TAG=latest
ARG DOCKER_HUB_ACCOUNT=perlreview

FROM ${DOCKER_HUB_ACCOUNT}/${BASE_NAME}:${BASE_TAG}
ARG BUILDKIT_SBOM_SCAN_STAGE=true

ARG BASE_NAME
ARG BASE_TAG
ARG DOCKER_HUB_ACCOUNT
ARG PERL_ARCHIVE_DIGEST
ARG PERL_URL
ARG PERL_URL_BASENAME
ARG PERL_VERSION
ARG REPO_DIR

LABEL org.opencontainers.image.authors="briandfoy@pobox.com" \
	org.opencontainers.image.title="Base image for https://github.com/perlreview/perl_docker_images" \
	org.opencontainers.image.licenses="Artistic-2.0" \
	org.opencontainers.image.url="https://github.com/perlreview/perl_docker_images" \
	org.opencontainers.image.source="https://github.com/perlreview/perl_docker_images" \
	org.opencontainers.image.vendor="The Perl Review"

RUN cd /tmp \
	&& echo PERL_VERION ${PERL_VERSION} \
	&& curl -s -fLO ${PERL_URL} \
	&& echo "${PERL_ARCHIVE_DIGEST} ${PERL_URL_BASENAME}"  \
	&& echo "${PERL_ARCHIVE_DIGEST} *${PERL_URL_BASENAME}" | sha256sum --strict --check - \
	&& tar -xzf perl-${PERL_VERSION}.tar.gz \
	&& cd perl-${PERL_VERSION} \
	&& patchperl \
	&& ./Configure -des -Dprefix=/usr/local \
	&& make install \
	&& rm -rf /tmp/*


ENV PATH="/usr/local/bin:${PATH}"
CMD [ "/usr/local/bin/perl", "-de0" ]
