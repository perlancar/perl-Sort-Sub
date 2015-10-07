#!perl

use 5.010;
use strict;
use warnings;

use Test::More 0.98;
require Sort::Sub;

our $num_then_ascii;

Sort::Sub->import('$num_then_ascii');
is_deeply([sort $num_then_ascii qw(1 2 -3 a B C d)], [qw/-3 1 2 B C a d/]);
Sort::Sub->import('$num_then_ascii<i>');
is_deeply([sort $num_then_ascii qw(1 2 -3 a B C d)], [qw/-3 1 2 a B C d/]);
Sort::Sub->import('$num_then_ascii<ir>');
is_deeply([sort $num_then_ascii qw(1 2 -3 a B C d)], [qw/d C B a 2 1 -3/]);

done_testing;
