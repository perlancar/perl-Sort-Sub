package Sort::Sub::first_num_in_text;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;
require Sort::Sub::num_in_text;
*gen_sorter = \&Sort::Sub::num_in_text::gen_sorter;

1;
# ABSTRACT: Alias for Sort::Sub::num_in_text

=for Pod::Coverage ^(gen_sorter)$

=head1 append:SEE ALSO

L<Sort::Sub::num_in_text>
