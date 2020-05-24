package Sort::Sub::by_perl_code;

# AUTHORITY
# DATE
# DIST
# VERSION

use 5.010;
use strict;
use warnings;
use Log::ger;

sub meta {
    return {
        v => 1,
        summary => 'Sort by Perl code',
        args => {
            code => {
                summary => 'Either compiled code or string code excluding the "sub {" and "}" enclosure',
                description => <<'_',

Code should accept two arguments (the operands to be compared) and is expected
to return -1, 0, -1 like the builtin `cmp` operator.

_
                schema => 'str*',
                req => 1,
            },
        },
    };
}
sub gen_sorter {
    my ($is_reverse, $is_ci, $args) = @_;

    my $code = $args->{code};
    die "Please supply sorter argument 'code'"
        unless defined $code;

    if (ref $code ne 'CODE') {
        $code = "no strict; no warnings; sub { $code }";
        log_trace "Compiling sort code: $code";
        $code = eval $code;
        die "Can't compile $code: $@" if $@;
    }

    sub {
        no strict 'refs';

        my $caller = caller();
        my $a = @_ ? $_[0] : ${"$caller\::a"};
        my $b = @_ ? $_[1] : ${"$caller\::b"};

        my $cmp = $code->($a, $b);
        $is_reverse ? -1*$cmp : $cmp;
    };
}

1;
# ABSTRACT:

=for Pod::Coverage ^(gen_sorter|meta)$

=head1 DESCRIPTION

This:

 use Sort::Sub '$by_perl_code', {code=>'length $_[0] <=> length $_[1]'};
 my @sorted = sort $by_perl_code @data;

is equivalent to:

 my @sorted = sort { length $a <=> length $b } @data;

Case-sensitivity flag C<i> is not relevant.
