package gachaModule;

use strict;
use warnings;
use Exporter 'import';
our @EXPORT_OK = qw(gacha_draw);
use Text::CSV;
use List::Util 'max';
use Time::HiRes qw(sleep);
use utf8;  # UTF-8をサポートするために追加
use open ':std', ':encoding(UTF-8)';  # 標準入出力をUTF-8で扱う
use Time::Piece;  # 現在時刻を取得するためのモジュール

# モンスターの読み込み
sub MonsterList {
    # CSVファイルのパス
    my $csv_file = 'c:\\Perl\\practice\\gacha\\Data\\MonsterList.csv';

    # CSVリーダーの作成
    my $csv = Text::CSV->new({ binary => 1, auto_diag => 1 });

    # ハッシュの初期化
    my %chara_no_name;
    my %chara_no_rarity;
    my @chara_numbers; # キャラ番号を格納する配列

    # CSVファイルを開く
    open my $fh, '<:encoding(utf8)', $csv_file or die "Could not open '$csv_file': $!";  # UTF-8で開く

    # ヘッダーをスキップ
    my $header = $csv->getline($fh);

    # CSVの各行を処理
    while (my $row = $csv->getline($fh)) {
        my ($cahraNo, $charaName, $charaRare) = @$row; # それぞれの変数に格納
        $chara_no_name{$cahraNo} = $charaName;       # $cahraNoと$charaNameをハッシュに格納
        $chara_no_rarity{$cahraNo} = $charaRare;     # $cahraNoと$charaRareをハッシュに格納
        
        # キャラ番号を数値として扱う
        push @chara_numbers, int($cahraNo);                # キャラ番号を配列に追加
    }

    # ファイルを閉じる
    close $fh;

    # モンスターの情報を返す（キャラ番号、名前、レアリティのハッシュリファレンスを含む）
    return (\@chara_numbers, \%chara_no_name, \%chara_no_rarity);
}

sub gacha {
    # モンスターの読み込み
    my ($chara_numbers_ref, $chara_no_name_ref, $chara_no_rarity_ref) = MonsterList();
    
    # 最大のキャラ番号を取得
    my $max_chara_no = max @$chara_numbers_ref;

    # ガチャを引くための番号を決定（0から$max_chara_no - 1の範囲）
    my $gacha = int(rand($max_chara_no));
    
    my $resultCharaName = $chara_no_name_ref->{$gacha};
    my $resultCharaRare = $chara_no_rarity_ref->{$gacha};
    my @result = ($resultCharaName, $resultCharaRare);
    
    return @result;
}

sub gacha_draw {
    print "ガチャを引いています...\n";
    sleep(1); 
    my @result = gacha();

    my @animation = ('🔄', '🎴', '💥', '✨'); 
    for my $i (1..5) {
        print "\r" . $animation[$i % @animation] . " "; 
        sleep(0.5);  
    }

    addBox(@result);

    # 結果を表示
    print "\rガチャ結果: " . $result[0] . " (★ " . $result[1] . ") をゲットしました！\n"; 
}

sub addBox{
    my (@result) = @_;
    # ガチャ結果をCSVファイルに保存
    
    my $result_file = 'c:\\Perl\\practice\\gacha\\Data\\MonsterBox.csv';
    open my $result_fh, '>>:encoding(UTF-8)', $result_file or die "Could not open '$result_file': $!\n";

    # 現在時刻を取得
    my $current_time = localtime->strftime('%Y-%m-%d %H:%M:%S');

    my $csv = Text::CSV->new({ binary => 1, eol => $/ });
    
    # 結果をCSVに書き込む
    $csv->print($result_fh, [ $result[0], $result[1], $current_time ]);
    
    close $result_fh;
}
