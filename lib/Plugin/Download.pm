package Plugin::Download;

use strict;
use warnings;
use base qw(Plugin::Base);

=pod

=head1 Plugin::Download

A plugin that downloads the URLs.

=cut

use LWP::Simple;
use Try::Tiny;
use File::Basename;

sub is_processable
{
    my $this = shift;
    my $url = shift;
    return $url =~ qr{^https?://.*\.(jpg|jpeg|gif|png|tiff)};
}

sub process
{
    my $this = shift;
    my $url = shift;
    my $target = shift;
    my $filename = fileparse $url;
    my $path = "$target/$filename";
    try
    {
        getstore($url, $path);
    }
    catch
    {
        print STDERR "$filename can't be saved.\n$_\n";
        unlink $path;
        return;
    };
    return $path;
}

1;
