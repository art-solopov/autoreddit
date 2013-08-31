use strict;
use warnings;
package Plugin::Download;

use LWP::Simple;
use Try::Tiny;
use File::Basename;

sub new($$)
{
    my $cls = shift;
    my $this = {};
    return bless $this, $cls;
}

sub is_processable($$)
{
    my $this = shift;
    my $url = shift;
    return $url =~ qr{^https?://.*\.(jpg|jpeg|gif|png|tiff)};
}

sub process($$)
{
    my $this = shift;
    my $url = shift;
    my $filename = fileparse $url;
    try
    {
        getstore($url, $filename);
    }
    catch
    {
        print "$filename can't be saved.\n";
        unlink $filename;
    };
    return;
}

1;
