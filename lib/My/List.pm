package My::List;
use strict;
use warnings;
use base qw(Class::Accessor::Fast);
use My::List::Iterator;
use My::List::Node;

__PACKAGE__->mk_accessors(qw(root last));

sub new {
    my ($self) = @_;

    my $node = My::List::Node->new;
    $self->SUPER::new({
        root => $node,
        last => $node,
    });
}

sub append {
    my ($self, $value) = @_;

    my $new_node = My::List::Node->new($value);
    $self->last->connect($new_node);
    $self->last($new_node);
    $self;
}

sub iterator {
    my ($self) = @_;
    My::List::Iterator->new($self->root);
}

1;
