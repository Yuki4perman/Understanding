package workModule;

use strict;
use warnings;
use Exporter 'import';
our @EXPORT_OK = qw(work);
use utf8;  # UTF-8をサポートするために追加
use open ':std', ':encoding(UTF-8)';  # 標準出力をUTF-8に設定
use Time::HiRes qw(sleep);

sub work{
    my $money;

    print "チャリん！\n";
    my $baseMoney = random(100) + 50;
    sleep(1); 
    print "きゅいん！！\n";
    $baseMoney = luck($baseMoney);
    sleep(0.5); 
    print "きゅいぃぃん！！\n";
    $baseMoney = luck($baseMoney);
    sleep(0.7); 
    print "きゅいんきゅいん！！！！\n";
    $baseMoney = luck($baseMoney);
    sleep(1); 
    print "ぎゅわんぎゅわんぎゅわん！！！！！！\n";
    $baseMoney = luck($baseMoney);
    
    if(random(30) eq 7){
        sleep(3); 
        print "！！！！！！確変！！！！！！！！\n";
        $baseMoney *= 7;
    }
    return int($baseMoney + 0.5);

}

sub random{
    my ($r) = @_;
    my $random = int(rand($r));
    return $random;
}

sub randomMultiplicationRate{
    my $random_number = sprintf("%.1f", rand());  
    return $random_number;
}

sub luck{
    my ($baseMoney) = @_;
    my $rate = randomMultiplicationRate() + 1;
    my $random = random(10);
    if(($random % 2) eq 0){
        return $baseMoney * $rate;
    } else {
        return $baseMoney / $rate;
    }
}