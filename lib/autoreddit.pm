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

=head2 get_saved_links($url)

Downloads the list of saved links from Reddit URL $url and parses its JSON.

Returns the hash from parsed JSON.

=cut

sub get_saved_links
{
    my $this = shift;
    my $url = shift;
    my $ua = LWP::UserAgent->new;
    my $req = HTTP::Request->new(GET => $url);
    my $res = $ua->request($req);
    if ($res->is_success)
    {
        my $reddit_children = decode_json($res->content);
        return $reddit_children;
    }
    else
    {
        print STDERR $res->status_line, "\n";
    };
}

=pod

=head2 process_saved_links($plugins)

Processes hash of saved links (retrieved by get_saved_links method) with the
plugins $plugins.

$plugins - array reference of plugin names.

=cut

sub process_saved_links
{
	my $this = shift;
	my $plugins = shift;
	# TODO realise
	return;
}

1;
