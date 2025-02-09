FROM ubuntu:24.04
MAINTAINER briandfoy@pobox.com
LABEL org.opencontainers.image.authors="briandfoy@pobox.com"

RUN apt-get update && apt-get install -y \
	build-essential \
	bzip2 \
	curl \
	gcc-multilib \
	git \
	perl-doc \
	perl-modules
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
RUN gcc --version

WORKDIR /tmp

RUN cpan -T Devel::PatchPerl

RUN curl -O https://www.cpan.org/src/5.0/perl-5.40.1.tar.gz
RUN tar -xzf perl-5.40.1.tar.gz

WORKDIR /tmp/perl-5.40.1

RUN patchperl
RUN ./Configure -des -Dprefix=/usr/local
RUN make install

WORKDIR /repo
RUN rm -rf /tmp/*

RUN perl -V:intsize

RUN /usr/local/bin/cpan -T \
	App::Cpan \
	App::cpanminus \
	Devel::Cover \
	ExtUtils::MakeMaker \
	HTTP::Tiny \
	IO::Socket::SSL \
	LWP::Protocol::https \
	Term::ReadLine \
	Test::CPAN::Changes \
	Test::Manifest \
	Test::More \
	YAML \
	XML::Entities

CMD [ "bash" ]
