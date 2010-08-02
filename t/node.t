package test::My::List::Node;
use strict;
use warnings;
use base qw(Test::Class);
use Test::More;
use My::List::Node;

sub init : Test(1) {
    new_ok 'My::List::Node';
}

sub value : Test(4) {
    foreach  my $value (1, 'Hello', [1,2,3,4,5], {name => 'hitode', age => 21}) {
        my $node = My::List::Node->new($value);
        is_deeply $node->value, $value, 'value正しい';
    }
}

sub connect_next : Test(7) {
    my $root = My::List::Node->new(1);
    ok !$root->next, '$rootは最初nextない';
    my $next = My::List::Node->new(2);
    ok $root->connect($next), '$nextをconnectできる';
    ok $root->next, '$rootのnextある';
    is $root->next, $next, '$rootのnextは$nextである';
    is $root->value, 1, '$rootの値は1';
    is $root->next->value, 2, '$root->nextの値は2';
    ok !$root->next->next, '$nextのnextない';
}

__PACKAGE__->runtests;

1;
