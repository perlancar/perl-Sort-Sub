package Test::Sort::Sub;

## no critic: Modules::ProhibitAutomaticExportation

# DATE
# VERSION

use 5.010001;
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
        my $res;

        if ($args{output}) {
            Sort::Sub->import("$subname", ($args{args} ? $args{args} : ()));
            $res = [sort {&{$subname}} @{ $args{input} }];
            is_deeply($res, $args{output}, 'result') or diag explain $res;
        }

        if ($args{output_i}) {
            Sort::Sub->import("$subname<i>", ($args{args} ? $args{args} : ()));
            $res = [sort {&{$subname}} @{ $args{input} }];
            is_deeply($res, $args{output_i}, 'result i') or diag explain $res;
        }

        if ($args{output_r}) {
            Sort::Sub->import("$subname<r>", ($args{args} ? $args{args} : ()));
            $res = [sort {&{$subname}} @{ $args{input} }];
            is_deeply($res, $args{output_r}, 'result r') or diag explain $res;
        };

        if ($args{output_ir}) {
            Sort::Sub->import("$subname<ir>", ($args{args} ? $args{args} : ()));
            $res = [sort {&{$subname}} @{ $args{input} }];
            is_deeply($res, $args{output_ir}, 'result ir') or diag explain $res;
        };
    };
}

1;
# ABSTRACT: Test Sort::Sub::* subroutine

=head1 FUNCTIONS

=head2 sort_sub_ok(%args) => bool
