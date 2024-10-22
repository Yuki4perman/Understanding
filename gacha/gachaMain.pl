use strict;
use warnings;
use lib 'c:\\Perl\\practice\\gacha\\GachaLogic';  # モジュールが同じディレクトリにある場合
use gachaModule qw(gacha_draw);  # モジュールの読み込み
use lib 'c:\\Perl\\practice\\gacha\\BoxLogic';  # モジュールが同じディレクトリにある場合
use BoxViewModule qw(BoxView);
use lib 'c:\\Perl\\practice\\gacha\\WorkLogic';  # モジュールが同じディレクトリにある場合
use workModule qw(work);
use utf8;  # UTF-8をサポートするために追加
use open ':std', ':encoding(UTF-8)';  # 標準出力をUTF-8に設定

print "何をする？ ";
print " boxを見る \"b\"";
print " gachaを引く \"g\"";
print " workをする \"w\"";
print ": ";
my $select1 = <STDIN>;
chomp($select1);  # 改行を削除
if($select1 eq "gacha" || $select1 eq "Gacha" || $select1 eq "g"){
    gachaCheck();
} elsif($select1 eq "Box" || $select1 eq "box" || $select1 eq "b"){
    BoxView();
} elsif($select1 eq "Work" || $select1 eq "work" || $select1 eq "w"){
    my $money = moneyRead();
    my $getMoney = work();
    print "$getMoney z 手に入れた！\n";
    moneyUpdate($money + $getMoney);
}

sub moneyUpdate{
    my ($updateMoney) =@_;
    my $pass = 'C:/Perl/practice/gacha/money.txt';
    
    open(my $writeMoney, '>', $pass) or die "Could not open file!";
    print $writeMoney $updateMoney;
    close($writeMoney);
}

sub moneyRead{
    my $pass = 'C:/Perl/practice/gacha/money.txt';
    open(my $readMoney, '<', $pass) or die "Could not open file!";
    my $money = <$readMoney>; 
    close($readMoney);
    return $money;
}
sub gachaCheck{
    my $money = moneyRead();
    if($money < 160){
        print "moneyが160必要です。\n";
        print "仕事をしますか？ y or n: \n";
        my $select2 = <STDIN>;
        chomp($select2);  # 改行を削除
        if($select2 eq "y"){
            my $getMoney = work();
            print "$getMoney z 手に入れた！\n";
            moneyUpdate($money + $getMoney);
        }
    } else {
        print "moneyを160消費して、1回ガチャを引きます。。。\n";
        $money -= 160;
        moneyUpdate($money);
        gacha_draw();
    }
}