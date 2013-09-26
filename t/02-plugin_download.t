use Test::More;
use File::Basename;

BEGIN 
{
    use_ok( 'Plugin::Download', 'Loading OK');
}

my @pic_urls = qw( http://cdn.awwni.me/mbum.gif
                   http://cdn.awwni.me/mblv.jpg
                   http://i.imgur.com/03Nt8La.jpg
                   http://cdn.awwni.me/mbuy.png
                 );

my @non_pic_urls = qw( http://youtu.be/SRGJOaWNcys
                       http://neko-rina.deviantart.com/art/AT-Shurei90-396045366
                     );

my $plugin = 'Plugin::Download';
my $testdir = 'test';
mkdir $testdir;

for(@non_pic_urls)
{
    ok(not($plugin->is_processable($_)), "$_ isn't processable - OK");
}

for(@pic_urls)
{
    ok($plugin->is_processable($_), "$_ is processable - OK");
}

for(@pic_urls)
{
    $plugin->process($_, $testdir);
    my ($name) = "$testdir/" . fileparse($_);
    ok(-e $name, '$name exists');
    unlink($name);
}

rmdir $testdir;
done_testing();
