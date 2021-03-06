use v5.18;
use strict;
use warnings FATAL => 'all';
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'gxbase',
    license             => 'GPL_3',
    dist_author         => q{Gabriel Sharp <etherial_raine@outlook.com>},
    dist_version_from   => 'lib/gxbase.pm',
    release_status      => 'stable',
    configure_requires => {
        'Module::Build' => 0,
    },
    build_requires => {
        'Test::More' => 0,
    },
    requires => {
        #'ABC'              => 1.6,
        #'Foo::Bar::Module' => 5.0401,
    },
    add_to_cleanup     => [ 'gxbase-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
