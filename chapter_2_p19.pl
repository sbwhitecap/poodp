{
    package Gear;
    use Mouse;

    has chainring => (
        is => 'ro',
        required => 1
    );

    has cog => (
        is => 'ro',
        required => 1
    );

    sub ratio {
        my $self = shift;
        $self->chainring / $self->cog;
    }
}

use feature 'say';

say Gear->new(chainring => 52, cog => 11)->ratio;
say Gear->new(chainring => 30, cog => 27)->ratio;
