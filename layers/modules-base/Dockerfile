ARG PERL_BASE_NAME=replace_me
ARG PERL_BASE_TAG=latest
ARG ACCOUNT=perlreview
ARG REGISTRY=ghcr.io
ARG PERL_VERSION=replaceme

FROM ${REGISTRY}/${ACCOUNT}/${PERL_BASE_NAME}:${PERL_BASE_TAG}
ARG BUILDKIT_SBOM_SCAN_STAGE=true

ARG PERL_BASE_NAME
ARG PERL_BASE_TAG
ARG ACCOUNT
ARG PERL_VERSION
ARG REGISTRY
ARG REPO_DIR


LABEL org.opencontainers.image.authors="briandfoy@pobox.com" \
	org.opencontainers.image.title="Base image enhanced with modules for https://github.com/perlreview/perl_docker_images" \
	org.opencontainers.image.licenses="Artistic-2.0" \
	org.opencontainers.image.url="https://github.com/perlreview/perl_docker_images" \
	org.opencontainers.image.source="https://github.com/perlreview/perl_docker_images" \
	org.opencontainers.image.vendor="The Perl Review"

USER root

ENV OPENSSL_PREFIX=/usr

RUN cd /tmp \
	&& printf "tcp 6 TCP\nudp 17 UDP\n" >> /etc/protocols \
	&& curl -fLO https://www.cpan.org/authors/id/M/MI/MIYAGAWA/App-cpanminus-1.7047.tar.gz \
	&& tar -xzf App-cpanminus-1.7047.tar.gz \
	&& cd App-cpanminus-1.7047 \
	&& /usr/local/bin/perl -pi -e 's{http://(www\.cpan\.org|backpan\.perl\.org|cpan\.metacpan\.org|fastapi\.metacpan\.org|cpanmetadb\.plackperl\.org)}{https://$1}g' bin/cpanm \
	&& /usr/local/bin/perl -pi -e 's{try_lwp=>1}{try_lwp=>0}g' bin/cpanm \
	&& /usr/local/bin/perl bin/cpanm --notest . \
	&& cd /tmp \
	&& /usr/local/bin/cpanm RJBS/Test-Fatal-0.017.tar.gz PETDANCE/HTML-Tagset-3.24.tar.gz \
	&& /usr/local/bin/cpanm --notest parent \
	&& /usr/local/bin/cpanm URI \
	&& /usr/local/bin/cpanm --verbose Net::SSLeay IO::Socket::SSL \
	&& /usr/local/bin/cpanm --notest \
		App::Cpan \
		ExtUtils::MakeMaker \
		HTTP::Tiny \
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

ENV PERL_VERSION=${PERL_VERSION}
ENV PERL_LWP_SSL_VERIFY_HOSTNAME=0
ENV PATH="/usr/local/bin:${PATH}"
CMD [ "/usr/local/bin/perl", "-de0" ]
