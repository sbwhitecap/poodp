{
    package Gear;
    use Mouse;

    has chainring => (
        is => 'ro',
        required => 1
    );
    has cog => (
        is => 'ro',
        required => 1,
    );
    has wheel => (
        is =>'ro'
    );

    sub ratio {
        my $self = shift;
        $self->chainring / $self->cog;
    }

    sub gear_inches {
        my $self = shift;
        $self->ratio * $self->wheel->diameter;
    }
}
{
    package Wheel;
    use Mouse;

    use Math::Trig ':pi';

    has rim => (
        is => 'ro',
        required => 1
    );
    has tire => (
        is => 'ro',
        required => 1
    );

    sub diameter {
        my $self = shift;
        $self->rim + ($self->tire * 2);
    }

    sub circumference {
        my $self = shift;
        $self->diameter * pi;
    }
}

use feature 'say';

my $wheel = Wheel->new(rim => 26, tire => 1.5);
say $wheel->circumference;
say Gear->new(chainring => 52, cog => 11, wheel => $wheel)->gear_inches;
say Gear->new(chainring => 52, cog => 11)->ratio;
