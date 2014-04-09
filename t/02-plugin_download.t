use Test::More;
use File::Basename;
use HTTP::Server::Brick;

BEGIN 
{
    use_ok( 'Plugin::Download', 'Loading OK');
}

my @pic_urls = qw( /one.gif
                   /one.jpg
                   /one.png
                   /one.jpeg
                   /one.tiff
                 );

my @non_pic_urls = qw( /no.txt
                       /no
                     );

my $path = './t/srv';
my $server = HTTP::Server::Brick->new(port => 32000);
$server->mount( '/' => {
        path => $path
    });
my $pid = fork;
unless ($pid) {
    $server->start();
    exit 0;
};

my $plugin = 'Plugin::Download';
my $testdir = 'test';
mkdir $testdir;

for(@non_pic_urls)
{
    ok(not($plugin->is_processable("http://localhost:32000/$_")), "$_ isn't processable - OK");
}

for(@pic_urls)
{
    ok($plugin->is_processable("http://localhost:32000/$_"), "$_ is processable - OK");
}

for(@pic_urls)
{
    $plugin->process("http://localhost:32000/$_", $testdir);
    my ($name) = "$testdir/" . fileparse($_);
    ok(-e $name, '$name exists');
    unlink($name);
}

kill 'HUP', $pid;

rmdir $testdir;
done_testing();
