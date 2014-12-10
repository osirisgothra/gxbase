#!/usr/bin/perl
# Author:	gabriel
# Purpose:	«Pattern Test Program»
# Created:	Mon 01 Sep 2014 06:48:56 AM EDT

### Code {{{1
## Includes   {{{2
use 5.010                  ;
#use warnings              ;
#use strict                ;
#use Pod::Usage            ; # pod2usage()
#use Getopt::Long          ; # Getoptions()
#use File::Spec            ; # catfile

## Globals    {{{2
## Functions  {{{2
## Main       {{{2

die "Not enough arguments!!\n" if ($#ARGV < 0);

my $pattern = shift @ARGV;
$pattern = qr/$pattern/g;

while (<>) {
 # take one input line at a time
 chomp;
 if ( $pattern ) {

 print "$`\e[1;47;32m$&\e[0m$'\n"; # the special match vars w
 } else {
   print "$_\n";
 }

}
 



# ======================================================================
# vim600: set foldmethod=marker:
# vim:et:ts=4:tw=79:
