package Sort::Sub::by_perl_op;

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
        summary => 'Sort by Perl operator',
        args => {
            op => {
                schema => ['str*', in=>['cmp', '<=>']],
                req => 1,
            },
        },
    };
}
sub gen_sorter {
    my ($is_reverse, $is_ci, $args) = @_;

    my $op = $args->{op};
    die "Please supply sorter argument 'op'"
        unless defined $op;

    my $code_str = "sub { \$_[0] $op \$_[1] }";
    my $code_cmp = eval $code_str;
    die "Can't compile $code_str: $@" if $@;

    sub {
        no strict 'refs';

        my $caller = caller();
        my $a = @_ ? $_[0] : ${"$caller\::a"};
        my $b = @_ ? $_[1] : ${"$caller\::b"};

        my $cmp = $code_cmp->($a, $b);
        $is_reverse ? -1*$cmp : $cmp;
    };
}

1;
# ABSTRACT:

=for Pod::Coverage ^(gen_sorter|meta)$

=head1 DESCRIPTION

This:

 use Sort::Sub '$by_perl_op', {op=>'<=>'};
 my @sorted = sort $by_perl_op @data;

is equivalent to:

 my @sorted = sort { $a <=> $b } @data;

Case-sensitivity flag C<i> is not relevant.
