package Plugin::Download;

use strict;
use warnings;
use base qw(Plugin::Base);

=pod

=head1 Plugin::Download

A plugin that downloads the URLs.

=cut

use LWP::UserAgent::ProgressBar;
use Try::Tiny;
use File::Basename;
use File::Spec::Functions;

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
    my $ua = LWP::UserAgent::ProgressBar->new();
    my $filename = fileparse $url;
    my $path = catfile($target, $filename);
    return if(-e $path);
    try
    {
        #print "Getting $url -> $path\n";
        print "$url -> $path\n";
        my $resp = $ua->get_with_progress($url);
        die if $resp->code() >= 400;
        open my $fh, '>', $path;
        print $fh $resp->decoded_content;
        close $fh;
        #print "$st\n";
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
