package JankenModule;

use strict;
use warnings;
use Exporter 'import';
our @EXPORT_OK = qw(janken);

my $WriteInputPass = 'JankenInput.txt';
my $WriteResultPass = 'JankenResult.txt';

sub jankenGo{
    print "Rock or Paper or Scissors GO!!\n";
    print "Please enter \"r\", \"p\" or \"s\"\n";
};

sub jankenInputWrite{
    my ($input, $pass) = @_;
    open(my $writeInput, '>>', $pass);
    print $writeInput "$input";
    close($writeInput);
};

sub jankenInput{
    my ($input) = @_;
    my %jankenInput = (
        "r" => "Rock\n",
        "p" => "Paper\n",
        "s" => "Scissors\n"
    );
    my $jankenInputName = $jankenInput{$input};
    jankenInputWrite($jankenInputName, $WriteInputPass);
    return $jankenInputName;
};

sub removeFile{
    my ($pass) = @_;
    # ファイルを空にする
    open(my $fh, '>', $pass) or die "Could not open file: $!";
    close($fh);
}

sub removeHistory{
    removeFile($WriteInputPass);
    removeFile($WriteResultPass);
}

sub janken {
    jankenGo();

    # じゃんけんを入力
    print "Enter your choice (r, p, s): ";
    my $myChoice = <STDIN>;
    chomp($myChoice);  # 改行を削除

    # 履歴削除が選択された場合
    if ($myChoice eq "h") {
        print "Are you sure you want to delete your history? \"y\" or \"n\": ";
        my $is = <STDIN>;
        chomp($is);  # 改行を削除
        if ($is eq "y") {
            removeHistory();
            reJanken();
        } else {
            print "History deletion canceled.\n";
        }
        return;  # 履歴削除の場合は処理を終了
    }

    # カウントが選択された場合
    if ($myChoice eq "c") {
        countJanken();
        countResult();
        reJanken();
        return; 
    }

    # ループが選択された場合
    if ($myChoice eq "roop") {
        print "How match roop?: ";
        my $roop = <STDIN>;
        chomp($roop);  # 改行を削除
        for100($roop);
        reJanken();
        return; 
    }

    # じゃんけん内容を数字に変換
    my %jankenData = (
        "r" => 0,
        "p" => 1,
        "s" => 2
    );

    # 入力が正しいか確認
    unless (exists $jankenData{$myChoice}) {
        print "Invalid choice! Please enter 'r', 'p', or 's'.\n";
        return;  # 不正な入力の場合は処理を終了
    }

    # じゃんけん内容を書き込み
    jankenInput($myChoice);

    # じゃんけんの勝ち負けを判別
    my $me = $jankenData{$myChoice};
    my $ememy = int(rand(3));  # 敵の選択を整数に変換
    my $result;

    if ($me == $ememy) {
        $result = "Draw\n";
    } elsif (($me == 0 && $ememy == 1) || ($me == 1 && $ememy == 2) || ($me == 2 && $ememy == 0)) {
        $result = "You Win!\n";
    } else {
        $result = "You Lose!\n";
    }

    jankenInputWrite($result, $WriteResultPass);
    print $result;
    reJanken();
}

sub reJanken{
    print "---------------------\n";
    print "Would I do it again? \"y\" or \"n\": ";
    my $is = <STDIN>;
    chomp($is);  # 改行を削除
    if ($is eq "y") {
        janken();
    } else {
        print "Good bye...\n";
    }
    return; 
}

sub count{
    # カウント
    my ($pass, %wordCount) = @_;
    open(my $fh, '<', $pass) or die "Could not open file: $!";

    

    while (my $line = <$fh>) {
        chomp $line;
        my @words = split(/\s+/, $line);
        foreach my $word (@words) {
            # 句読点を除去
            $word =~ s/[.,!?]//g;  

            # 特定の単語のみカウント
            if (exists $wordCount{$word}) {
                $wordCount{$word}++;
            }
        }
    }
    close($fh);

    # 結果を表示
    foreach my $word (keys %wordCount) {
        print "$word: $wordCount{$word}\n";
    }

}

sub countJanken{
    print "The hand you put out: \n";
    my %wordCount = (
        "Rock" => 0,
        "Paper" => 0,
        "Scissors" => 0
    );
    count($WriteInputPass, %wordCount)
}

sub countResult{
    print "Your win or loss: \n";
    my %wordCount = (
        "Win" => 0,
        "Lose" => 0,
        "Draw" => 0
    );
    count($WriteResultPass, %wordCount)
}

# 100回のじゃんけんを自動で行う
sub for100{
    my ($roop) = @_;
    for (my $i = 0; $i < $roop; $i++) {
        my @choices = qw(r p s);
        my $myChoice = $choices[int(rand(3))];
        jankenInput($myChoice);
        my %jankenData = (
            "r" => 0,
            "p" => 1,
            "s" => 2
        );
        my $me = $jankenData{$myChoice};
        my $ememy = int(rand(3));
        my $result;

        if ($me == $ememy) {
            $result = "Draw\n";
        } elsif (($me == 0 && $ememy == 1) || ($me == 1 && $ememy == 2) || ($me == 2 && $ememy == 0)) {
            $result = "You Win!\n";
        } else {
            $result = "You Lose!\n";
        }
        
        jankenInputWrite($result, $WriteResultPass);
    }

    # n + 1回目の入力として「c」を入力
    jankenInput('c');
    countJanken();
    countResult();
};