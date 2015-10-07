#!perl

use 5.010;
use strict;
use warnings;
use FindBin '$Bin';
use lib "$Bin/lib";

use Local::TestLib;
use Test::More 0.98;

sort_sub_ok(
    subname   => 'naturally',
    input     => [qw(t1.mp3 T10.mp3 t2.mp3)],
    output    => [qw/T10.mp3 t1.mp3 t2.mp3/],
    output_i  => [qw/t1.mp3 t2.mp3 T10.mp3/],
    output_ir => [qw/T10.mp3 t2.mp3 t1.mp3/],
);

done_testing;
