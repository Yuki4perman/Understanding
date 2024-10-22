#!/usr/bin/perl
use strict;
use warnings;

# 入力ファイルのパス
my $csv_file = $ARGV[0];
# 出力ファイルのパス
my $output_file = $ARGV[1];

# 集計用のハッシュ
my %count;

# CSVファイルを開いて集計
open my $fh, '<', $csv_file or die "Could not open '$csv_file' $!\n";

while (my $line = <$fh>) {
    chomp $line;
    # 要素をカウント
    $count{$line}++;
}

close $fh;

# 集計結果をCSVファイルに書き込む
open my $out_fh, '>', $output_file or die "Could not open '$output_file' $!\n";

# ヘッダーを書き込む
print $out_fh "Element,Count\n";

# 集計結果を書き込む
foreach my $element (sort keys %count) {
    print $out_fh "$element,$count{$element}\n";
}

close $out_fh;

print "集計結果を'$output_file'に保存しました。\n";
