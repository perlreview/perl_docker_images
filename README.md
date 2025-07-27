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
* *base* - everything needed to build perl with the defaults, but not building perl yet
* Perl-specific layers - basic *perl* installation with no extras, with the *perl* installed under */usr/local* (so the system *perl* is the base system version)
* module-set layers - custom lists of modules for a particular purpose, with each module being compatible with Perl v5.8

For example, in testing Perl modules, various `Test::` modules, `Devel::Cover`,
and other things will be already available. Use one of those images for
testing without having to install anything.

Additionally, all layers are available to anyone for any purpose, You
might start with the perl layer and augment it however you like

## License

Everything in this repository is covered by the Artistic License 2.0,
and there is a [LICENSE](LICENSE) file in the repository. In short,
use what you find here, and if you want to distribute it, give it a
different name.


## See Also

* https://hub.docker.com/_/perl
* https://docs.github.com/en/actions/how-tos/use-cases-and-examples/publishing-packages/publishing-docker-images#publishing-images-to-docker-hub-and-github-packages
* https://docs.github.com/en/actions/reference/dockerfile-support-for-github-actions
