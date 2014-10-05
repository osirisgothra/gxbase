#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: goo.pl
#
#        USAGE: ./goo.pl  
#
#  DESCRIPTION: Google lookup
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Gabriel Sharp <osirisgothra@hotmail.com>
# ORGANIZATION: ---
#      VERSION: 1.0
#      CREATED: 09/19/2014 07:30:29 AM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use utf8;

use v5.14;
use Getopt::Long;
use Test::File;

my @browsers = qw ! links2 links lynx firefox chromium google-chrome konqueror rekonq !;
our $browser = "";

foreach (@browsers)
{
	$browser = `which $_`;
	last 
		if $? == 0;	
}
die("Could not locate any browser to use!")
	if $? != 0;



if ($#ARGV < 0)
{
	say "Need some arguments!"
}
else
{
	#/usr/local/bin/fcheck 
	say "Found browser: $browser";
	#Getopt::Long->init()
	print "arguments: @ARGV\n";


}










