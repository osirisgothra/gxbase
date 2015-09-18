#!/usr/bin/env perl
#===============================================================================
#
#         FILE: group2subdir.pl
#
#        USAGE: ./group2subdir.pl  
#
#  DESCRIPTION:	stub for starting group2subdir.pl 
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 08/06/2015 11:42:37 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use utf8;

use Path::Class::Dir;
use v5.18;
use Cwd;
use Carp;

my $axbase = $ENV{AX_BASE} // "/usr/local/share/ax";
my $shim = "$axbase/lib/group2subdir_shim.py";

if ( -r $shim ) 
{
	$0 = "group2subdir";
	unshift @ARGV,$shim;
	say("STAT=>executing PID=>$$ ARGV=>@ARGV");
	exec(@ARGV) or Carp::carp("STAT=>failed to exec PID=>$$ ERRMSG=>$! POSIX_RETC=>$?");

}



