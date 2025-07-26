#!/usr/bin/perl
use v5.30;
use utf8;
use strict;
use experimental qw(signatures);

use File::Spec::Functions qw(catfile);
use FindBin;
use JSON::PP qw(decode_json);

my %args = (
	account       => 'perlreview',
	commit        => do { `git rev-parse HEAD` =~ s/\s+\z//r },
	date          => do { `date -u +"%Y-%m-%dT%H:%M:%SZ"` =~ s/\s+\z//r },
	image_version => do {
		my( $minute, $hour, $day, $month, $year ) = (localtime)[1..5];
		sprintf '%4d%02d%02d.%02d%02d', $year + 1900, $month + 1, $day, $hour, $minute;
		},
	perl_base_tag => 'latest',
	repo_dir      => 'https://github.com/perlreview/perl_docker_images',
	username      => 'perlreview',
#	platforms     => [qw( linux/amd64 linux/arm64 linux/386 )],
	platforms     => [qw( linux/arm64 linux/386 )],
	name          => "modules",
	);

my $version_info = do {
	my $json = slurp("$FindBin::Bin/../../data/checksums.json");
	decode_json( $json )->{data};
	};

my $latest = do {
	my $json = slurp("$FindBin::Bin/../../data/latest.json");
	my $data = decode_json( $json )->{data};

	[
		map { join '.', ( 5, $data->{$_}->@[-2,-1] ) }
		grep { $_ % 2 == 0 }
		keys $data->%*
	]
	};

my @versions = do {
	if( @ARGV > 0 ) { @ARGV }
	else            { $latest->@* }
	};

VERSION: foreach my $version ( @versions ) {
	unless( exists $version_info->{$version} ) {
		warn "Do not have settings for <$version>. Skipping.\n";
		next VERSION;
		}

	my $compression = 'gz';
	my $info = $version_info->{$version}{$compression};
	next if $info->{minor} % 2;

	$args{perl_version} = $version;
	$args{perl_minor_version} = $version =~ s/\A5\.\d+\K.*//r;

	$args{tags} = [];
	foreach my $tag ( $args{'image_version'}, 'latest' ) {
		push $args{tags}->@*, map { sprintf '%s/%s-%s:%s', $args{account}, $_, $args{name}, $tag } @args{qw(perl_version perl_minor_version)};
		}

	$args{perl_base_name} = "perl-$version-base";
	$args{digest}         = $info->{sha256};

	my $success = build_image( \%args );
	exit 1 unless $success;
	}

# https://www.docker.com/blog/generate-sboms-with-buildkit/
sub build_image ($args) {
	local $ENV{BUILDKIT_PROGRESS} = 'plain';

	my $Dockerfile = catfile($FindBin::Bin, 'Dockerfile');
	my @command = qw(docker buildx build);
	push @command,
		q(-f), $Dockerfile,
		q(--no-cache),
		( map { ( '-t', $_ ) } $args->{tags}->@* ),
		qw(--progress plain),
		q(--sbom=true),
		q(--platform),  join( ',', $args->{platforms}->@*),
		q(--label),     qq(org.opencontainers.image.authors='Perl $args->{perl_version} with extras'),
		q(--label),     qq(org.opencontainers.image.description='Perl $args->{perl_version} with extras'),
		q(--label),     qq(org.opencontainers.image.revision=$args->{commit}),
		q(--label),     qq(org.opencontainers.image.created=$args->{date}),
		q(--build-arg), qq(DOCKER_HUB_ACCOUNT=$args->{account}),
		q(--build-arg), qq(PERL_BASE_NAME=$args->{perl_base_name}),
		q(--build-arg), qq(PERL_BASE_TAG=latest),
		q(--build-arg), qq(PERL_VERSION=$args->{perl_version}),
		q(--push),
		$FindBin::Bin;

	say STDERR "COMMAND: " . dumper(\@command);

	my $rc = system @command;
	say STDERR "EXIT CODE: <$rc> \$!: $!";
	unless( $rc == 0 ) {
		warn "docker build failed: $!\n";
		return;
		}

	return 1;
	}

sub dumper {
	state $rc = require Data::Dumper;
	Data::Dumper->new([@_])->Indent(1)->Sortkeys(1)->Terse(1)->Useqq(1)->Dump;
	}

sub slurp {
	do {
		local( @ARGV, $/ ) = @_;
		<>;
		};
	}
