use Test::More;

BEGIN 
{
    use_ok( 'Plugin::Log', 'Loading OK');
}

my @urls = qw(http://cdn.awwni.me/mblv.jpg
              http://youtu.be/SRGJOaWNcys
              http://neko-rina.deviantart.com/art/AT-Shurei90-396045366
             );

my $plugin = 'Plugin::Log';
my $testdir = 'test';
mkdir $testdir;
for(@urls)
{
    ok($plugin->is_processable($_), "$_ processable");
    $plugin->process($_, $testdir);
}
$plugin->finalize();

open my $fh, '<', "$testdir/__not_saved.log";
my @testlog = <$fh>;
is(scalar @testlog, scalar @urls, "Exact number of URLs");
while( my ($i, $line) = each(@testlog))
{
    chomp($line);
    is($line, $urls[$i], "URL $urls[$i] processed correctly");
}

unlink "$testdir/__not_saved.log";
rmdir $testdir;
done_testing();
