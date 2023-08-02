package Sort::Sub::randomly;

use 5.010001;
use strict;
use warnings;
require Sort::Sub::by_rand;
*gen_sorter = \&Sort::Sub::by_rand::gen_sorter;
*meta       = \&Sort::Sub::by_rand::meta;

# AUTHORITY
# DATE
# DIST
# VERSION

1;
# ABSTRACT: Alias for Sort::Sub::by_rand

=for Pod::Coverage ^(gen_sorter|meta)$

=head1 append:SEE ALSO

L<Sort::Sub::by_rand>
