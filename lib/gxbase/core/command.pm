package gxbase::core::command;

use warnings;
use strict;
use v5.18;


sub new {
    my $class = shift;
    my $self = bless {}, $class;
		print "[command]";
    return $self;
}

1;