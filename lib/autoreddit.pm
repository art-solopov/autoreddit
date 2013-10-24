package autoreddit;

=pod

=head1 NAME

autoreddit - the core module of the program.

Contains the core functions.

=head1 SYNOPSIS

    my $autoreddit = autoreddit->new($plugins);
    $autoreddit->get_saved($url);
    $autoreddit->process($url);

=head1 METHODS

=cut

use strict;
use warnings;
use LWP::UserAgent;
use JSON;
use Try::Tiny;
use Module::Load;

# ABSTRACT: Automatical Reddit download program

=pod

=head2 new

    my $autoreddit = autoreddit->new($plugins)
    
Constructor.

$plugins - array ref of plugin names

=cut

sub new
{
    my $class = shift;
    my $plugins = shift;
    
    my $this = {};
    $this->{ plugins } = $plugins;
    for(@$plugins){load "Plugin::$_"};
    return bless($this, $class);
}

=pod

=head2 get_saved

    $autoreddit->get_saved($url)

Downloads the list of saved links from Reddit saved JSON URL $url and parses said JSON.

Returns the parsed JSON.

=cut

sub get_saved
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

=head2 process

    $autoreddit->process($url);

Processes the url $url

=cut

sub process
{
	my $this = shift;
	my $url = shift;
	
    for my $plugin ($this->{ plugins })
    {
        try
        {
            if("Plugin::$plugin"->is_processable($url))
            {
                #"Plugin::$plugin"->process($url);
                print "Plugin::$plugin processes $url\n";
            }
        }
        catch
        {
            print STDERR "Error in plugin $plugin processing URL $url\n$_\n";
        }
    }
    
	return;
}

1;
