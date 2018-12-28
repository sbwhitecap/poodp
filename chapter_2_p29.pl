{
    package Wheel;
    use Class::Struct (
        rim => '$',
        tire => '$'
    );
}
{
    package RevealingReferences;
    use Mouse;

    has wheels => (
        is => 'ro',
        writer => '_set_wheels'
    );

    around BUILDARGS => sub {
        my $orig = shift;
        my $class = shift;

        if (@_ == 1 && ref($_[0]) eq 'ARRAY') {
            return $class->$orig(data => $_[0]);
        }

        $class->$orig(@_);
    };

    sub BUILD {
        my $self = shift;
        my $args = shift;

        $self->_set_wheels($self->wheelify($args->{data}));
    }

    sub diameters {
        my $self = shift;

        my @diameters = map {
            $self->diameter($_)} @{$self->wheels};
        \@diameters;
    }

    sub diameter {
        my $self = shift;
        my $wheel = shift;

        $wheel->rim + ($wheel->tire * 2);
    }

    sub wheelify {
        my $self = shift;
        my $data = shift;

        my @wheels = map {
            Wheel->new(rim  => $_->[0],
                       tire => $_->[1]); } @{$data};
        \@wheels;
    }
}

use feature 'say';
use Data::Dumper;

say Dumper(RevealingReferences->new([[52, 11], [30, 27]])->diameters);
