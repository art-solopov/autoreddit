package Plugin::Base;

use strict;
use warnings;

=pod

=head1 NAME

Plugin::Base - a base module for Autoreddit plugins.

This documentation will cover not only this module,
but the principles of building plugins as a whole.

=head1 SYNOPSIS

    if('Plugin::Name'->is_processable($url))
    {
        'Plugin::Name'->process($url, $params);
    }
    ...
    'Plugin::Name'->destroy();
    
=head1 METHODS

=cut

=pod

=head2 is_processable

    'Plugin::Name'->is_processable($url);

Should return true if URL $url is processable

=cut

sub is_processable
{
    my $this = shift;
    my $url = shift;
    return;
}

=pod

=head2 process

    'Plugin::Name'->process($url, $target);

Process URL $url to target $target.

=cut

sub process
{
    my $this = shift;
    my $url = shift;
    my $target = shift;
    return;
}

=pod

=head2 finalize

    'Plugin::Name'->finalize();
    
Finalize the plugin (e.g. close the filehandles, databases, sockets,
etc).

=cut

sub finalize
{
    my $this = shift;
    return 1;
}

1;
