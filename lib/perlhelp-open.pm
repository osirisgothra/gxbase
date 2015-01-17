#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: perlhelp-open
#
#        USAGE: ./perlhelp-open  
#
#  DESCRIPTION: Helper for perlhelp(1) that sends page to an 'opener' program
#
#      OPTIONS: perlhelp-open [program-name] [perlhelp-command-line]
# REQUIREMENTS: perlhelp
#         BUGS: ---
#        NOTES: Formatting is not handled at this time, you may need to tweak
#               the 'opener' program to handle such documents
#       AUTHOR: Gabriel Thomas Sharp (gts), osirisgothra@hotmail.com
# ORGANIZATION: Paradisim Enterprises, LLC - http://paradisim.twilightparadox.com
#      VERSION: 1.0
#      CREATED: 01/13/2015 10:21:45 AM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use utf8;

#!/usr/bin/perl



use warnings;
use strict;
use v5.18;
use File::Temp qw ! tempfile !;
use Path::Class::Dir;

	
my $fallback_column_width = 80;
my $program = shift @ARGV;
my $width = defined($ENV{COLUMNS})? $ENV{COLUMNS} : $fallback_column_width;
my @searchpath = split(":",$ENV{PATH});	
my @lines = `/gxbase/bin/perlhelp --nopager @ARGV`;
my $found = 0;

for (@searchpath) { $found = 1 if -x $_ . '/' . $program; }

die ("Error: program $program does not seem to be executable by you.\n") unless $found;

if ($#lines > 1) {

	my $doc;
# uncomment the following comments for extra document formatting (not needed)
#	$doc = "Documentation for $ARGV[-1]\n" . ("_" x $width) . "\n\n @lines[4 .. $#lines]";
#	$doc =~ s/\S\)/)]/g;
#	$doc =~ s/ \S(?![ \(])/ [/g;
	$doc = " @lines";
	$doc =~ s/\S//g;

	if ($? == 0) {
		 my ($fh,$tempfile) = tempfile();
		 print $fh $doc;
		 close $fh;
		 system($program,$tempfile) or die "Error launching $program $! - $?";
	}
	exit 0;
}
else { die "Help for this topic is unavailable!" }
