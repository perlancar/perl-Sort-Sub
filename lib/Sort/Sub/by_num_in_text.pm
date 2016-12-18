package Sort::Sub::by_num_in_text;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

sub gen_sorter {
    my ($is_reverse, $is_ci) = @_;

    sub {
        no strict 'refs';

        my $caller = caller();
        my $a = @_ ? $_[0] : ${"$caller\::a"};
        my $b = @_ ? $_[1] : ${"$caller\::b"};

        my $cmp;

        my $num_a; $num_a = $1 if $a =~ /(\d+)/;
        my $num_b; $num_b = $1 if $b =~ /(\d+)/;

        {
            if (defined $num_a && defined $num_b) {
                $cmp = $num_a <=> $num_b;
                last if $cmp;
            } elsif (defined $num_a && !defined $num_b) {
                $cmp = -1;
                last;
            } elsif (!defined $num_a && defined $num_b) {
                $cmp = 1;
                last;
            }

            if ($is_ci) {
                $cmp = lc($a) cmp lc($b);
            } else {
                $cmp = $a cmp $b;
            }
        }

        $is_reverse ? -1*$cmp : $cmp;
    };
}

1;
# ABSTRACT: Sort by first number found in text or (if no number is found) ascibetically

=for Pod::Coverage ^(gen_sorter)$

=head1 DESCRIPTION

The generated sort routine will sort by first number (sequence of [0-9]) found
in text or (f no number is found in text) ascibetically. Items that have a
number will sort before items that do not.


=head1 append:SEE ALSO

L<Sort::Sub::by_last_num_in_text>
