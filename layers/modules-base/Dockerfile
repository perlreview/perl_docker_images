ARG PERL_BASE_NAME=replace_me
ARG PERL_BASE_TAG=latest
ARG DOCKER_HUB_ACCOUNT=perlreview

FROM ${DOCKER_HUB_ACCOUNT}/${PERL_BASE_NAME}:${PERL_BASE_TAG}
ARG BUILDKIT_SBOM_SCAN_STAGE=true

ARG PERL_BASE_NAME
ARG PERL_BASE_TAG
ARG DOCKER_HUB_ACCOUNT
ARG REPO_DIR

LABEL org.opencontainers.image.authors="briandfoy@pobox.com" \
	org.opencontainers.image.title="Base image enhanced with modules for https://github.com/perlreview/perl_docker_images" \
	org.opencontainers.image.licenses="Artistic-2.0" \
	org.opencontainers.image.url="https://github.com/perlreview/perl_docker_images" \
	org.opencontainers.image.source="https://github.com/perlreview/perl_docker_images" \
	org.opencontainers.image.vendor="The Perl Review"

USER root

ENV OPENSSLDIR=/usr/lib/ssl
ENV OPENSSL_PREFIX=/usr
ENV PERL_CPANM_OPT=--verbose

RUN cd /tmp \
	&& apt-get update && apt-get install -y pkg-config \
	&& curl -fLO https://www.cpan.org/authors/id/M/MI/MIYAGAWA/App-cpanminus-1.7047.tar.gz \
	&& tar -xzf App-cpanminus-1.7047.tar.gz \
	&& cd App-cpanminus-1.7047 \
	&& /usr/local/bin/perl -pi -e 's{http://(www\.cpan\.org|backpan\.perl\.org|cpan\.metacpan\.org|fastapi\.metacpan\.org|cpanmetadb\.plackperl\.org)}{https://$1}g' bin/cpanm \
	&& /usr/local/bin/perl -pi -e 's{try_lwp=>1}{try_lwp=>0}g' bin/cpanm \
	&& /usr/local/bin/perl bin/cpanm --verbose . \
	&& which cpanm \
	&& cd /root \
	&& /usr/local/bin/cpanm --notest \
		App::Cpan \
		ExtUtils::MakeMaker \
		HTTP::Tiny \
		Net::SSLeay \
		IO::Socket::SSL \
		LWP \
		LWP::Protocol::https \
		Term::ReadLine \
		Test::CPAN::Changes \
		Test::Exception \
		Test::Manifest \
		Test::More \
		Test::Output \
		Test::Pod \
		Test::Pod::Coverage \
		XML::Entities \
		YAML \
	&& rm -rf /tmp/* /root/.cpan /root/.cpanm

ENV PATH="/usr/local/bin:${PATH}"
CMD [ "/usr/local/bin/perl", "-de0" ]
