package Sort::Sub::naturally;

# DATE
# VERSION

use 5.010;
use strict;
use warnings;

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
# ABSTRACT: Sort naturally

=for Pod::Coverage ^(gen_sorter)$

=head1 NOTES

Uses L<Sort::Naturally>'s C<ncmp> as the backend. Always sorts
case-insensitively.


=head1 append:SEE ALSO

L<Sort::Naturally>
