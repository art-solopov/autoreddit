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
* File::Spec
* LWP::Simple (for Download plugin)
* Try::Tiny (for Download plugin)
* File::Basename (for Download plugin)
* YAML
* JSON
    
Config
------

Example config is in the config.yaml.skel file. Just copy it, rename the copy
as config.yaml and fill in the gaps.

Config fields are:

* rootgroup - the group of subreddits that will be saved in the root
directory (i.e. with no subfolders);
* dir - the root dir of the saved files
(i.e. where the subreddits subdirectories and files from rootgroup will be saved);
* saved_url - the URL of your JSON saved links feed.

Usage
------

    ./autoreddit

TODO
----

* Expand config documentation
* Add plugin documentation
* Make it Windows-friendly
* Make it use actual Reddit authentication