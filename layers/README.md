# Layers

## base

The *base* layer is some sort of debian slim with all of the basic packages updated and installed.

## perl-base

The perl layers build on *base* by compiling exactly one *perl* and installing it in */usr/local/*.

When base is updated, all of these should be updated. These will also be updated when perl has point releases.

Eventually these can expand to different types of compilation, but so far this will be just the default install.

## perl-modules

The modules layer installs very modules into the layers from *perl-base*. This is a separate layer because this will be rebuilt often (weekly?) and installing perl each time takes awhile.
