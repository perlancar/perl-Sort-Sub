package Sort::Sub::asciibetically;

# AUTHORITY
# DATE
# DIST
# VERSION

use 5.010;
use strict;
use warnings;

sub meta {
    return {
        v => 1,
        summary => 'Sort ascibetically (string-wise)',
    };
}

sub gen_sorter {
    my ($is_reverse, $is_ci) = @_;

    sub {
        no strict 'refs';

        my $caller = caller();
        my $a = @_ ? $_[0] : ${"$caller\::a"};
        my $b = @_ ? $_[1] : ${"$caller\::b"};

        my $cmp = $is_ci ? lc($a) cmp lc($b) : $a cmp $b;
        $is_reverse ? -1*$cmp : $cmp;
    };
}

1;
# ABSTRACT:

=for Pod::Coverage ^(gen_sorter|meta)$

=head1 DESCRIPTION

This is equivalent to Perl's:

 sub { $a cmp $b }
