package test::My::List::Iterator;
use strict;
use warnings;
use base qw(Test::Class);
use Test::More;
use Test::Exception;
use My::List::Iterator;
use My::List::Node;

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

sub constructor : Test(1) {
    my ($self) = @_;
    my $iter = My::List::Iterator->new($self->list_of_length(3));
    ok $iter->has_next, 'コンストラクタでnodeを渡せる';
}

sub next : Test(8) {
    my ($self) = @_;

    my $length = 3;
    my $iter = My::List::Iterator->new($self->list_of_length($length));

    foreach (1..$length) {
        ok $iter->has_next, "$length回has_nextある";
        ok $iter->next, "$length回nextある";
    }
    ok !$iter->has_next, 'もうhas_nextない';

    throws_ok { $iter->next } qr/check has_next first/, 'nextないのにnext呼ぶと死ぬ';

}

__PACKAGE__->runtests;

1;
