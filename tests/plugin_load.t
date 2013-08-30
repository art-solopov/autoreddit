use Test::More;
use lib '..';

BEGIN 
{
    use_ok( 'Plugin::Log', 'Loading OK');
}

my @urls = qw(http://cdn.awwni.me/mblv.jpg
              http://youtu.be/SRGJOaWNcys
              http://neko-rina.deviantart.com/art/AT-Shurei90-396045366
             );

my $plugin = Plugin::Log->new('test.log');
for(@urls)
{
    ok($plugin->is_processable($_), "$_ processable");
    $plugin->process($_);
}

open my $fh, '<', 'test.log';
my @testlog = <$fh>;
is(scalar @testlog, scalar @urls, "Exact number of URLs");
while( my ($i, $line) = each(@testlog))
{
    chomp($line);
    is($line, $urls[$i], "URL $urls[$i] processed correctly");
}

unlink 'test.log';

done_testing();