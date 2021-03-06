#!/usr/bin/env perl

#===============================================================================
#
#         FILE: gxbase.pm
#
#  DESCRIPTION: Instance module for gxbase
#
#        FILES: /gxbase/lib/gxbase.pm and the /gxbase namespace
#         BUGS: still in alpha
#        NOTES: see bugs
#       AUTHOR: Gabriel T. Sharp (etherial raine), osirisgothra@hotmail.com
# ORGANIZATION: Prolific Agnostic Research And Development Into Shared Information Media 
#      VERSION: 0.01
#      CREATED: 08/08/2015 07:44:56 PM
#     REVISION: 0 - devel level
#===============================================================================

use strict;
use warnings;
 
package gxbase;

our $VERSION = '0.01';

use v5.18;
use strict;
use warnings FATAL => 'all';
use lib '/gxbase/lib';
use gxbase::core;
use gxbase::core::command;
use gxbase::ui;
use Cwd;
use Path::Class::File;
use Path::Class::Dir;
use Path::Class;
use IO::File;
use File::Slurp::Tiny;
use Getopt::Long;


my $develmode = 1; # set to 1 when developing (a check for cpan testing to be zero)

my $core = 0;
my $ui = 0;
my $initialized = 0;
my $view = 0;

sub new
{
  print "creating instance...";
	die "fatal: required = classname" unless @_ > 0;
	die "fatal: calling new on already initted class gxbase" if $initialized > 0;

    my $class = shift;
    my $self = bless {}, $class;

	say "core";
	$core = gxbase::core->new() or die ("fatal: can't create core ($!)");
	say "ui";
	$ui = gxbase::ui->new() or die ("fatal: can't create ui ($!)");
	say "init refcount + $initialized";
	$initialized++;
	print "ok\n";
	
    return $self;
}

sub bootstrapper
{
	die "fatal: cannot run bootstrap without initializing!" unless $initialized == 1;	
	say "bootstrapper started - entering main loop";

	say "warning: temporary mode, undeveloped section begins here" if $develmode == 1;
	
	my $prompt = ">";
	my @input = ( );
	my $cmd = "";
	my $ret = 0;
	my $result = 0;
	
	while (1)
	{
		printf $prompt . " ";
		@input = <STDIN>;
		$cmd = shift(@input);		
		$_ = $cmd;
		if (/^exit$/)
		{
				$ret = @input ? int(shift(@input)) : 0;
				for (@input)
				{
				say $_;
				}
				return $ret;
		}
		else
		{
			# let system handle it
			$result = system('/bin/bash','--norc','-c','--',$cmd,@input);
			say $result;			
		}			
	}
}

1; # End of gxbase DO NOT REMOVE THIS LINE!!!

__END__

=head1 NAME

gxbase

=head1 VERSION

Version 0.01

=head1 SYNOPSIS

Bottom level code file for gxbase, it is used by '/gxbase' which is the calling script.


=head1 EXPORT

none

=head1 AUTHOR

Gabriel Sharp, C<< <etherial_raine at outlook.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-gxbase at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=gxbase>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc gxbase


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=gxbase>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/gxbase>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/gxbase>

=item * Search CPAN

L<http://search.cpan.org/dist/gxbase/>

=back


=head1 ACKNOWLEDGEMENTS

Me

=head1 LICENSE AND COPYRIGHT

Copyright 2015 Gabriel Sharp.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see L<http://www.gnu.org/licenses/>.


=cut


