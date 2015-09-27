package Sort::Sub::naturally;

# DATE
# VERSION

use 5.010;
use strict;
use warnings;

sub gen_sorter {
    my ($is_reverse, $is_ci) = @_;

    my $re = qr/([+-]?\d+|\D+)/;

    package main;
    sub {
        my @a_parts = +($is_ci ? lc($a) : $a) =~ /$re/g;
        my @b_parts = +($is_ci ? lc($b) : $b) =~ /$re/g;

        #use DD; dd \@a_parts;

        my $i = 0;
        my $cmp = 0;
        for (@a_parts) {
            last if $i >= @b_parts;
            #say "D:$a_parts[$i] <=> $b_parts[$i]";
            if ($a_parts[$i] =~ /\d/ || $b_parts[$i] =~ /\d/) {
                $cmp = $a_parts[$i] <=> $b_parts[$i];
            } else {
                $cmp = $a_parts[$i] cmp $b_parts[$i];
            }
            last if $cmp;
            $i++;
        }
        $is_reverse ? -1*$cmp : $cmp;
    };
}

1;
# ABSTRACT: Sort naturally

=head1 SEE ALSO

L<Sort::Naturally>
