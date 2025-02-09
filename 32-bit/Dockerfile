FROM ubuntu:24.04
MAINTAINER briandfoy@pobox.com
LABEL org.opencontainers.image.authors="briandfoy@pobox.com"

RUN dpkg --add-architecture i386
RUN apt-get update && apt-get install -y \
	build-essential \
	bzip2 \
	curl \
	gcc-multilib \
	git \
	libcrypt1:i386 \
	perl-doc \
	perl-modules
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
RUN gcc --version

WORKDIR /tmp

RUN cpan -T Devel::PatchPerl

RUN curl -O https://www.cpan.org/src/5.0/perl-5.10.1.tar.bz2
RUN bzip2 -d perl-5.10.1.tar.bz2
RUN tar -xf perl-5.10.1.tar

WORKDIR /tmp/perl-5.10.1

RUN patchperl
RUN ./Configure -des \
	-Dprefix=/usr/local \
	-Accflags="-m32 -march=i686" -Aldflags="-m32 -march=i686" \
	-Alddlflags="-shared -m32 -march=i686"
RUN make install
WORKDIR /repo
RUN rm -rf /tmp/*

RUN perl -V:intsize

RUN /usr/local/bin/cpan -T \
	Devel::PatchPerl \
	Term::ReadLine \
	Test::More \
	YAML \
	XML::Entities

CMD [ "bash" ]
