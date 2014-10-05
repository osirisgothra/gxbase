#!/usr/bin/perl

#|[   Details
#   -----------------------------------------------------------------------
#    Summary:   /g/b/upnet.pl 
#     Author:   gabriel [osirisgothra@hotmail.com]     
#    Purpose:   Main Code for gabriel's /
 
#    Created:	Fri 05 Sep 2014 05:18:18 PM EDT#
#     Update:   http://paradisim.twilightparadox.com
#   -----------------------------------------------------------------------
#|] 

#|[ Includes   

use 5.014                  ;
use feature "switch"               ;
use Test::File             ;
use warnings              ;
use strict                ;
use Pod::Usage            ; # pod2usage()
use Getopt::Long          ; # Getoptions()
use File::Spec            ; # catfile
#|]
#|[ Global Variables    

#|]
#|[ Functions
#|]

#|[ Entry Point
{
    open SERVERLIST, "<", "upnetrc"
        or die("Cannot open configuration file (serverlist:upnetrc) $? $_");
    chomp (my @servlist = <SERVERLIST>)
        or die("Error reading configuration file: $_ $?");

        
}
#|]

#|[ Modeline:  vim:et:fen:fdm=marker:fcl=all:fmr=\#\|[,\#\|]:tw=160:sw=4:ts=4:sts=0:vbs=0:cc=80:fdc=3:mls=4:fml=0:foldexpr=|]
# 0 
