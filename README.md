autoreddit
==========

Automatic download program for Reddit (with plugin engine)

Requirements
------------

Build requirements:

* Dist::Zilla
* ExtUtils::MakeMaker
* Devel::Cover
* Test::More

Run requirements:

* Perl v5.10 or higher
* Module::Load
* LWP::Simple (for Download plugin)
* Try::Tiny (for Download plugin)
* File::Basename (for Download plugin)
* YAML
* JSON

You can find out run requirements by running

    dzil listdeps
    
Config
------

Example config is in the config.yaml.skel file. Just copy it, rename the copy
as config.yaml and fill in the gaps.

Usage
------

    ./autoreddit

TODO
----

* Expand config documentation
* Add plugin documentation
* Make it Windows-friendly