#!/usr/bin/perl
use strict;
use warnings;

# サブルーチン定義
sub greet {
    my ($name, $name2) = @_;
    return "Hello, $name! and $name2!";
}

sub clac_plus{
    my ($cal1, $cal2) = @_;
    return $cal1 + $cal2;
}

# サブルーチンを呼び出す
my $greeting = greet("Alice", "Kevin");
print "$greeting\n";

my $cal1 = 1;
my $cal2 = 5;
my $sum = clac_plus($cal1, $cal2);
print "$cal1 + $cal2 = $sum!"