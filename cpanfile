requires 'LWP::UserAgent', '6.0';
requires 'LWP::UserAgent::ProgressBar', '1.0';
requires 'JSON', '2.90';
requires 'YAML', '0.90';
requires 'Try::Tiny', '0.16';
requires 'Module::Load', '0.24';
requires 'File::Basename', '2.80';
requires 'File::Spec::Functions', '3.40';
requires 'Data::Dumper', '2.150'; 

on 'test' => sub {
    requires 'Test::More', '1.0';
    requires 'HTTP::Server::Brick';
};

on 'develop' => sub {
    requires 'Dist::Zilla', '5.015';
    requires 'Dist::Zilla::Plugin::Prereqs::FromCPANfile', '0.05';
};
