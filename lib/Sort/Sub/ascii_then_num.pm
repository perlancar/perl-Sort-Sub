package Sort::Sub::ascii_then_num;

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
        no strict 'refs';

        my $caller = caller();
        my $a = ${"$caller\::a"};
        my $b = ${"$caller\::b"};

        my $cmp = 0;
        if ($a =~ $re_is_num) {
            if ($b =~ $re_is_num) {
                $cmp = $a <=> $b;
            } else {
                $cmp = 1;
            }
        } else {
            if ($b =~ $re_is_num) {
                $cmp = -1;
            } else {
                $cmp = $is_ci ?
                    lc($a) cmp lc($b) : $a cmp $b;
            }
        }
        $is_reverse ? -1*$cmp : $cmp;
    };
}

1;
# ABSTRACT: Sort non-numbers (sorted asciibetically) before numbers (sorted numerically)

=for Pod::Coverage ^(gen_sorter)$

=head1 SEE ALSO
