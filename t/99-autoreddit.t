use Test::More;

BEGIN
{
    use_ok('autoreddit', 'Loading OK');
}

my $autoreddit = autoreddit->new([qw(Download Log)]);
ok($autoreddit, "Core module created successfully");

done_testing();
