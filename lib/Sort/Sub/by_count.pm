package Sort::Sub::by_count;

use 5.010001;
use strict;
use warnings;

# AUTHORITY
# DATE
# DIST
# VERSION

sub meta {
    return {
        v => 1,
        summary => 'Sort by number of occurrences of pattern in string',
    };
}

sub _pattern_to_re {
    my $args = shift;

    my $re;
    my $pattern = $args->{pattern}; defined $pattern or die "Please specify pattern";
    if ($args->{fixed_string}) {
        $re = $args->{ignore_case} ? qr/\Q$pattern/i : qr/\Q$pattern/;
    } else {
        eval { $re = $args->{ignore_case} ? qr/$pattern/i : qr/$pattern/ };
        die "Invalid pattern: $@" if $@;
    }

    $re;
}

sub gen_sorter {
    my ($is_reverse, $is_ci, $args) = @_;

    die __PACKAGE__.": Please specify 'pattern'" unless defined $args->{pattern};

    my $re = _pattern_to_re($args);

    sub {
        no strict 'refs';

        my $caller = caller();
        my $a = @_ ? $_[0] : ${"$caller\::a"};
        my $b = @_ ? $_[1] : ${"$caller\::b"};

        my $count_a = 0; $count_a++ while $a =~ /$re/g;
        my $count_b = 0; $count_b++ while $b =~ /$re/g;

        ($is_reverse ? -1 : 1)*(
            ($count_a <=> $count_b) ||
                ($is_ci ? lc($a) cmp lc($b) : $a cmp $b)
            );
    };
}

1;
# ABSTRACT:

=for Pod::Coverage ^(gen_sorter|meta)$

=head1 ARGUMENTS

=head2 pattern

Regex pattern or string.

=head2 fixed_string

Bool. If true will assume L</pattern> is a fixed string instead of regular
expression.

=head2 ignore_case

Bool.


=head1 append:SEE ALSO

L<Sort::Naturally>
