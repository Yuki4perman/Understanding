# おみくじ出力システム
use strict;
use warnings;
use utf8;
use List::Util qw(shuffle);
binmode( STDOUT, ':encoding(UTF-8)' );    # 標準出力をUTF-8に設定
binmode( STDIN,  ':encoding(UTF-8)' );    # 標準入力をUTF-8に設定
binmode( STDERR, ':encoding(UTF-8)' );    # 標準エラー出力をUTF-8に設定

#出力結果を定義
our $result;

# 参加可否を確認
sub suggest {
    print "今日のあなたの運勢を占いますか？ y/n\n";
    for ( ; ; ) {

        # 入力受付
        my $input = <STDIN>;

        # 参加可否分岐
        if ( $input =~ /y/i || $input =~ /yes/i ) {    # yかyesの場合(大小を問わない)
            print "それでは始めましょう！\n";
            last;                                      # ループ開放
        }
        if ( $input =~ /n/i || $input =~ /no/i ) {     # nかnoの場合(大小を問わない)
            print "またの機会に\n";
            exit(0);                                   # 正常終了
        }
        else {
            print "yかnで入力してください\n";
        }
    }
}

# ロード処理
sub show_loading {
    use Time::HiRes qw(sleep);             # 高度なsleep関数を使用
    $| = 1;                                # バッファリング無効化
    my ( $load_message, $second ) = @_;    #引数設定

    print $load_message;
    for ( 1 .. $second ) {
        print "・";
        sleep(0.8);
    }
    print "\n";
}

# 占い出力処理
sub create_omikuji {

    #運勢
    my %luck = (
        "大吉" => 50,
        "吉"  => 40,
        "中吉" => 30,
        "小吉" => 20,
        "末吉" => 10,
        "凶"  => 5,
        "大凶" => 3
    );

    #天候
    my %luck_weather = (
        "快晴"   => 10,
        "晴れ"   => 8,
        "曇り"   => 5,
        "にわか雨" => 3,
        "土砂降り" => 0
    );

    #金運
    my %luck_money = (
        "思わぬ収入" => 10,
        "意外な節約" => 8,
        "計算通り"  => 5,
        "思わぬ支出" => 3,
        "大赤字"   => 0
    );

    #健康
    my %luck_health = (
        "高い集中力" => 10,
        "無病息災"  => 8,
        "眠気のみ"  => 5,
        "風邪気味"  => 3,
        "大病を患う" => 0
    );

    #住居
    my %luck_house = (
        "新たな施設"  => 10,
        "家賃引き下げ" => 8,
        "エコな暮らし" => 5,
        "怪しげな隣人" => 3,
        "引っ越し"   => 0
    );

    #学問
    my %luck_study = (
        "新たな資格"  => 10,
        "新たな知識"  => 8,
        "学ぶ意欲"   => 5,
        "知識欲の不足" => 3,
        "忘却"     => 0
    );

    # 運勢をランダムに選ぶ
    my @fortunes = keys %luck;                     # ハッシュのキーを配列に格納
    my $fortune  = $fortunes[ rand @fortunes ];    # 配列からランダムに一つ選ぶ

    my $points = $luck{$fortune};

    # 合計点に基づいてランダムに項目を選ぶ
    sub choose_random {
        my ( $hash_ref, $max_points ) = @_;    #引数にハッシュと最大ポイントを設定
        my @choices      = keys %$hash_ref;    #ハッシュを配列に詰め替え
        my $total_points = 0;

        # 合計点を超えず、かつ合計点から5ポイント下回らないようにフィルタリング
        my @valid_choices = grep {
            $total_points + $hash_ref->{$_} <= $max_points

   # && $total_points + $hash_ref->{$_} >= $max_points - 5 #不具合有り？大凶など以外はバグが発生する
        } @choices;

        # ランダムに選択
        return $valid_choices[ rand @valid_choices ];
    }

    # 各項目の内容をランダムに選択
    my $weather = choose_random( \%luck_weather, $points );
    my $money   = choose_random( \%luck_money,   $points );
    my $health  = choose_random( \%luck_health,  $points );
    my $house   = choose_random( \%luck_house,   $points );
    my $study   = choose_random( \%luck_study,   $points );

    #結果を変数に格納
    $result = "\n運勢：$fortune\n 健康：$health\n 金運：$money\n 住居：$house\n 天候：$weather\n 学問：$study\n";
}

# ファイル書き込み処理
sub output_file {

    # 現在時刻を取得してフォーマット
    my ( $sec, $min, $hour, $mday, $mon, $year ) = localtime();
    $year += 1900;    # 年は1900年からの経過年数として取得されるので調整
    $mon  += 1;       # 月は0から始まるので1を加算

    # フォーマットされた時刻をファイル名に使用
    my $locatetime = sprintf( "%04d%02d%02d%02d%02d%02d", $year, $mon, $mday, $hour, $min, $sec );

    # ファイルの書き込み処理
    open( my $fh, '>:encoding(UTF-8)', "omikuji_$locatetime.txt" ) or die "ファイルの書き込みに失敗しました: $!";

    # 結果を書き込む
    print $fh $result;
    close($fh);

    print "ファイルを出力しました！\n";
}

# 処理を実行
suggest();
show_loading( "占い中", "3" );
create_omikuji();
print "$result\n";
show_loading( "ファイル出力中", "5" );
output_file();
