package Plugin::Log;

use strict;
use warnings;
use base qw(Plugin::Base);

=pod

=head1 Plugin::Log

A plugin that just logs the link instead of 
downloading it

=head2 MODULE VARIABLES

$_filehandles - ref to the hash of currently open filehandles
(target => filehandle)

=cut

our $_filehandles = {};

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
    unless ($_filehandles->{ $target })
    {
		open my $f, '>>', "$target/__not_saved.log";
		$_filehandles->{ $target } = $f;
	}
    my $fh = $_filehandles->{ $target };
    print $fh "$url\n";
    return;
}

sub finalize
{
	my $this = shift;
	for (values %$_filehandles)
	{
		close $_;
	}
	return 1;
}

1;
