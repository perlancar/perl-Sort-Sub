package Sort::Sub::by_first_num_in_text;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;
require Sort::Sub::by_num_in_text;
*gen_sorter = \&Sort::Sub::by_num_in_text::gen_sorter;

1;
# ABSTRACT: Alias for Sort::Sub::by_num_in_text

=for Pod::Coverage ^(gen_sorter)$

=head1 append:SEE ALSO

L<Sort::Sub::by_num_in_text>
