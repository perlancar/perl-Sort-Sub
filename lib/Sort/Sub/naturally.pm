package Sort::Sub::naturally;

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
        summary => 'Sort naturally (by number or string parts)',
    };
}

sub gen_sorter {
    require Sort::Naturally;

    my ($is_reverse, $is_ci) = @_;

    sub {
        no strict 'refs';

        my $caller = caller();
        my $a = @_ ? $_[0] : ${"$caller\::a"};
        my $b = @_ ? $_[1] : ${"$caller\::b"};

        if ($is_reverse) {
            Sort::Naturally::ncmp($b, $a);
        } else {
            Sort::Naturally::ncmp($a, $b);
        }
    };
}

1;
# ABSTRACT:

=for Pod::Coverage ^(gen_sorter|meta)$

=head1 NOTES

Uses L<Sort::Naturally>'s C<ncmp> as the backend. Always sorts
case-insensitively.


=head1 append:SEE ALSO

L<Sort::Naturally>
