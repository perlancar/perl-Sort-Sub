package Sort::Sub::num_then_ascii;

# DATE
# VERSION

use 5.010;
use strict;
use warnings;

sub gen_sorter {
    my ($is_reverse, $is_ci) = @_;

    my $re_is_num = qr/\A
                       [+-]?
                       (?:\d+|\d*(?:\.\d*)?)
                       (?:[Ee][+-]?\d+)?
                       \z/x;

    sub {
        my $cmp = 0;
        if ($main::a =~ $re_is_num) {
            if ($main::b =~ $re_is_num) {
                $cmp = $main::a <=> $main::b;
            } else {
                $cmp = -1;
            }
        } else {
            if ($main::b =~ $re_is_num) {
                $cmp = 1;
            } else {
                $cmp = $is_ci ?
                    lc($main::a) cmp lc($main::b) : $main::a cmp $main::b;
            }
        }
        $is_reverse ? -1*$cmp : $cmp;
    };
}

1;
# ABSTRACT: Sort numbers (sorted numerically) before non-numbers (sorted asciibetically)

=for Pod::Coverage ^(gen_sorter)$

=head1 SEE ALSO
