# Docker images for Perl

*This is a new project and it's a mess at the moment*

There are various things we do while developing and testing Perl
programs across several versions of Perl, and this repo provides the
code to build those images. These are in
[Docker Hub](https://hub.docker.com/repositories/perlreview).

There is also [official Perl images from Docker](https://hub.docker.com/_/perl)
maintained at [Perl/docker-perl](https://github.com/Perl/docker-perl).
These are completely usable, basic installations that are updated
frequently.

## The Layers

This project provides several layers of images:

* existing foreign images
* *base* - everything needed to build Perl and deal with CPAN
* Perl-specific layers - basic *perl* installation with no extras
* module-set layers - custom lists of modules for a particular purpose

For example, in testing Perl modules, various `Test::` modules, `Devel::Cover`,
and other things will be already available. Use one of those images for
testing without having to install anything.

Additionally, all layers are available to anyone for any purpose, You
might start with the perl layer

## License

Everything in this repository is covered by the Artistic License 2.0,
and there is a [LICENSE](LICENSE) file in the repository. In short,
use what you find here, and if you want to distribute it, give it a
different name.
