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

    has rim => (
        is => 'ro',
        required => 1
    );

    has tire => (
        is => 'ro',
        required => 1
    );

    sub ratio {
        my $self = shift;
        $self->chainring / $self->cog;
    }

    sub gear_inches {
        my $self = shift;

        $self->ratio * ($self->rim + ($self->tire * 2))
    }
}

use feature 'say';

say Gear->new(chainring => 52, cog => 11, rim => 26, tire => 1.5)->gear_inches;
say Gear->new(chainring => 52, cog => 11, rim => 24, tire => 1.25)->gear_inches;
