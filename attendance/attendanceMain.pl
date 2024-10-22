use strict;
use warnings;
use DBI;

# データベース接続設定
my $dbname = "PerlTestDB";
my $host = "localhost";
my $port = "5432";  # デフォルトのPostgreSQLポート
my $user = "postgres";
my $password = "password";

# DBIを使ってPostgreSQLに接続
my $dsn = "dbi:Pg:dbname=$dbname;host=$host;port=$port";
my $dbh = DBI->connect($dsn, $user, $password, { RaiseError => 1, AutoCommit => 1 })
    or die $DBI::errstr;
print "Connected to the database successfully!\n";

# ユーザー入力
print "ようこそ！\n";
print "あなたのIDを教えてください: ";
my $userId = <STDIN>;
chomp($userId);  # 改行を削除

# user検索
my $checkUserSql = "SELECT * FROM member_manager WHERE user_id = ?";
my $sth = $dbh->prepare($checkUserSql);
$sth->execute($userId);

# 結果の取得
my @row = $sth->fetchrow_array;

if (@row) {
    # member検索
    my $memberSql = "SELECT * FROM member WHERE member_id = ?";
    my $sth_member = $dbh->prepare($memberSql);
    $sth_member->execute($row[0]);

    my @member = $sth_member->fetchrow_array;
    if (@member) {
        print "$member[1] $member[2]さんこんにちは！\n";
    } else {
        print "メンバーが見つかりません。\n";
    }

    # クリーンアップ
    $sth_member->finish();
} else {
    print "メンバーが見つかりません。\n IDを確認してください ID=$userId\n";
}

# クリーンアップ
$sth->finish();
$dbh->disconnect();

print "Disconnected from the database.\n";
