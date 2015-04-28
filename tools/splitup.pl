#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: splitup.pl
#
#        USAGE: ./splitup.pl  
#
#  DESCRIPTION: split up utiltiy program to split a large number of files into a 
#               numerical set of subdirectories, see OPTIONS below on what to set.
#
#      OPTIONS: $debugging=(0|1) $files_per_dir=(num) are the only interesting options
# REQUIREMENTS: POSIX, utf8, Cwd, CORE
#     BUGS-KEY: Kind markers: (number = priority)( ! = important  . = ho-hum  ? = possible but not really )
#         BUGS: (1!) also moves this script, if it's being run from the same dir!!
#				(2?) NOT portable, strictly linux (untested, not actually verified a bug)
#        NOTES: Place this file in a directory where you wish to split up files into 
#               directories, see settings below for tweaks, use $debugging to test out
#               your settings non-destructively!
#       AUTHOR: Gabriel Thomas Sharp (GTS), osirisgothra@hotmail.com
# ORGANIZATION: Paradisim, LLC
#      VERSION: 1.0
#      CREATED: 04/11/2015 10:35:45 PM
#     REVISION: N/A										LICENSE: Public Domain
#===============================================================================

use strict;
use warnings;
use utf8;
use Cwd;
use v5.18;
use POSIX;

my @files = `ls -C -1`;
chomp @files;

my $debugging = 0;				# set to 0 for "the real thing" or anything else for a "dry run"
my $files_per_dir = 70;
my $basedir = getcwd();
my $curnum = 0;
my $cursubidx = 0;
my $target = $basedir . '/' . "$curnum";
my $curidx = 0;
my $count = @files;
my $dirs_to_generate = ceil($count / $files_per_dir);
my $firstrun = 0;

sub ssystem(@)
{	
	unless ($firstrun)
	{
		say "Debugging Enabled ($debugging)=\$debugging: this means you will get DRY RUN MESSAGES, but no output! To disable it you must edit the script and set:\n\n\t my \$debugging = 0\n\nThe program will not work until you do this! [hit ENTER]" if $debugging;
		my $useless = <STDIN> if $debugging;
		$firstrun = 1;
	}
	system("/bin/echo","DEBUG-DRY-RUN:",@_) if $debugging;
	system(@_) unless $debugging;
}


if ( $count < 1 )
{
	say "Cannot perform any work, no files to work with!";
}
else
{
	say "Starting work, with $count file(s)...";
	say "Will be creating $dirs_to_generate directory sublocation(s)...";
	
	while ( $curidx < $count )
	{
		# perform operation:
		#   * 2 system calls
		#      * /bin/mv (move file)	* /bin/mkdir (make directory)
		#   * 3 error checking points
		#      * target directory must be created and exists
		#      * file to be moved must not still exist in original location (removal failed and...?)
		#      * file to be moved did not reach it's targeted destination (copy failed and...?)
		
		ssystem("mkdir","$target") unless -d $target;
		die "directory $target still does not exist, even after attempt to create it! $! $?" unless -d $target or $debugging;			
		ssystem("mv","$files[$curidx]","$target");	
		die "file $files[$curidx] still exists after moving it (not supposed to be there)! $! $?" if -f $files[$curidx] and not $debugging;
		die "file $files[$curidx] not in $target after move operation (thats bad, disappeared?) $! $?" unless -f $target . '/' . $files[$curidx] or $debugging;

		# prepare for next cycle:
		# 	* 2 index increments
		# 	* 1 check for target change, depending on...
		# 	 		* number of files per directory (cursubidx)
		# 	        * then reset subidx counter to zero and make new target
		# 	* loop end reached, start of loop will check if we need to continue:
		# 			* when curidx meets or exceeds # of files targeted, will quit

		$curidx += 1;
		$cursubidx += 1;
		if ($cursubidx > $files_per_dir)
		{
			$curnum += 1;
			$cursubidx = 0;
			$target = $basedir . '/' . "$curnum";

		}
	}
	say "done (processed $curidx items)";
	say "Condition = Excellent: if you are reading this message, that means nothing (really) bad happened!";
}


