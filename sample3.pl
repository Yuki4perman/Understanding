#!\Strawberry\perl\bin
use strict;
use warnings;

my $number = 10;

if ($number > 5) {
    print "$number is greater than 5\n";
} else {
    print "$number is less than or equal to 5\n";
}

for (my $i = 0; $i < 5; $i++) {
    print "i = $i\n";
}
