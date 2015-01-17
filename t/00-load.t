#!perl -T
use 5.18;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 3;

BEGIN {
    use_ok( 'gxbase' ) || print "Bail out!\n";
    use_ok( 'gxbase::core' ) || print "Bail out!\n";
    use_ok( 'gxbase::helpers' ) || print "Bail out!\n";
}

diag( "Testing gxbase $gxbase::VERSION, Perl $], $^X" );
