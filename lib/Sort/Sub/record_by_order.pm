package Sort::Sub::record_by_order;

# AUTHORITY
# DATE
# DIST
# VERSION

use 5.010001;
use strict;
use warnings;

sub meta {
    return {
        v => 1,
        compares_record => 1,
    };
}

sub gen_sorter {
    require Sort::BySpec;

    my ($is_reverse, $is_ci) = @_;

    sub {
        no strict 'refs';

        my $caller = caller();
        my $a = @_ ? $_[0] : ${"$caller\::a"};
        my $b = @_ ? $_[1] : ${"$caller\::b"};

        my $cmp = $a->[1] <=> $b->[1];
        $is_reverse ? -1*$cmp : $cmp;
    };
}

1;
# ABSTRACT:

=for Pod::Coverage ^(gen_sorter|meta)$

=head1 DESCRIPTION

Sort by the order of records. This sorter expects C<$a> and C<$b> to be records
of:

 [$data, $order]

instead of just:

 $data

It then performs:

 $a->[1] <=> $b->[1]


=head1 SEE ALSO

L<Sort::Sub::record_by_reverse_order>
