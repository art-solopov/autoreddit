autoreddit
==========

I'm sorry for the delay in autoreddit development. Frankly, I don't wanna leave this project to die or something like that, so I'll pull myself together and work on it.

First thing first. It works. I've been using it for several months and it's downloading pics that I saved on Reddit like a charm.
Second, I don't wanna stop on this. I want to solve some important problems and make more plugins for non-direct image links (like Imgur), galleries and such. Heck, maybe use a real rule-based engine.
Third, I'd love to receive any feedback and/or patches. This is pretty much my first Open Source project, and I'm excited about it.

The master branch will stay up-to-date with the latest stable version. Developing features and such will move to development branches.

Thank you anyone who cares about this. =)

Description
-------

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

Current development:

* Make some progress bars or messages for the download
* Make it use actual Reddit authentication

Later development:

* Expand config documentation
* Add plugin documentation
* Add proper dependencies in dist.ini
* Add tests in dist.ini
* Switch plugins to Moose OOP
* Add command-line options (change config file, etc.)
* Make it Windows-friendly
* Make more plugins

License
-------

Copyright (C) 2013-2014 Artemiy Solopov

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see http://www.gnu.org/licenses/.
