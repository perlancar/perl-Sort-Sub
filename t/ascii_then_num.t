#!perl

use 5.010;
use strict;
use warnings;

use Test::More 0.98;
require Sort::Sub;

our $ascii_then_num;

Sort::Sub->import('$ascii_then_num');
is_deeply([sort $ascii_then_num qw(1 2 -3 a B C d)], [qw/B C a d -3 1 2/]);
Sort::Sub->import('$ascii_then_num<i>');
is_deeply([sort $ascii_then_num qw(1 2 -3 a B C d)], [qw/a B C d -3 1 2/]);
Sort::Sub->import('$ascii_then_num<ir>');
is_deeply([sort $ascii_then_num qw(1 2 -3 a B C d)], [qw/2 1 -3 d C B a/]);

done_testing;
