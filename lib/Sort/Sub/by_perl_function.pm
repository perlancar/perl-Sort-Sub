package Sort::Sub::by_perl_function;

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
        summary => 'Sort by Perl function',
        args => {
            function => {
                schema => 'perl::funcname*',
                req => 1,
            },
            numeric => {
                summary => "Compare using Perl's <=> instead of cmp",
                schema => 'bool*',
                default => 0,
            },
        },
    };
}
sub gen_sorter {
    my ($is_reverse, $is_ci, $args) = @_;

    my $function = $args->{function};
    die "Please supply sorter argument 'function'"
        unless defined $function;

    if ($function =~ /(.+)::(.+)/) {
        # qualified with a package name, load associated module
        my $mod = $1;
        (my $mod_pm = "$mod.pm") =~ s!::!/!g;
        require $mod_pm;
    }

    my $code_str = "sub { $function\(\$_[0]) }";
    my $code_call_func = eval $code_str;
    die "Can't compile $code_str: $@" if $@;

    sub {
        no strict 'refs';

        my $caller = caller();
        my $a = @_ ? $_[0] : ${"$caller\::a"};
        my $b = @_ ? $_[1] : ${"$caller\::b"};

        my $res_a = $code_call_func->($a);
        my $res_b = $code_call_func->($b);

        my $cmp = $args->{numeric} ? $res_a <=> $res_b :
            $is_ci ? lc($res_a) cmp lc($res_b) : $res_a cmp $res_b;
        $is_reverse ? -1*$cmp : $cmp;
    };
}

1;
# ABSTRACT:

=for Pod::Coverage ^(gen_sorter|meta)$

=head1 DESCRIPTION

This:

 use Sort::Sub '$by_perl_function', {function=>'length'};
 my @sorted = sort $by_perl_function @data;

is equivalent to:

 my @sorted = sort { length($a) <=> length($b) } @data;
