#!/usr/bin/perl

use warnings;
use strict;

$,="\n";
$|=1;

system('pgrep dwm-datemon &> /dev/null') ;
if ( $? == 0 )
{
	print "Daemon already running, killing it now...\n";
	system ('killall -KILL dwm-datemon');
	print "To start again, re-run dwm-datemon\n";
	exit 0
}
else
{
	my $pid = $$;
	fork();
	if ( $pid != $$ ) {
		while (1) {
			sleep 1;
			system('/usr/bin/xsetroot','-name',`date`);
		}
	}
	else
	{
		print "\nStarted daemon OK on pid $pid.\n";
		
		exit 0;
	}

}

