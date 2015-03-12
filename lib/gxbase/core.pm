package gxbase::core;
use strict;


sub new {
    my $class = shift;
    my $self = bless {}, $class;
		print "[core]";
    return $self;
}

1;