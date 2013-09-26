package autoreddit;

=pod

=head1 NAME

autoreddit - the core module of the program.

Contains the core functions.

=cut

use strict;
use warnings;
use LWP::UserAgent;
use JSON;

# ABSTRACT: Automatical Reddit download program

=pod

=head1 METHODS

=head2 get_saved_links

Downloads the list of saved links and parses its JSON.

=cut

sub get_saved_links
{
    my $this = shift;
    my $config = shift;
    my $ua = LWP::UserAgent->new;
    my $req = HTTP::Request->new(GET => $config->{ saved_url });
    my $res = $ua->request($req);
    if ($res->is_success)
    {
        my $json = decode_json($res->content);
        return $json;
    }
    else
    {
        print STDERR $res->status_line, "\n";
    };
}

1;
