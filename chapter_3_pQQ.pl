{
    package SomeFramework::Gear;
    use Mouse;

    has chainring =>
        ( is => 'ro'
        , required => 1
        );
    has cog =>
        ( is => 'ro'
        , required => 1
        );
    has wheel =>
        ( is => 'ro'
        , required => 1
        );

    sub gear_inches {
        my $self = shift;
        $self->ratio * $self->wheel->diameter;
    }

    sub ratio {
        my $self = shift;
        $self->chainring / $self->cog;
    }
}
{
    package Wheel;
    use Mouse;

    has rim =>
        ( is => 'ro'
        , required => 1
        );
    has tire =>
        ( is => 'ro'
        , required => 1
        );

    sub diameter {
        my $self = shift;
        $self->rim + ($self->tire * 2);
    }
}
{
    package GearWrapper;
    use Mouse;

    sub gear {
        my $class = shift;
        my %args = @_;
        SomeFramework::Gear->new(chainring => $args{chainring}
                                ,cog => $args{cog}
                                ,wheel => $args{wheel}
                                );
    }
}

use feature 'say';

say GearWrapper->gear(chainring => 52
                     ,cog => 11,
                     ,wheel => Wheel->new(rim => 26, tire => 1.5))->gear_inches;
