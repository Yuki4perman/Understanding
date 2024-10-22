package BoxViewModule;

use strict;
use warnings;
use Text::CSV;
use POSIX qw(strftime);
use Exporter 'import';
our @EXPORT_OK = qw(BoxView);
use utf8;  # UTF-8をサポートするために追加
use open ':std', ':encoding(UTF-8)';  # 標準出力をUTF-8に設定


sub BoxView {
    # CSVファイルのパス
    my $csv_file = 'c:\\Perl\\practice\\gacha\\Data\\MonsterBox.csv';

    # CSVリーダーの作成
    my $csv = Text::CSV->new({ binary => 1, auto_diag => 1 });

    # ファイルを開く
    open my $fh, '<:encoding(utf8)', $csv_file or die "Could not open '$csv_file': $!";

    # ヘッダーを表示
    print "所持モンスター　　レア度　　　仲間になった日\n";
    print "-------------------------------\n";

    # CSVの各行を処理
    while (my $row = $csv->getline($fh)) {
        my ($charaName, $charaRare, $joinedAt) = @$row;

        # 仲間になった日を整形
        my ($date) = $joinedAt =~ /(\d{4}-\d{2}-\d{2})/;  # YYYY-MM-DDの部分を取得
        my ($year, $month, $day) = split /-/, $date;  # 年、月、日を分割
        my $formatted_date = sprintf("%d月%d日", $month, $day);  # フォーマットを整形

        # 表示
        printf "%-24s %-12s %s\n", $charaName, $charaRare, $formatted_date;

    }

    # ファイルを閉じる
    close $fh;
}

1;  # モジュールの終わりには真を返す
