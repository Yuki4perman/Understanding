use strict;
use warnings;

# 配列の操作
my @numbers = (1, 2, 3, 4, 5);
push(@numbers, 6);  # 配列に要素を追加
print "Array: @numbers\n";

# ハッシュの操作
my %fruit_prices = (
    "apple" => 100,
    "banana" => 50,
    "orange" => 70,
);

# ハッシュの値を取得・変更
print "Apple price: $fruit_prices{apple}\n";
$fruit_prices{"apple"} = 120;
print "Updated Apple price: $fruit_prices{apple}\n";


my @people = ("Yuki", "Yuta", "Kai", "Ryousuke", "Tsuyoshi");
push(@people, "Rizu");
print "PeopleArrays: @people\n";

my %height_people = (
    "Yuki" => 167,
    "Yuta" => 170,
    "Kai" => 166,
    "Ryousuke" => 179,
    "Tsuyoshi" => 164,
    "Rizu" => 155,
);

print "Yuki's Height: $height_people{$people[0]}cm\n";
print "Oh my god! It has grown 1cm!\n";
$height_people{$people[0]} += 1;
print "Update Yuki's Height: $height_people{$people[0]}cm\n";