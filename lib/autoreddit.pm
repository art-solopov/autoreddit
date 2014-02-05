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
use v5.10;
use LWP::UserAgent;
use JSON;
use Try::Tiny;
use Module::Load;
use File::Spec::Functions;
use autouse 'Data::Dumper' => 'Dumper';

# ABSTRACT: Automatical Reddit download program

=pod

=head2 new

    my $autoreddit = autoreddit->new($plugins, $groups, $dir)
    
Constructor.

$plugins - array ref of plugin names

$groups - hash ref of groups, organized like this:

    {
        group1 => ['subreddit1', 'subreddit2', ...],
        group2 => ['subreddit3', ...],
        ...,
        rootgroup => ['subredditX', ...]
    }

We assume that there is no subreddit belongs in more than one group.

$dir - download directory

Rootgroup is the group of subreddits which submissions will go into the
download directory itself.

=cut

sub new
{
    my $class = shift;
    my $plugins = shift;
    my $groups = shift;
    my $dir = shift;
    
    my $this = {};

    # Processing groups
    while ( my ($gr_name, $subs) = each %$groups)
    {
	for my $sub (@$subs)
	{
	    $this->{ groups }->{ $sub } = $gr_name;
	}
    }


    $this->{ plugins } = $plugins;
    $this->{ dir } = $dir;
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
        return;
    };
}

=pod

=head2 process

    $autoreddit->process($url, $subreddit);

Processes the url $url from subreddit $subreddit

=cut

sub process
{
    my $this = shift;
    my $url = shift;
    my $subreddit = shift;
    my $target = $this->_get_target($subreddit);
    $target = '.' if $target eq 'rootgroup';
    $target = catfile($this->{ dir }, $target);
    mkdir $target unless -e $target;
	
    for my $plugin (@{$this->{ plugins } })
    {
        # This var is needed to determine the end of the cycle.
        # If I just put last into this, the warning is risen.
        my $prc = undef;
        try
        {
            if("Plugin::$plugin"->is_processable($url))
            {
                "Plugin::$plugin"->process($url, $target);
                $prc = 1;
            }
        }
        catch
        {
            print STDERR "Error in plugin $plugin processing URL $url\n$_\n";
        };
        return 1 if $prc;
    }
    
	return;
}

=pod

=head2 _get_target

    $this->_get_target($subreddit)
    
Get the group associated with the subreddit.

TODO: use Memoize to increase performance

=cut

sub _get_target
{
    my $this = shift;
    my $subreddit = shift;
    
    #for my $group (keys $this->{ groups })
    #{
    #    return $group if($subreddit ~~ $this->{ groups }->{ $group });
    #}
    
    return $this->{ groups }->{ $subreddit } || $subreddit;
}

1;
