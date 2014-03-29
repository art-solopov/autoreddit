package Plugin::Log;

use strict;
use warnings;
use base qw(Plugin::Base);

=pod

=head1 Plugin::Log

A plugin that just logs the link instead of 
downloading it

=head2 MODULE VARIABLES

$filehandles - ref to the hash of currently open filehandles
(target => filehandle)

=cut

use File::Spec::Functions;

our $filehandles = {};

sub is_processable
{
    my $this = shift;
    my $url = shift;
    return 1;
}

sub process
{
    my $this = shift;
    my $url = shift;
    my $target = shift;
    unless ($filehandles->{ $target })
    {
        open my $f, '>>', catfile($target, "__not_saved.log");
        $filehandles->{ $target } = $f;
    }
    my $fh = $filehandles->{ $target };
    print $fh "$url\n";
    return;
}

sub finalize
{
    my $this = shift;
    for (values %$filehandles)
    {
        close $_;
    }
    return 1;
}

1;
