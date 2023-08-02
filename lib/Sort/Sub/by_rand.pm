package Sort::Sub::by_rand;

use 5.010;
use strict;
use warnings;

# AUTHORITY
# DATE
# DIST
# VERSION

sub meta {
    return {
        v => 1,
        summary => "Sort randomly using Perl's rand()",
    };
}

sub gen_sorter {
    my ($is_reverse, $is_ci) = @_;

    sub { int(3*rand())-1 };
}

1;
# ABSTRACT:

=for Pod::Coverage ^(gen_sorter|meta)$

=head1 DESCRIPTION

This is equivalent to:

 sub { int(3*rand())-1 }

The case sensitivity (C<i>) and reverse (C<r>) flags are not relevant.
