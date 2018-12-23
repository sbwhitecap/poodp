package Wheel;
use Class::Struct (
    rim => '$',
    tire => '$'
);

sub diameter {
    my $self = shift;

    $self->rim + ($self->tire * 2);
}

1;

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
has _rim => (
    is => 'ro',
    required => 1,
    init_arg => 'rim'
);
has _tire => (
    is => 'ro',
    required => 1,
    init_arg => 'tire'
);
has wheel => (
    is => 'ro',
    lazy => 1,
    builder => '_build_wheel'
);

sub _build_wheel {
    my $self = shift;
    Wheel->new(rim => $self->_rim, tire => $self->_tire);
}

sub ratio {
    my $self = shift;
    $self->chainring / $self->cog;
}

sub gear_inches {
    my $self = shift;
    $self->ratio * $self->wheel->diameter;
}

1;

package main;
use feature 'say';

use Data::Dumper;

say Gear->new(chainring => 52, cog => 11, rim => 26, tire => 1.5)->gear_inches;
