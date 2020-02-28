## no critic: Modules::ProhibitAutomaticExportation

package Test::Sort::Sub;

# AUTHORITY
# DATE
# DIST
# VERSION

use 5.010001;
use strict 'subs', 'vars';
use warnings;

use Exporter 'import';
use Sort::Sub ();
use Test::More 0.98;

our @EXPORT = qw(sort_sub_ok);

sub _sort {
    my ($args, $extras, $output_name) = @_;

    my $subname = $args->{subname};
    Sort::Sub->import("$subname$extras", ($args->{args} ? $args->{args} : ()));
    my $res;
    if ($args->{compares_record}) {
        $res = [map {$_->[0]} sort {&{$subname}($a,$b)}
                    (map { [$args->{input}[$_], $_] } 0..$#{ $args->{input} })];
    } else {
        $res = [sort {&{$subname}($a,$b)} @{ $args->{input} }];
    }
    is_deeply($args->{$output_name}, $res) or diag explain $res;
}

sub sort_sub_ok {
    my %args = @_;

    my $subname = $args{subname};
    subtest "sort_sub_ok $subname" => sub {
        my $res;

        if ($args{output}) {
            _sort(\%args, '', 'output');
        }

        if ($args{output_i}) {
            _sort(\%args, '<i>', 'output_i');
        }

        if ($args{output_r}) {
            _sort(\%args, '<r>', 'output_r');
        };

        if ($args{output_ir}) {
            _sort(\%args, '<ir>', 'output_ir');
        };
    };
}

1;
# ABSTRACT: Test Sort::Sub::* subroutine

=head1 FUNCTIONS

=head2 sort_sub_ok(%args) => bool
