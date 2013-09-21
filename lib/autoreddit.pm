use strict;
use warnings;
package autoreddit;

use LWP::UserAgent;

# ABSTRACT: Automatical Reddit download program

sub get_saved_links
{
    my $this = shift;
    my $config = shift;
    my $ua = LWP::UserAgent->new;
    my $req = HTTP::Request->new(GET => 'http://www.reddit.com/user/art-solopov/saved.json?feed=fc9e33063215a3df8e09c2a06c5a46f4f3e0f1c6&user=art-solopov');
    my $res = $ua->request($req);
    if ($res->is_success)
    {
        print $res->content;
    }
    else
    {
        print $res->status_line, "\n";
    };
}

1;
