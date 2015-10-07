#!perl

use 5.010;
use strict;
use warnings;
use FindBin '$Bin';
use lib "$Bin/lib";

use Local::TestLib;
use Test::More 0.98;

sort_sub_ok(
    subname   => 'num_then_ascii',
    input     => [qw(1 2 -3 a B C d)],
    output    => [qw/-3 1 2 B C a d/],
    output_i  => [qw/-3 1 2 a B C d/],
    output_ir => [qw/d C B a 2 1 -3/],
);

done_testing;
