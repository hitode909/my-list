package test::My::List;
use strict;
use warnings;
use base qw(Test::Class);
use Test::More;
use Test::Exception;
use My::List;

sub list_of_length {
    my ($self, $size) = @_;
    my $root = My::List::Node->new(0);
    my $current = $root;
    foreach (1..$size) {
        $current->connect(My::List::Node->new($_));
        $current = $current->next;
    }
    $root;
}

sub init : Test(1) {
    new_ok 'My::List::Iterator';
}

sub append_iterator : Test(16) {
    my ($self) = @_;

    my $list = My::List->new;

    my $length = 3;
    foreach (1..$length) {
        ok $list->append($_), 'appendできる';
    }

    ok my $iter = $list->iterator, 'iterator得られる';
    foreach (1..$length) {
        ok $iter->has_next, "$length回nextできる";
        is $iter->next->value, $_, "$_個目のvalueは$_である";
    }

    ok !$iter->has_next, 'もうnextない';

    ok $iter = $list->iterator, '何度でもiterator得られる';
    foreach (1..$length) {
        is $iter->next->value, $_, "何度やっても$_個目のvalueは$_である";
    }
    ok !$iter->has_next, 'もうnextない';
}

__PACKAGE__->runtests;

1;
