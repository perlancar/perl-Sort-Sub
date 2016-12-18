package Sort::Sub::last_num_in_text;

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

        my @nums;
        my $num_a; @nums = $a =~ /(\d+)/g; $num_a = $nums[-1] if @nums;
        my $num_b; @nums = $b =~ /(\d+)/g; $num_b = $nums[-1] if @nums;

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
# ABSTRACT: Sort by last number found in text or (if no number is found) ascibetically

=for Pod::Coverage ^(gen_sorter)$

=head1 DESCRIPTION

The generated sort routine will sort by last number (sequence of [0-9]) found in
text or (f no number is found in text) ascibetically. Items that have a number
will sort before items that do not.

This is nifty for something like (L<sortsub> is CLI front-end for L<Sort::Sub>):

 % ls
 christophe willem - cafeine (2009)/
 christophe willem - inventaire (2007)/
 christophe willem - parait-il (2014)/
 christophe willem - prismophonic (2011)/

 % ls | sortsub last_num_in_text
 christophe willem - inventaire (2007)/
 christophe willem - cafeine (2009)/
 christophe willem - prismophonic (2011)/
 christophe willem - parait-il (2014)/


=head1 ENVIRONMENT
