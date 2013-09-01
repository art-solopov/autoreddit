autoreddit
==========

Automatic download program for Reddit (with plugin engine)

Requirements
------------

Build requirements:

* Dist::Zilla
* Dist::Zilla::Plugin::Run::AfterBuild
* ExtUtils::MakeMaker
* Devel::Cover
* Test::More

Run requirements:

* Module::Load
* LWP::Simple (for Download plugin)
* Try::Tiny (for Download plugin)
* File::Basename (for Download plugin)

You can find out run requirements by running

    dzil listdeps

Usage
------

    ./autoreddit