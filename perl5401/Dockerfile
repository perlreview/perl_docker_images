FROM perlreview/base:${BASE_TAG}

MAINTAINER briandfoy@pobox.com
LABEL org.opencontainers.image.authors="briandfoy@pobox.com" \
	org.opencontainers.image.description="Perl v5.40.1 with extras" \
	org.opencontainers.image.title="Base image for https://github.com/perlreview/perl_docker_images" \
	org.opencontainers.image.licenses="Artistic-2.0" \
	org.opencontainers.image.url="https://github.com/perlreview/perl_docker_images" \
	org.opencontainers.image.source="https://github.com/perlreview/perl_docker_images/perl5401/Dockerfile" \
	org.opencontainers.image.vendor="The Perl Review"

RUN cpan -T Devel::PatchPerl \
	&& curl -O https://www.cpan.org/src/5.0/perl-${PERL_VERSION}.tar.gz \
	&& tar -xzf perl-${PERL_VERSION}.tar.gz \
	&& cd perl-${PERL_VERSION} \
	&& patchperl \
	&& ./Configure -des -Dprefix=/usr/local \
	&& make install \
	&& cd /repo \
	&& rm -rf /tmp/* \
	&& /usr/local/bin/cpan -T \
		App::Cpan \
		App::cpanminus \
		Devel::Cover \
		ExtUtils::MakeMaker \
		HTTP::Tiny \
		IO::Socket::SSL \
		LWP::Protocol::https \
		Term::ReadLine \
		Test::CPAN::Changes \
		Test::Exception \
		Test::Manifest \
		Test::More \
		Test::Pod \
		Test::Pod::Coverage \
		Test::Output \
		YAML \
		XML::Entities

CMD [ "/usr/local/bin/perl", "-e" ]
