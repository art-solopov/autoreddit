use strict;
use warnings;

package Plugin::Base;

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
    return undef;
}

=pod

=head2 process

    'Plugin::Name'->process($url, @params);

Should process URL $url with respect to @params.

Params should include:

=over 8

=item subreddit - a subreddit 

=back

=cut