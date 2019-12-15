package Sort::Sub;

# AUTHORITY
# DATE
# DIST
# VERSION

use 5.010001;
use strict 'subs', 'vars';
use warnings;

our $re_spec = qr/\A(\$)?(\w+)(?:<(\w*)>)?\z/;

our %argsopt_sortsub = (
    sort_sub => {
        summary => 'Name of a Sort::Sub::* module (without the prefix)',
        schema => ['sortsub::spec*'],
    },
    sort_args => {
        summary => 'Arguments to pass to the Sort::Sub::* routine',
        schema => ['hash*', of=>'str*'],
    },
);

sub get_sorter {
    my ($spec, $args) = @_;

    my ($is_var, $name, $opts) = $spec =~ $re_spec
        or die "Invalid sorter spec '$spec', please use: ".
        '[$]NAME [ <OPTS> ]';
    require "Sort/Sub/$name.pm";
    $opts //= "";
    my $is_reverse = $opts =~ /r/;
    my $is_ci      = $opts =~ /i/;
    my $gen_sorter = \&{"Sort::Sub::$name\::gen_sorter"};
    my $sorter = $gen_sorter->($is_reverse, $is_ci, $args // {});
    $sorter;
}

sub import {
    my $class = shift;
    my $caller = caller;

    my $i = -1;
    while (1) {
        $i++;
        last if $i >= @_;
        my $import = $_[$i];
        my $args = {};
        if (ref $_[$i+1] eq 'HASH') {
            $args = $_[$i+1];
            $i++;
        }
        my $sorter = get_sorter($import, $args);
        my ($is_var, $name) = $import =~ $re_spec; # XXX double matching
        if ($is_var) {
            ${"$caller\::$name"} = \&$sorter;
        } else {
            no warnings 'redefine';
            *{"$caller\::$name"} = \&$sorter;
        }
    }
}

1;
# ABSTRACT: Collection of sort subroutines

=head1 SYNOPSIS

 use Sort::Sub qw($naturally);

 my @sorted = sort $naturally ('track1.mp3', 'track10.mp3', 'track2.mp3', 'track1b.mp3', 'track1a.mp3');
 # => ('track1.mp3', 'track1a.mp3', 'track1b.mp3', 'track2.mp3', 'track10.mp3')

Request as subroutine:

 use Sort::Sub qw(naturally);

 my @sorted = sort {naturally} (...);

Request a reverse sort:

 use Sort::Sub qw($naturally<r>);

 my @sorted = sort $naturally (...);
 # => ('track10.mp3', 'track2.mp3', 'track1b.mp3', 'track1a.mp3', 'track1.mp3')

Request a case-insensitive sort:

 use Sort::Sub qw($naturally<i>);

 my @sorted = sort $naturally (...);

Request a case-insensitive, reverse sort:

 use Sort::Sub qw($naturally<ir>);

 my @sorted = sort $naturally ('track2.mp3', 'Track1.mp3', 'Track10.mp3');
 => ('Track10.mp3', 'track2.mp3', 'Track1.mp3')

Pass arguments to sort generator routine:

 use Sort::Sub '$by_num_of_colons', {pattern=>':'};

 my @sorted = sort $by_num_of_colons ('a::','b:','c::::','d:::');
 => ('b:','a::','d:::','c::::')

Request a coderef directly, without using the import interface:

 use Sort::Sub;

 my $naturally = Sort::Sub::get_sorter('naturally');
 my $naturally = Sort::Sub::get_sorter('$naturally');
 my $rev_naturally = Sort::Sub::get_sorter('naturally<r>');


=head1 DESCRIPTION

L<Sort::Sub> and C<Sort::Sub::*> are a convenient packaging of any kind of
subroutine which you can use for C<sort()>.

To use Sort::Sub, you import a list of:

 ["$"]NAME [ "<" [i][r] ">" ]

Where NAME is actually searched under C<Sort::Sub::*> namespace. For example:

 naturally

will attempt to load C<Sort::Sub::naturally> module and call its C<gen_sorter>
subroutine.

You can either request a subroutine name like the above or a variable name (e.g.
C<$naturally>).

After the name, you can add some options, enclosed with angle brackets C<< <>
>>. There are some known options, e.g. C<i> (for case-insensitive sort) or C<r>
(for reverse sort). Some examples:

 naturally<i>
 naturally<r>
 naturally<ri>


=head1 GUIDELINES FOR WRITING A SORT::SUB::* MODULE

The name should be in lowercase. It should be an adverb (e.g. C<naturally>) or a
phrase with words separated by underscore (C<_>) and the phrase begins with
C<by> (e.g. C<by_num_and_non_num_parts>).

The module must contain a C<gen_sorter> subroutine. It will be called with:

 ($is_reverse, $is_ci, $args)

Where C<$is_reserve> will be set to true if user requests a reverse sort,
C<$is_ci> will be set to true if user requests a case-insensitive sort. C<$args>
is hashref to pass additional arguments to the C<gen_sorter()> routine. The
subroutine should return a code reference.

The module should also contain a C<meta> subroutine which returns a metadata
L<DefHash>. Known properties (keys) include: C<v> (currently at 1), C<summary>.
Other metadata properties will be added in the future.


=head1 FUNCTIONS

=head2 get_sorter

Usage:

 my $coderef = Sort::Sub::get_sorter('SPEC');

Example:

 my $rev_naturally = Sort::Sub::get_sorter('naturally<r>');

This is an alternative to using the import interface. This function is not
imported.


=head1 SEE ALSO

Other additional C<Sort::Sub::*> not bundled in this distribution.

Supporting CLI's: L<sortsub> (from L<App::sortsub>), CLI's from
L<App::SortSubUtils>.
