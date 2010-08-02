package My::List::Node;
use strict;
use warnings;
use base qw(Class::Accessor::Fast);

__PACKAGE__->mk_accessors(qw(value next));

sub new {
    my ($self, $value) = @_;

    $self->SUPER::new({value => $value});
}

sub connect {
    my ($self, $node) = @_;
    $self->next($node);
    $self;
}

1;
