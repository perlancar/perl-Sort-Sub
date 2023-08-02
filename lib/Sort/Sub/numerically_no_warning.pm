package Sort::Sub::numerically_no_warning;

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
        summary => 'Sort numerically (without warning when comparing non-numbers)',
    };
}

sub gen_sorter {
    my ($is_reverse, $is_ci) = @_;

    sub {
        no strict 'refs';
        no warnings 'numeric';

        my $caller = caller();
        my $a = @_ ? $_[0] : ${"$caller\::a"};
        my $b = @_ ? $_[1] : ${"$caller\::b"};

        my $cmp = $a <=> $b;
        $is_reverse ? -1*$cmp : $cmp;
    };
}

1;
# ABSTRACT:

=for Pod::Coverage ^(gen_sorter|meta)$

=head1 DESCRIPTION

This is equivalent to:

 sub { no warnings 'numeric'; $a <=> $b }


=head1 prepend:SEE ALSO

L<Sort::Sub::numerically>
