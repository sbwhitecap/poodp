use strict;
use warnings;
use autodie;
use feature 'say';

my $chainring = 52; # number of teeth
my $cog       = 11;
my $ratio     = $chainring / $cog;
say $ratio;

$chainring    = 30;
$cog          = 27;
$ratio        = $chainring / $cog;
say $ratio;
