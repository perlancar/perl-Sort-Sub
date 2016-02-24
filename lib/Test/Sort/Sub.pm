package Test::Sort::Sub;

use 5.010;
use strict 'subs', 'vars';
use warnings;

use Exporter 'import';
use Sort::Sub ();
use Test::More 0.98;

our @EXPORT = qw(sort_sub_ok);

sub sort_sub_ok {
    my %args = @_;

    my $subname = $args{subname};
    subtest "sort_sub_ok $subname" => sub {
        Sort::Sub->import("$subname");
        is_deeply([sort {&{$subname}}
                       @{ $args{input} }], $args{output},
                  'result');
        Sort::Sub->import("$subname<i>");
        is_deeply([sort {&{$subname}}
                       @{ $args{input} }], $args{output_i},
                  'result i');
        Sort::Sub->import("$subname<ir>");
        is_deeply([sort {&{$subname}}
                       @{ $args{input} }], $args{output_ir},
                  'result ir');
    };
}

1;
# ABSTRACT: Test Sort::Sub::* subroutine
