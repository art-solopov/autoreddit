=pod

=head1 Plugin::Log

A plugin that just logs the link instead of 
downloading it

=cut

package Plugin::Log;

=pod

=head2 methods

=head3 new

The constructor. Accepts the log filename

=cut

sub new($$)
{
    my $cls = shift;
    my $logfile = shift;
    my $this = {logfile => $logfile};
    return bless $this, $cls;
}

=pod

=head3 is_processable

Whether URL is processable by this plugin

This plugin's version always returns true

=cut

sub is_processable($$)
{
    my $this = shift;
    my $url = shift;
    return 1;
}

=pod

=head3 process

Processes the URL

=cut

sub process($$)
{
    my $this = shift;
    my $url = shift;
    open my $fh, '>>', $this->{ logfile };
    print $fh "$url\n";
    close $fh;
    return;
}

1;