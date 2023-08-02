## no critic: TestingAndDebugging::RequireUseStrict
package Sub::Sort;

#use 5.010001;
use parent qw(Sort::Sub);

1;
# ABSTRACT: Dummy module to catch Sort::Sub typo
