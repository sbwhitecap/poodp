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
    has rim => (
        is => 'ro',
        required => 1,
    );
    has tire => (
        is => 'ro',
        required => 1
    );
    has wheel => (
        is =>'ro',
        lazy => 1,
        builder => '_build_wheel'
    );

    sub _build_wheel {
        my $self = shift;
        Wheel->new(rim => $self->rim, tire => $self->tire);
    }

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

say Gear->new(chainring => 52, cog => 11, rim => 26, tire => 1.5)->gear_inches;
