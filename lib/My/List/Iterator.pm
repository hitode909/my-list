package My::List::Iterator;
use strict;
use warnings;
use base qw(Class::Accessor::Fast);
use Carp qw(croak);
use Params::Validate;

__PACKAGE__->mk_accessors(qw(node));

sub new {
    my ($self, $node) = @_;

    $self->SUPER::new({node => $node});
}

sub has_next {
    my ($self) = @_;
    !!($self->node && $self->node->next);
}

sub next {
    my ($self) = @_;
    croak 'check has_next first' unless $self->has_next;
    $self->node($self->node->next);
}

1;
