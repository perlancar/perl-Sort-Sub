#!perl

use 5.010;
use strict;
use warnings;

use Test::More 0.98;
require Sort::Sub;

our $naturally;

Sort::Sub->import('$naturally');
is_deeply([sort $naturally qw(t1.mp3 T10.mp3 t2.mp3)], [qw/T10.mp3 t1.mp3 t2.mp3/]);
Sort::Sub->import('$naturally<i>');
is_deeply([sort $naturally qw(t1.mp3 T10.mp3 t2.mp3)], [qw/t1.mp3 t2.mp3 T10.mp3/]);
Sort::Sub->import('$naturally<ir>');
is_deeply([sort $naturally qw(t1.mp3 T10.mp3 t2.mp3)], [qw/T10.mp3 t2.mp3 t1.mp3/]);

done_testing;
