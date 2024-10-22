#!/usr/bin/perl
use strict;
use warnings;
use Text::CSV;
use open ':std', ':encoding(UTF-8)';  # 標準出力と標準入力をUTF-8に設定
use Encode qw(encode decode);          # エンコーディング変換のためのモジュール

# ファイルのパス
my $txt_file = $ARGV[0];
my $csv_file = $ARGV[1];

# CSVのライターを作成
my $csv = Text::CSV->new({ binary => 1, eol => $/ });

# TXTファイルをUTF-8で読み込み、CSVファイルを書き込む
open my $txt_fh, '<:encoding(UTF-8)', $txt_file or die "Could not open '$txt_file' $!\n";
open my $csv_fh, '>:encoding(UTF-8)', $csv_file or die "Could not open '$csv_file' $!\n";

while (my $line = <$txt_fh>) {
    chomp $line;

    # 句読点を排除
    $line =~ s/[、。！？]/ /g;  # 日本語の句読点をスペースに置き換え
    $line =~ s/[^\w\s]//g;      # その他の句読点を削除（単語と空白以外）

    # スペース区切りをCSVフォーマットに変換
    my @fields = split ' ', $line;
    $csv->print($csv_fh, \@fields);  # CSVに書き出し
}

close $txt_fh;
close $csv_fh;

print "TXTからCSVへの変換が完了しました。\n";
