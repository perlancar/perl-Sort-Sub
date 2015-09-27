#!perl

# test request sub

use 5.010;
use strict;
use warnings;

use Test::More 0.98;
use Sort::Sub qw(naturally<i>);

is_deeply([sort {naturally} qw(t1.mp3 T10.mp3 t2.mp3)], [qw/t1.mp3 t2.mp3 T10.mp3/]);

done_testing;
